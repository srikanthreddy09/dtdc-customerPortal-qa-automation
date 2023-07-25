*** Settings ***
Resource          ../../Config/super.robot

*** Keywords ***
Launch Browser
    [Arguments]    ${browser_name}    ${url}    ${clear_cache}=False
    #Run Keyword If    '${browser_name}'=='Chrome' or '${browser_name}'=='chrome' or '${browser_name}'=='gc'    Open Chrome Browser    ${url}    ${HEADLESS}    ${clear_cache}
    Run Keyword If    '${browser_name}'=='Chrome' or '${browser_name}'=='chrome' or '${browser_name}'=='gc'    Open Browser    ${url}    Chrome
    #Run Keyword If    '${browser_name}'=='Firefox' or '${browser_name}'=='firefox' or '${browser_name}'=='ff'    Open Firefox Browser    ${url}    ${HEADLESS}    ${clear_cache}
    #Run Keyword If    '${browser_name}'=='ie' or '${browser_name}'=='Internet Explorer' or '${browser_name}'=='internet explorer'    Open Ie Browser    ${url}    ${HEADLESS}    ${clear_cache}
    #Run Keyword If    '${browser_name}'=='edge' or '${browser_name}'=='Edge'    Open Edge Browser    ${url}    ${HEADLESS}    ${clear_cache}

 Open Chrome Browser
  Run Keyword If    '${browser_name}'=='Chrome' or '${browser_name}'=='chrome' or '${browser_name}'=='gc'    Open Browser    ${url}    Chrome

Launch Browser and Navigate to URL
    [Arguments]    ${url}    ${browser_name}    ${clear_cache}=False
    ${session}    Run Keyword And Return Status    Get Session Id
    ${url}    Run Keyword If    "${ENVIRONMENT}"=="Staging" or "${ENVIRONMENT}"=="STAGING" or "${ENVIRONMENT}"=="staging"    Set Variable    ${STAGING_URL}
    ...    ELSE IF    "${ENVIRONMENT}"=="Prod" or "${ENVIRONMENT}"=="PRODUCTION" or "${ENVIRONMENT}"=="production" or "${ENVIRONMENT}"=="prod"    Set Variable    ${PROD_URL}
    ...    ELSE    Set Variable    ${url}
    Run Keyword If    ${session}==True    Go To    ${url}
    ...    ELSE    Launch Browser    ${browser_name}    ${url}    ${clear_cache}
    Maximize Browser Window
    Log    ${url}
    [Return]    ${url}

Read TestData From Excel
    [Arguments]    ${testcaseid}    ${sheet_name}
    [Documentation]    Read TestData from excel file for required data.
    ...
    ...    Example:
    ...    Read TestData From Excel TC_01 SheetName
    ${test_data}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcaseid}    ${sheet_name}
    Set Global Variable    ${test_data}
    [Return]    ${test_data}

Take Screenshot
    SeleniumLibrary.Capture Page Screenshot