*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library    CSVLibrary
Library    OperatingSystem
Library  Collections
Library  Evaluate


*** Variables ***

${file_path}  C:\\Users\\user\\PycharmProjects\\automation\\Suite\\inventory\\warehouses\\example.csv
${column1_row1}     #warehouse item =RM_001    warhouse =300 reconcile 250 50 outward note
${column2_row1}      #warehouse item =RM_002   warhouse =300 reconcile 350 50 inward note
${column3_row1}
${column4_row1}
${column1_row2}
${column2_row2}
${column3_row2}
${column4_row2}


*** Test Cases ***
Upload CSV File
    login

    Read Data from CSV
    select site  testing_site_automation
    sleep  3
    open warehouse
    ${item1value}  item onhand stock(Rawmaterial)  ${column1_row1}
    ${item2value}  item onhand stock(Rawmaterial)  ${column1_row2}
    Log    Item 1 value: ${column1_row1}
    Log    Item 2 value: ${column1_row2}

    sleep  2
    click  ${filter}
    click  ${reconcileinventory}
    click  ${uploadbutton}
    sleep  3
    click  ${uploadbutton}
    sleep  3
    Choose File   //input[@type='file']  ${file_path}
    sleep  5
    Wait Until Element Is Visible  //button[text()="Submit File"]
    Click Button  //button[text()="Submit File"]
    i should see text on page  Upload Successful


    reload page
    sleep  2
    camparison  ${item1value}  ${column4_row1}  ${column1_row1}
    camparison  ${item2value}  ${column4_row2}  ${column1_row2}
    Close Browser

*** Keywords ***

Test keyword 1     #Outward Note will be created
    [Arguments]    ${K}    ${Name1}  ${name}
    Log    Running Test keyword 1 with A: ${K} and itemData1: ${Name1}
    Log   itemname: ${name}
    ${first_number}    Set Variable  ${K}
    ${second_number}   Set Variable  ${Name1}
    ${result1}          Evaluate    ${first_number} - ${second_number}
    Log                Result of subtraction in Test keyword 1: ${result1}
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${outwardtab}
    open outward tr note  1
    wait until element is visible  //span[text() = "${name}"]
    ${quantityS}  Get Text  //span[text() = "${name}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    Should Be Equal As Numbers    ${result1}    ${integer_value}
    reload page
    sleep  2
    Click  (//div[@id = "item__tabs-panel-debit"]//button[@aria-label='Approve'])[1]
    open warehouse
    ${item1newvalue}  item onhand stock(Rawmaterial)  ${name}
    ${finalwarehousevalue}          Evaluate    ${first_number} - ${integer_value}
    Should Be Equal As Numbers    ${item1newvalue}    ${finalwarehousevalue}



Test keyword 2    #inward note will be created
    [Arguments]    ${P}    ${Name2}  ${name}
    Log    Running Test keyword 2 with A: ${P} and itemData1: ${Name2}
    Log   itemname: ${name}
    ${first_number}    Set Variable  ${P}
    ${second_number}   Set Variable  ${Name2}
    ${result2}          Evaluate    ${second_number} - ${first_number}
    Log                Result of subtraction in Test keyword 2: ${result2}
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${inwardtab}
    open inward tr note  1
    wait until element is visible  //a[text() = "${name}"]
    ${quantityS}  Get Text  //a[text() = "${name}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    reload page
    sleep  2
    Click  (//div[@id = "item__tabs-panel-credit"]//button[@aria-label='Approve'])[1]
    open warehouse
    ${item2newvalue}  item onhand stock(Rawmaterial)  ${name}
    ${finalwarehousevalue}          Evaluate    ${first_number} + ${integer_value}
    Should Be Equal As Numbers    ${item2newvalue}    ${finalwarehousevalue}


Camparison
    [Arguments]    ${A}    ${b}  ${recievedname}
    Run Keyword If    ${A} > ${b}  Test keyword 1  ${A}  ${b}  ${recievedname}
...  ELSE IF  ${A} < ${b}  Test keyword 2  ${A}  ${b}  ${recievedname}
...  ELSE IF  ${A} == ${b}  Log    This is a log statement for equal
    Log    This is a log statement



Read Data from CSV
    ${csv_content}=    Get File    ${file_path}
    @{csv_rows}=    Split To Lines    ${csv_content}

    FOR    ${index}    IN RANGE    1    ${csv_rows.__len__()}    # Start from 1 to skip the header row
        ${row}=    Get From List    ${csv_rows}    ${index}
        @{values}=    Split String    ${row}    ,
        Log    Processing row: ${row}
        Run Keyword And Continue On Failure    Set Row Variables    ${values}    ${index}
    END



Set Row Variables
    [Arguments]    ${values}    ${row_index}
    Set Test Variable    ${column1_row_${row_index}}    ${values[0]}
    Set Test Variable    ${column2_row_${row_index}}    ${values[1]}
    Set Test Variable    ${column3_row_${row_index}}    ${values[2]}
    Set Test Variable    ${column4_row_${row_index}}    ${values[3]}