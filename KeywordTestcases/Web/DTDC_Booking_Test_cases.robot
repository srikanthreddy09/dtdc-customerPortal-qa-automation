*** Settings ***
Resource          ../../Config/super.robot

*** Test Cases ***
TC_01-Book courier From Customer Portal
    [Tags]    test_case_id=tc 01
    Launch Browser and Navigate to URL    ${SHIPSY_URL}    ${BROWSERNAME}