*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime

*** Variables ***

@{itemData1}  ItemRM-10  11  5000


*** Test Cases ***
Making a transaction for an item more than the inventory value and partially approving it
    Set Selenium Speed    ${DELAY}
    login
    select site  testingsiteautomation3rackcase
    Search and Check Item Quantity with iqc with rackcase  ${itemData1}[0]  ${itemData1}[2]  Test_Employee04  Pooja30
    open warehouse
    ${save}  item current stock for Rackcase  ${itemData1}[0]
    open transactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Pooja30
    sleep  1
    Wait Until Element Is Visible    //span[normalize-space()='Invoice Number *']    10
    Input Text  //input[@id='debit__form__invoice_number']  inv1001
    input Text  //input[@id='debit__form__truck_number']  Truck123
    sleep  1
#    set ith item in outward  0  ${itemData1}[0]  ${itemData1}[1]
    set ith item in outward  0  ${itemData1}[0]  ${save+1}
    click  ${submit}
    click  ${newRequest}
    open transactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Shortage  1
    sleep  1
    #Open Outward Note
    open outward tr note  1
    ${outputValue}  Get Text  //span[text() = "${itemData1}[0]"]/../../../../../../../../../../td[1]
    ${outputValue_number}  Evaluate  ''.join(c for c in "${outputValue}" if c.isdigit())
    ${integer_value1}  Convert To Integer  ${outputValue_number}
    Should Be Equal As Integers    ${integer_value1}    ${save+1}
    ${shortageValue}  Get Text  //span[text() = "${itemData1}[0]"]/../../../../../../../../../../td[2]/span
    ${shortageValue_number}  Evaluate  ''.join(c for c in "${shortageValue}" if c.isdigit())
    ${integer_value2}  Convert To Integer  ${shortageValue_number}
    Should Be Equal As Integers    ${integer_value2}    1
    click  //button[@class='MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeLarge css-1w8s6so']
    sleep  1
    #approving outward note
    outward approve number  1
    wait until element is visible  //span[text() = "${itemData1}[0]"]
    ${requestedValue}  Get Text  (//tbody)[3]//span[text()="${itemData1}[0]"]/../../../../../../../../../../td[1]
    ${requestedValue_number}  Evaluate  ''.join(c for c in "${requestedValue}" if c.isdigit())
    ${integer_value3}  Convert To Integer  ${requestedValue_number}
    Should Be Equal As Integers    ${integer_value3}    ${save+1}
    ${quantityValue}  Get Text  (//tbody)[3]//span[text()="${itemData1}[0]"]/../../../../../../../../../../td[2]
    ${quantityValue_number}  Evaluate  ''.join(c for c in "${quantityValue}" if c.isdigit())
    ${integer_value4}  Convert To Integer  ${quantityValue_number}
    Should Be Equal As Integers    ${integer_value4}    ${save}
    #click on Next click button
    click  //button[@type='primary']
    click  ${approveRequest}
    sleep  1
    i should see text on page  MRN approved SuccesFully
    sleep  1
    outward tr status no method 2  Shortage  1
    outward tr status no method 2  Approved  2
    outward approve number  1
    ${requestedValue1}  Get Text  //span[text() = "${itemData1}[0]"]/../../../../../../../../../../td[1]
    ${requestedValue_number}  Evaluate  ''.join(c for c in "${requestedValue1}" if c.isdigit())
    ${integer_value3}  Convert To Integer  ${requestedValue_number}
    Should Be Equal As Integers    ${integer_value3}    1
    ${quantityValue2}  Get Text  //span[text() = "${itemData1}[0]"]/../../../../../../../../../../td[2]
#    ${quantityValue2_}  Evaluate  ''.join(c for c in "${quantityValue2}" if c.isdigit())
    Should Be Equal As Strings    ${quantityValue2}    -
    sleep  1
#    open warehouse
    No live inventory check  ${itemData1}[0]


# alternate item needs to be handled is pending
