*** Settings ***
Resource          ../../Config/super.robot

*** Keywords ***
Launch Mobile Application
    [Arguments]    ${platform_name}
    [Documentation]    Launch Application in Android and iOS platforms.
    ...
    ...    Examples:
    ...    mobile_common.Launch Mobile Application ${PLATFORM_NAME}
    ...    mobile_common.Launch Mobile Application Android/ios
    Run Keyword If    '${platform_name}'=='Android'    AppiumLibrary.Open Application    ${APPIUM_SERVER_URL}    platformName=Android    platformVersion=${ANDROID_PLATFORM_VERSION}    deviceName=${ANDROID_DEVICE_NAME}    app=${ANDROID_APP}    appActivity=com.webpartners.leonardo.MainActivity    automationName=${ANDROID_AUTOMATION_NAME}    noReset=${ANDROID_NO_RESET_APP}    autoAcceptAlerts=True    autoGrantPermissions=True    newCommandTimeout=${NEW_COMMAND_TIMEOUT}    shouldTerminateApp=True
    Run Keyword If    '${platform_name}'=='iOS'    AppiumLibrary.Open Application    ${APPIUM_SERVER_URL}    platformName=iOS    platformVersion=${IOS_PLATFORM_VERSION}    deviceName=${IOS_DEVICE_NAME}    app=${IOS_APP}    udid=${UDID}    bundleId=${BUNDLE_ID}    automationName=${IOS_AUTOMATION_NAME}    noReset=${IOS_NO_RESET_APP}    autoAcceptAlerts=True    shouldTerminateApp=True
    Run Keyword If    '${platform_name}'!='iOS' and '${platform_name}'!='Android'    Fail    Platform Name used '${platform_name}'. Please provide valid Platform Name.
    Comment    Run Keyword If    '${platform_name}'=='Android'    Cancel Software Update

Input Text
    [Arguments]    ${locator}    ${data}
    [Documentation]    Enters Text into textbox, and Hide the android keyboard.
    ...
    ...    Example:
    ...    mobile_common.Input Text locator text
    ${element_locator}    AppiumExtendedLibrary.Get Element Locator    ${locator}
    mobile_common.Wait Until Element is Visible    ${locator}    ${locator}    ${LONG_WAIT}
    Comment    AppiumLibrary.Wait Until Element Is Visible    ${element_locator}    ${LONG_WAIT}    ${locator} is not displayed after waiting ${LONG_WAIT}
    AppiumLibrary.Input Text    ${element_locator}    ${data}
    Run Keyword If    '${platform_name}'=='Android'    AppiumLibrary.Hide Keyboard
    Run Keyword If    '${platform_name}'=='iOS'    AppiumLibrary.Click Element    nsp=label=="Toolbar Done Button"

Read TestData From Excel
    [Arguments]    ${testcaseid}    ${sheet_name}
    [Documentation]    Read TestData from excel file for required data.
    ...
    ...    Example:
    ...    Read TestData From Excel TC_01 SheetName
    ${test_prerequisite_data}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/MobileTestData.xlsx    ${testcaseid}    ${sheet_name}
    Set Global Variable    ${test_prerequisite_data}
    [Return]    ${test_prerequisite_data}

Fail and Take Screenshot
    [Arguments]    ${message}
    AppiumLibrary.Capture Page Screenshot
    Fail    ${message}

Wait Until Element is Clickable and Click
    [Arguments]    ${locator}    ${time_out}
    FOR    ${key}    IN RANGE    1    ${time_out}
        ${status}    Run Keyword And Return Status    AppiumLibrary.Click Element    ${locator}
        Run Keyword If    '${status}'=='True'    Exit For Loop
        Wait Until Time    1
    END
    Run Keyword If    '${status}'=='False'    Fail and Take Screenshot    Elemet is not clickable even after waiting ${timeout}

Wait Until Text is Displayed
    [Arguments]    ${displayed_text}    ${time_out}=10
    FOR    ${key}    IN RANGE    1    ${time_out}
        ${status}    Run Keyword And Return Status    AppiumLibrary.Page Should Contain Text    ${displayed_text}
        Run Keyword If    '${status}'=='True'    Exit For Loop
        Wait Until Time    1
    END
    Run Keyword If    '${status}'=='False'    Fail and Take Screenshot    ${displayed_text} is not displayed

Update Dynamic Value
    [Arguments]    ${locator}    ${value}
    [Documentation]    It replace the string where ever you want.
    ...
    ...    Example:
    ...    mobile_common.Update Dynamic Value locator replace_string
    ${xpath}=    Replace String    ${locator}    replaceText    ${value}
    [Return]    ${xpath}

Update Dynamic Values
    [Arguments]    ${locator}    ${value1}    ${value2}
    ${locator}=    Replace String    ${locator}    replaceText1    ${value1}
    ${xpath}=    Replace String    ${locator}    replaceText2    ${value2}
    [Return]    ${xpath}

Scroll Up and Input Text
    [Arguments]    ${locator}    ${value}
    AppiumExtendedLibrary.Swipe Down To Element    ${locator}
    mobile_common.Input Text    ${locator}    ${value}

Click on Filter icon
    Click On Element    Filter    ${button.filter_icon}    ${SHORT_WAIT}
    Comment    Click On Element    Filter    ${button.filter_icon}    ${MEDIUM_WAIT}

Select Property
    [Arguments]    ${property_name}
    Click On Element    Property    ${list.filter.property}    ${SHORT_WAIT}
    mobile_common.Wait Until Element is Visible    Search Property    ${textbox.filter.property_text}    ${SHORT_WAIT}
    mobile_common.Clear Text    Search Property    ${textbox.filter.property_text}    ${SHORT_WAIT}
    mobile_common.Input Text    ${textbox.filter.property_text}    ${property_name}
    Log    Entered ${property_name} - property name into property text box
    ${list.filter.property_name.new}    mobile_common.Update Dynamic Value    ${list.filter.property_name}    ${property_name}
    Click On Element    ${property_name}    ${list.filter.property_name.new}    ${SHORT_WAIT}
    Log    Selected ${property_name} - property from property drop down.

Click on Apply button
    Wait For Loader to Disappear
    Click On Element    Apply    ${button.filter.apply}    ${MEDIUM_WAIT}

Click on plus icon
    Click On Element    Add    ${button.tasks.add_workflow}    ${MEDIUM_WAIT}

Swipe on Task
    [Arguments]    ${locator}    ${direction}=left
    ${element_locator}    AppiumExtendedLibrary.Get Element Locator    ${locator}
    ${bounds}    AppiumLibrary.Get Element Attribute    ${element_locator}    bounds
    ${element_co_ordinates}    Replace String    ${bounds}    ][    ,
    Log    ${element_co_ordinates}
    ${element_co_ordinates}    Replace String    ${element_co_ordinates}    [    ${EMPTY}
    ${element_co_ordinates}    Replace String    ${element_co_ordinates}    ]    ${EMPTY}
    @{co-ordinates}    Split String    ${element_co_ordinates}    ,
    ${xx_co-ordi}    Set Variable    ${co-ordinates}[0]
    ${xy_co-ordi}    Evaluate    ${co-ordinates}[1]+80
    ${xy_co-ordi}    Set Variable    ${xy_co-ordi}
    ${yx_co-ordi}    Evaluate    ${co-ordinates}[2]-100
    ${yx_co-ordi}    Set Variable    ${yx_co-ordi}
    ${yy_co-ordi}    Set Variable    ${co-ordinates}[3]
    log    [${xx_co-ordi},${xy_co-ordi}][${yx_co-ordi},${yy_co-ordi}]
    AppiumExtendedLibrary.Swipe The Task    ${xx_co-ordi}    ${xy_co-ordi}    ${yx_co-ordi}    ${yy_co-ordi}    ${direction}

Click On Element
    [Arguments]    ${element_name}    ${locator}    ${wait}
    [Documentation]    This Keyword use to Click on element after wait for the element.
    Wait For Loader to Disappear
    mobile_common.Wait Until Element is Visible    ${element_name}    ${locator}    ${wait}
    ${element_locator}    AppiumExtendedLibrary.Get Element Locator    ${locator}
    Log    ${element_locator}
    AppiumLibrary.Click Element    ${element_locator}
    Log    Clicked on ${element_name} - element.

Wait Until Element is Visible
    [Arguments]    ${element_name}    ${locator}    ${wait}
    Log    Wait for ${element_name} - element
    Wait For Loader to Disappear
    ${element_locator}    AppiumExtendedLibrary.Get Element Locator    ${locator}
    Log    ${element_locator}
    ${status}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    ${element_locator}    ${wait}    ${element_name} - is not displayed after waiting ${wait} sec
    Log    ${element_name} - is displayed after waiting ${wait} sec
    [Return]    ${status}

Wait For Loader to Disappear
    AppiumLibrary.Wait Until Page Does Not Contain Element    ${image.loader}    ${LONG_WAIT}    "Loader" icon is visible after waiting ${LONG_WAIT} sec
    AppiumLibrary.Capture Page Screenshot

Click On Settings Icon
    ${status}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    ${image.home_page.settings}    ${MEDIUM_WAIT}
    Run Keyword If    '${status}'=='True'    AppiumLibrary.Click Element    ${image.home_page.settings}

Clear Text
    [Arguments]    ${element_name}    ${locator}    ${wait}
    Wait For Loader to Disappear
    ${status}    mobile_common.Wait Until Element is Visible    ${element_name}    ${locator}    ${wait}
    Run Keyword If    '${status}'=='False'    Fail    ${element_name} - is not displayed after waiting ${wait} sec
    ${element_locator}    AppiumExtendedLibrary.Get Element Locator    ${locator}
    Log    ${element_locator}
    AppiumLibrary.Clear Text    ${element_locator}
    Log    Cleared ${element_name} - element.
