*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Resource  ../../inventory/transactions/keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Resource  ../../inventory/warehouses/keywords.robot


*** Variables ***

@{customername}  Test01
@{itemData1}  FGitem2  50  20
@{rejection}  CheckNUt  Damage  10
${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}  P2
${shift}  Morning Shift




*** Test Cases ***

SoFGProduction
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open warehouse
    ${bookquantity1} =  Get current Quantity of FG Booked Stock  ${itemData1}[0]
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    #manual booking
    click  ${bookedinventorybutton}
    wait until page contains element  (//span[text()="${itemData1}[0]"])[2]/../../../../../../../../../td[2][text()="${itemData1}[1] piece"]
    click  ${BookAllbutton}
    wait until page contains element  (//span[text()="${itemData1}[0]"])[2]/../../../../../../../../../td[5]//input[@value="${itemData1}[1]"]
    Click  //button[text()="Submit"]
    sleep  2
    open warehouse
    ${bookquantity2}=  Get current Quantity of FG Booked Stock  ${itemData1}[0]
    ${finalbookcurrentstock}  Evaluate  eval("${bookquantity1}+${itemData1}[1]")
    Should Be Equal As Integers    ${bookquantity2}    ${finalbookcurrentstock}
    #click on booked quantity and check all detials
    click  (//span[text()="${itemData1}[0]"][1]/../../../../../../../../../td)[15]
    sleep  2
    # Wait for the page to contain the order number
    Wait Until Page Contains  ${ORDER_NUMBER}  10s
    # Wait for the element to be visible
    wait until page contains element  //tr[@role="checkbox" and .//th[@scope="row"]/span[contains(text(),"${customername}[0]")] and .//a[contains(text(),"${ORDER_NUMBER}")] and .//td[contains(text(),"${itemData1}[1] piece")]]
    #Doing unbooked of booked Quantity
    click  //a[text()="${order_number}"]/../../../../../../../../../../../td[4]//button[@id="undefined__Unbook"]      #unbooking button
    Wait Until Page Contains    Items unbooked successfully    15s
    reload page
    ${bookquantity3}=  Get current Quantity of FG Booked Stock  ${itemData1}[0]
    ${finalbookcurrentstock1}  Evaluate  eval("${bookquantity2}-${itemData1}[1]")
    Should Be Equal As Integers    ${bookquantity3}    ${finalbookcurrentstock1}
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    sleep  1
    #verification ofbooked quantity entry is Salesorder
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[1] piece"][2]     #booked Quantity








