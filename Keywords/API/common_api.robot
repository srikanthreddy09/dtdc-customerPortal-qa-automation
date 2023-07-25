*** Settings ***
Resource          ../../Config/super.robot

*** Keywords ***
Send Request
    [Arguments]    ${request_type}    ${resource_uri}    ${header}=None    ${params_data}=None    ${body}=None
    [Documentation]    This Keyword used to Send the required Request. Using this keyword we can send API methods.
    ...
    ...    Example: ${response} GET url
    ${response}    Run Keyword If    '${request_type}'=='Get'    Get Request    ${leo_session}    ${resource_uri}    headers=${header}    params=${params_data}    data=${body}
    Run Keyword If    '${request_type}'=='Get'    Return From Keyword    ${response}
    ${response}    Run Keyword If    '${request_type}'=='Put'    Put Request    ${leo_session}    ${resource_uri}    data=${body}    headers=${header}    params=${params_data}
    Run Keyword If    '${request_type}'=='Put'    Return From Keyword    ${response}
    ${response}    Run Keyword If    '${request_type}'=='Post'    Post Request    ${leo_session}    ${resource_uri}    data=${body}    headers=${header}    params=${params_data}
    Run Keyword If    '${request_type}'=='Post'    Return From Keyword    ${response}
    ${response}    Run Keyword If    '${request_type}'=='Delete'    Delete Request    ${leo_session}    ${resource_uri}    data=${body}    headers=${header}    params=${params_data}
    [Return]    ${response}

Validate Response Status Code
    [Arguments]    ${actual_status}    ${expected_status}
    [Documentation]    This Keyword used to Validate the Request Response codes.
    ${actual_status}    convert to string    ${actual_status}
    Should Contain    ${actual_status}    ${expected_status}
    Log    Validated successful response code as 200.

Get Authentication Token
    [Arguments]    ${application_code}
    Create Session    ${leo_session}    ${API_BASE_URL}    disable_warnings=1
    ${response}    Authenticate with Vaild Credentials    ${USER_ID}    ${USER_PASWORD}
    Validate Response Status Code    ${response}    201
    ${session_content}    To Json    ${response.content}
    ${session_content_token}    Parse Json Response    ${session_content}    sessionToken
    ${token}    To Json    ${session_content_token}
    Set Global Variable    ${session_token}    ${token}
    Set Global Variable    ${applicationcode}    ${application_code}
    [Return]    ${session_token}

Validate Response Body
    [Arguments]    ${response_content}    ${validate_values}=None    ${expected_value}=None
    [Documentation]    This keyword used to Validate the Request Response Body values.
    ${string_response_content}    Run Keyword If    '${expected_value}'!='None'    convert to string    ${response_content}
    Run Keyword If    '${expected_value}'!='None'    Should Contain    ${string_response_content}    ${expected_value}
    Run Keyword If    '${expected_value}'!='None'    Return From Keyword
    ${response_content}    To Json    ${response_content}
    ${count}    Get Length    ${validate_values}
    FOR    ${key}    IN    @{validate_values.keys()}
        ${response_value}    Parse Json Response    ${response_content}    ${key}
        Should Contain    ${response_value}    ${validate_values}[${key}]
    END

Read Request Template File
    [Arguments]    ${file_path}    ${replace_string}=None    ${request_body_type}=None
    [Documentation]    This Keyword used to Read the ".txt" file and it converts the file to ".json" file as request body for the api request.
    ${request_data}    Get File    ${file_path}
    ${request_body_data}    Run Keyword If    ${replace_string}==None    Evaluate    json.loads('''${request_data}''')    json
    ...    ELSE    Set Variable    ${request_data}
    Comment    ${request_body_data}    Run Keyword If    ${replace_string}==None    RequestsLibrary.To Json    ${request_data}
    ...    ELSE    Set Variable    ${request_data}
    Run Keyword If    ${replace_string}==None    Return From Keyword    ${request_body_data}
    FOR    ${key}    IN    @{replace_string.keys()}
        ${request_data}    Replace String    ${request_data}    ${key}    ${replace_string}[${key}]
    END
    Run Keyword If    '${request_body_type}'=='String'    Return From Keyword    ${request_data}
    ${request_body_data}    Evaluate    json.loads('''${request_data}''')
    Comment    ${request_body_data}    To Json    ${request_data}
    [Return]    ${request_body_data}

Authenticate with Vaild Credentials
    [Arguments]    ${user_name}    ${password}
    ${user_credentials}    Create Dictionary    USERNAME=${user_name}    PASSWORD=${password}
    ${body}    Read Request Template File    ${API_LOGIN_REQUEST_BODY}    ${user_credentials}
    &{header}    Create Dictionary    Content-Type=application/json    User-Agent=""
    ${response}    Send Request    Put    /api/v1/sessions    ${header}    body=${body}
    [Return]    ${response}

Get Value from API Response
    [Arguments]    ${response}
    Comment    Convert request body to Json format
    ${session_content}    Evaluate    json.loads('''${response.content}''')    json
    Comment    Get reference_id from the response body
    ${reference_id}    Set Variable    ${session_content['response']['result']['Success'][0]['@attributes']['reference_id']}
    Log    Get Reference-id from response body. The reference-id is - ${reference_id}
    ${reference_id}    Convert To String    ${reference_id}
    Set Global Variable    ${reference_id}
    Log    Set reference-id as Global variable. The value is - ${reference_id}

Create Leonardo Session
    Comment    Create session for Leonardo247
    Create Session    ${leo_session}    ${API_BASE_URL}    disable_warnings=1
    Log    ${leo_session} is Created Successfully

Create WorkOrder
    [Arguments]    ${create_wo_data}
    &{header}    Create Dictionary    Content-Type=application/json    User-Agent=""
    Log    Headers are created with - ${header}
    ${request_data}    Read Request Body Data File    ${create_wo_data}[Request Body]
    log    Request Body is converted to Json
    ${response}    Send Request    Post    /api/v1/maintenance    ${header}    body=${request_data}
    Log    API Response - ${response.content}
    [Return]    ${response}

Get Workorders
    [Arguments]    ${get_wo_data}
    Comment    Update Workorder Id
    ${replace_data}    Replace String    ${get_wo_data}[Request Body]    WORKORDERID    ${reference_id}
    Log    Updated WorkOrderId dynamically in therequest body. Updated WorkorderId is - ${replace_data}
    Comment    Add work order id to the request body
    &{header}    Create Dictionary    Content-Type=application/json
    ${request_data}    Read Request Body Data File    ${replace_data}
    Log    Request Body is updated with Reference_id - ${request_data}
    ${response}    Send Request    Get    /api/v1/maintenance    header=${header}    body=${request_data}
    Log    Succesfully recieved request response - ${response.content}
    [Return]    ${response}

Update Workorder
    [Arguments]    ${update_wo_data}
    Comment    Get Current date
    ${date}    Get Current Date
    ${date_format}    Convert Date    ${date}    result_format=%Y-%m-%d
    Log    "completedDateTime" date value is - ${date_format}
    ${replace_data}    Replace String    ${update_wo_data}[Request Body]    WORKORDERID    ${reference_id}
    Log    Updated WorkorderId in the requestbody with - ${reference_id}.
    ${replace_data}    Replace String    ${replace_data}    TODAYDATE    ${date_format}
    Log    Updated Today's Date' in the requestbody with - ${date_format}.
    &{header}    Create Dictionary    Content-Type=application/json    User-Agent=""
    ${request_data}    Read Request Body Data File    ${replace_data}
    log    Request Body is converted to Json
    ${response}    Send Request    Post    /api/v1/maintenance    ${header}    body=${request_data}
    Log    API Response - ${response.content}
    [Return]    ${response}

Validate Update Workorder Id
    [Arguments]    ${response}
    ${session_content}    Evaluate    json.loads('''${response.content}''')    json
    Log    Converted response body to Json format.
    ${work_order_id}    Set Variable    ${session_content['response']['result']['workOrders']['workOrder'][0]['@attributes']['workOrderId']}
    Set Global Variable    ${work_order_id}    ${work_order_id}
    Log    Set Work order Id as a Global variable to access validate.
    Validate Response Status Code    ${work_order_id}    ${reference_id}
    Log    Validated Workorder_id \ & reference_id both are the same.

Read Request Body Data File
    [Arguments]    ${request_body}
    Comment    Convert Request Body to Json format.
    ${request_body_data}    Evaluate    json.loads('''${request_body}''')
    Log    Converted Request Body to "Json" Format
    [Return]    ${request_body_data}

Create WorkOrders with Required Fields
    [Arguments]    ${require_wo_data}
    &{header}    Create Dictionary    Content-Type=application/json
    ${request_data}    Read Request Body Data File    ${require_wo_data}
    Log    Request Body is updated with Reference_id - ${request_data}
    ${response}    Send Request    Post    /api/v1/maintenance    header=${header}    body=${request_data}
    Log    Succesfully recieved request response - ${response.content}
    [Return]    ${response}

Validate Response Body Message
    [Arguments]    ${response}    ${require_wo_data}
    ${session_content}    Evaluate    json.loads('''${response.content}''')    json
    Log    Converted response body to Json format.
    ${resp_message}    Set Variable    ${session_content['response']['result']['Success'][0]['@attributes']['message']}
    Set Global Variable    ${resp_message}
    Log    Set Work order Id as a Global variable to access validate.
    Should Be Equal As Strings    ${resp_message}    ${require_wo_data}[Expected message]    Expected - ${resp_message} success message is not matched with acctual ${require_wo_data}[Expected message] success message
    Log    Validated Workorder_id & reference_id both are the same.

Create WorkOrders with Brief Valid Charecters
    [Arguments]    ${require_wo_data}
    &{header}    Create Dictionary    Content-Type=application/json
    ${request_data}    Read Request Body Data File    ${require_wo_data}
    Log    Request Body is updated with Reference_id - ${request_data}
    ${response}    Send Request    Post    /api/v1/maintenance    header=${header}    body=${request_data}
    Log    Succesfully recieved request response - ${response.content}
    [Return]    ${response}
