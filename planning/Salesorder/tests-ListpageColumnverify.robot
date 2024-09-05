*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Resource  ../../inventory/transactions/keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot

*** Variables ***
@{customername}  Cust-003
@{itemData1}  09170_G  100



*** Test Cases ***
Verify List Page Columns
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open order tracker page
    wait until element is visible  //h5[text()="sales orders"]
    click element  //h5[text()="sales orders"]
    sleep  3
    # Wait for page to load
    Wait Until Page Contains Element    xpath=//table[@style='table-layout: fixed;'][1]
    ${column_names}=    Get WebElements    xpath=(//table[@style='table-layout: fixed;'][1]//tr)[1]
    ${actual_columns}=    Create List
    FOR    ${column}    IN    @{column_names}
        ${column_text}=    Get Text    ${column}
        ${column_text_lines}=    String.Split To Lines    ${column_text}    # Split text into lines excluding the last line
        Append To List    ${actual_columns}    @{column_text_lines}
    END
    Log Many    ${actual_columns}
    ${expected_columns}=    Create List    SO Details    Ref #    Customer    SO Start Date    Delivery Date    Demanded    Production planned    Produced   Actions
    Lists Should Be Equal    ${expected_columns}    ${actual_columns}
    Close Browser
