*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Resource  ../../inventory/transactions/keywords.robot
Library  String
Library    CSVLibrary
Library    OperatingSystem
Library  Collections



*** Variables ***

${file_path}  C:\\Users\\user\\PycharmProjects\\automation\\Suite\\inventory\\warehouses\\example.csv
${column1_row1}     #warehouse item =RM_001    warhouse =300 reconcile 250 50 outward note
${column2_row1}      #warehouse item =RM_002   warhouse =300 reconcile 350 50 inward note
${column3_row1}        #always ensure 1st option is doing outward and second inward
${column4_row1}
${column1_row2}
${column2_row2}
${column3_row2}
${column4_row2}
${keyword1_count}    0
${keyword2_count}    0

*** Test Cases ***
Upload CSV File
    Set Selenium Speed    0.1
    login
    Read Data from CSV
    select site  testingsiteautomation
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
    [Arguments]    ${currentstockvalue}    ${reconcilevalue}  ${itemname}
    ${result1}          Set Variable    ${currentstockvalue} - ${reconcilevalue}
    ${outwardvalue}  Evaluate  eval("${result1}")
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${outwardtab}
    open outward tr note  1
    wait until element is visible  //span[text() = "${itemname}"]
    ${quantityS}  Get Text  //span[text() = "${itemname}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${notevalue}  Convert To Integer  ${Quantity_number}
    Should Be Equal As Numbers    ${outwardvalue}    ${notevalue}
#    ${fetchoutwardADJNote}  Get Text  //button[normalize-space()='Disapprove Request']/../span[2]
#    return from keyword  ${fetchoutwardADJNote}
    reload page
    sleep  5
    Increment Keyword 1 Count  ${keyword1_count}
    sleep  3
    open warehouse
    sleep  2
    ${finalwarehousevalue}  item onhand stock(Rawmaterial)  ${itemname}
    ${warehouseresult}          Evaluate    ${currentstockvalue} - ${notevalue}
    Should Be Equal As Numbers    ${warehouseresult}    ${finalwarehousevalue}


Test keyword 2    #inward note will be created
    [Arguments]    ${currentstockvalue}    ${reconcilevalue}  ${itemname}
    ${result1}          Set Variable    ${reconcilevalue} - ${currentstockvalue}
    ${inwardvalue}  Evaluate  eval("${result1}")
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${inwardtab}
    open inward tr note  1
    wait until element is visible  //a[text() = "${itemname}"]
    ${quantityS}  Get Text  //a[text() = "${itemname}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${notevalue}  Convert To Integer  ${Quantity_number}
    Should Be Equal As Numbers    ${inwardvalue}    ${notevalue}
    reload page
    sleep  5
    Increment Keyword 2 Count  ${keyword2_count}
    sleep  3
    open warehouse
    sleep  2
    ${finalwarehousevalue}  item onhand stock(Rawmaterial)  ${itemname}
    ${warehouseresult}          Evaluate    ${currentstockvalue} + ${notevalue}
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




Click Approval Button Based on Keyword Count
    [Documentation]    Clicks the approval button based on the count of Keyword 1 and Keyword 2
    Run Keyword If    ${keyword1_count} == 2  Click Outward Approval Button
    Run Keyword If    ${keyword2_count} == 2  Click Inward Approval Button
