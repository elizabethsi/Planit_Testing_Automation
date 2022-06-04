*** Settings ***
Documentation       Planit Technical Assessment - Automation
Test Teardown       Close All Browsers

Resource    ../Resources/PageObjects/JupiterLanding_Page.robot
Resource    ../Resources/Actions/Common.robot
Resource    ../Resources/Actions/Jupiter_Main.robot

*** Test Cases ***
Contact Page Error Validation
    [Documentation]
    ...     *Test cases covered:*\n
    ...     Test Case #1
    [Tags]  Planit Testing
    Contact Page Error Validation

Contact Page Inputs Validation
    [Documentation]
    ...     *Test cases covered:*\n
    ...     Test Case #2
    [Tags]  Planit Testing
    FOR     ${index}    IN RANGE    5
    Contact Page Inputs Validation
    END

Cart Items Validation
    [Documentation]
    ...     *Test cases covered:*\n
    ...     Test Case #3
    [Tags]  Planit Testing
    Cart Items Validation

Price Validation
    [Documentation]
    ...     *Test cases covered:*\n
    ...     Test Case #4
    [Tags]  Planit Testing
    Price Validation    ${prod_2}     2   ${prod_4}     5   ${prod_7}     3