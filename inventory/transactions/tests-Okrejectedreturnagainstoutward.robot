*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime

*** Variables ***
@{itemData1}  ItemRM-11  20  10
@{inwarditem1}  ItemRM-11  2000


*** Test Cases ***
Outward to customer
    Set Selenium Speed    ${DELAY}
    login
    select site  testingautomationsite2
#validation to check item is present in warehouse if not then inward it
    Search and Check Item Quantity with iqc  ${inwarditem1}[0]  ${inwarditem1}[1]  Test Customer-01  Vendor1113
    open warehouse
    ${save1}  item current stock  ${itemData1}[0]
    sleep  2
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Cust-003
    #date entry
    #inovoice number
    input  //input[@id="debit__form__invoice_number"]  1234
    input  //input[@id="debit__form__truck_number"]  123
    set ith item in outward  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    click  ${newRequest}
    open trasactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Pending  1
    sleep  1
    open outward tr note  1

    #Extract number of shipment
    ${shipmentnumber}=    Get Text    xpath=//div[@class="ant-space-item"]//a[1]
    Log    ${shipmentnumber}
    wait until element is visible  //span[text() = "${itemData1}[0]"]
    ${outputValue}  Get Text  //span[text() = "${itemData1}[0]"]/../../../../../../../../../../td[1]
    ${outputValue_number}  Evaluate  ''.join(c for c in "${outputValue}" if c.isdigit())
    ${integer_value1}  Convert To Integer  ${outputValue_number}
    ${outwardnotevalue}  Evaluate  eval("${integer_value1}")
    click  //button[@class='MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeLarge css-1w8s6so']
    sleep  1
    outward approve number  1
    sleep  2
    open warehouse

    #validation of warehouse
    ${finalvalue1}  item current stock  ${itemData1}[0]
    ${value1}  Set Variable  ${save1}-${itemData1}[1]
    ${finalstock1}  Evaluate  eval("${value1}")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    sleep  1
    #click on search button

    open trasactions page
    click  ${outwardTab}
    click  ${materialnotesearchbuttonoutware}
    wait until element is visible  //input[@placeholder="Search Material Issue Note"]
    input text   //input[@placeholder="Search Material Issue Note"]  ${shipmentnumber}
    click  //input[@placeholder="Search Material Issue Note"]/../button[1]
    sleep   1
    #click on retrun click button
    click  //a[text()="${shipmentnumber}"]/../../../../td[9]//button//*[name()='svg'][@id='transaction_debit_return']
    sleep  1
    #input good quantity text with rejection
    input text  (//input[@class="ant-input"])[2]  ${outwardnotevalue}
    #inputing rejection quantity
    sleep  2
    click  //div[text()="Rejections"]
    rejection reason for outward return flow  BUBBLES  ${itemData1}[0]  ${itemData1}[2]
#validation rejected -okquantity
    ${finalQuantity}  Set Variable  ${itemData1}[1]-${itemData1}[2]
    ${afterdebit}  Evaluate  eval("${finalQuantity}")


    click  (//button[text()="Submit"])[2]
    i should see text on page  Return request submitted
    #Move to outward table cell should contain
    #open inward note
    click  ${inwardTab}
    inward tr status no method 2  Pending  1
    sleep  1
    open inward tr note  1
    sleep  2
    wait until element is visible  //a[text() = "${itemData1}[0]"]
    wait until element is visible  //div[text()="${outputValue}"]
    wait until element is visible  //span[text()="${itemData1}[2] g"]
    click  //button[@class='MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeLarge css-1w8s6so']
    sleep  1
    inward approve number  1
    i should see text on page  MRN approved SuccesFully
    sleep  2
    inward tr status no method 2  Approved  1
    sleep  1

    #validation of warehouse
    open warehouse
    ${finalvalue2}  item current stock  ${itemData1}[0]
    ${finalvalue}  Set Variable  ${finalstock1}+ ${afterdebit}
    ${finalwarehousevaule}  Evaluate  eval("${finalvalue}")
    Should Be Equal As Integers    ${finalvalue2}    ${finalwarehousevaule}




