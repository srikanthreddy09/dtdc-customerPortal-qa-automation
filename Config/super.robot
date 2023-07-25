*** Settings ***
Library           SeleniumLibrary    run_on_failure=SeleniumLibrary.CapturePageScreenshot
Library           AppiumLibrary    run_on_failure=AppiumLibrary.CapturePageScreenshot
Library           FakerLibrary
Library           String
Library           Collections
Library           DateTime
Library           pabot.PabotLib
Library           ../Library/AppiumExtendedLibrary.py
Resource          ../ObjectRepository/Web/spinners.robot
Resource          ../Keywords/API/common_api.robot
Library           OperatingSystem
Library           RequestsLibrary
Library           DependencyLibrary
Library           ../Library/CustomLibrary.py
Library           Process
Resource          ../Config/web_dtdc_variables.robot
Resource          ../Keywords/Web/dtdc_shipsy_booking.robot

