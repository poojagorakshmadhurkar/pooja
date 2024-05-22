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
@{itemData1}  Fgitem1  100  50
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
    ${bookquantity1} =  Get current Quantity of Booked Stock  ${itemData1}[0]
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    ${item1_value}    ${item2_value}    ${item3_value}=    Expand And FetchItems from BOM    ${itemData1}    ${xpath}
    #check the WIPitems quanity in warehouse
    Search and Check Item Quantity for Wipitem  ${item3_value}  ${itemData1}[1]  Poojatest01  Test01
    sleep  2
    open production Dropown
    reload page
    select machinesSo  ${machine}[0]
    sleep   1
    select ShiftsSo  ${shift}
    date entryproduction
    Wait Until Element Is Not Visible    ${loaderinterval}    timeout=30s
    click element   ${intervalDropdown}     #interval dropfown
    select salesorder  ${order_number}
    sleep  2
    click  ${productionsubmitbutton}
    sleep  2
    wait until element is visible  //b[text()="Allocated to : "]
    #Production Entries
    set ith item in productionForm  0  ${itemData1}[0]  ${itemData1}[2]
    sleep  1
    click  ${productionformsubmitbtn}
    sleep  2
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    sleep  1
    #verification of production entry is Salesorder
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][2]     #booked Quantity
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][3]     #produced Quantity
    sleep  2
    open warehouse
    ${bookquantity2}=  Get current Quantity of Booked Stock  ${itemData1}[0]
    ${finalbookcurrentstock}  Evaluate  eval("${bookquantity1}+${itemData1}[2]")
    Should Be Equal As Integers    ${bookquantity2}    ${finalbookcurrentstock}
    #click on booked quantity and check all detials
    click  (//span[text()="${itemData1}[0]"][1]/../../../../../../../../../td)[15]\
    sleep  2
     # Wait for the page to contain the order number
    Wait Until Page Contains  ${ORDER_NUMBER}  10s

    # Wait for the element to be visible
    wait until page contains element  //tr[@role="checkbox" and .//th[@scope="row"]/span[contains(text(),"${customername}[0]")] and .//a[contains(text(),"${ORDER_NUMBER}")] and .//td[contains(text(),"${itemData1}[2] piece")]]
#     //tr[@role="checkbox" and .//th[@scope="row"]/span[contains(text(),"${customername}")] and .//a[contains(text(),"${ORDER_NUMBER}")] and .//td[contains(text(),"${itemData1}[2] piece")]]  10s