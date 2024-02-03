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
    ${stockvalue1}  item onhand stock(Rawmaterial)  ${column1_row1}
    ${stockvalue2}  item onhand stock(Rawmaterial)  ${column1_row2}
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
    camparison  ${stockvalue1}  ${column4_row1}  ${column1_row1}
    camparison  ${stockvalue2}  ${column4_row2}  ${column1_row2}
    Close Browser

*** Keywords ***

Test keyword 1     #Outward Note will be created
    [Arguments]    ${stockvalue}    ${itemvalue}  ${itemname}
    ${result1}          Set Variable    ${stockvalue} - ${itemvalue}
    ${outwardvalue}  Evaluate  eval("${result1}")
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${outwardtab}
    open outward tr note  1
    wait until element is visible  //span[text() = "${itemname}"]
    ${quantityS}  Get Text  //span[text() = "${itemname}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    Should Be Equal As Numbers    ${result1}    ${integer_value}
#    ${fetchoutwardADJNote}  Get Text  //button[normalize-space()='Disapprove Request']/../span[2]
#    return from keyword  ${fetchoutwardADJNote}
    reload page
    sleep  2
    Click  (//div[@id = "item__tabs-panel-debit"]//button[@aria-label='Approve'])[1]
    open warehouse
    ${finalwarehousevalue}  item onhand stock(Rawmaterial)  ${itemname}
    ${warehouseresult}          Evaluate    ${stockvalue} - ${integer_value}
    Should Be Equal As Numbers    ${warehouseresult}    ${finalwarehousevalue}



Test keyword 2    #inward note will be created
    [Arguments]    ${stockvalue}    ${itemvalue}  ${itemname}
    ${result1}          Set Variable    ${stockvalue} - ${itemvalue}
    ${outwardvalue}  Evaluate  eval("${result1}")
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${inwardtab}
    open inward tr note  1
    wait until element is visible  //a[text() = "${itemname}"]
    ${quantityS}  Get Text  //a[text() = "${itemname}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    reload page
    sleep  2
    Click  //div[@id="item__tabs-panel-credit"]//tbody//tr[2]//td[11]//button[@aria-label="Approve"]
    open warehouse
    ${finalwarehousevalue}  item onhand stock(Rawmaterial)  ${itemname}
    ${warehouseresult}          Evaluate    ${stockvalue} - ${integer_value}
    Should Be Equal As Numbers    ${warehouseresult}    ${finalwarehousevalue}



Camparison
    [Arguments]    ${stockvalue}    ${reconcilevalue}  ${itemname}
    Run Keyword If    ${stockvalue} > ${reconcilevalue}  Test keyword 1  ${stockvalue}    ${reconcilevalue}  ${itemname}
...  ELSE IF  ${stockvalue} < ${reconcilevalue}  Test keyword 2  ${stockvalue}    ${reconcilevalue}  ${itemname}
...  ELSE IF  ${stockvalue} == ${reconcilevalue}  Log    This is a log statement for equal
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