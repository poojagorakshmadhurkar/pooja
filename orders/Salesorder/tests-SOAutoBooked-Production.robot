*** Settings ***
#Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Resource  ../../inventory/transactions/keywords.robot
#Resource  ../../variables.robot
Resource  ./variables.robot
#Resource  ../../inventory/warehouses/keywords.robot
Library    Browser


*** Variables ***

@{customername}  Test01
@{itemData1}  Fgitem1  100  50
@{rejection}  CheckNUt  Damage  10
${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}  P2
${shift}  Morning Shift




*** Test Cases ***

SoFGProduction
    login devsite
    select site  testingsiteautomation
    open warehouse
    ${bookquantity1} =  Get current Quantity of FG Booked Stock  ${itemData1}[0]
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible  timeout=30s
    ${item1_value}    ${item2_value}    ${item3_value}=    Expand And FetchItems from BOM    ${itemData1}    ${xpath}
    #check the WIPitems quanity in warehouse
    Search and Check Item Quantity for Wipitem  ${item3_value}  ${itemData1}[1]  Poojatest01  Test01
    open production Dropown
    Reload
    select machinesSo  ${machine}[0]
    select ShiftsSo  ${shift}
    date entryproduction
#    Wait For Elements State        ${loaderinterval}    hidden    timeout=30s
    click    ${intervalDropdown}     #interval dropfown
    select salesorder  ${order_number}
    click  ${productionsubmitbutton}
    #Production Entries
    set ith item in productionForm  0  ${itemData1}[0]  ${itemData1}[2]
    click  ${productionformsubmitbtn}
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    #verification of production entry is Salesorder
    Wait For Elements State      (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][2]   visible  timeout=60s    #booked Quantity
    #wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//tr[2]//td[6]//div[text()="${itemData1}[2] piece"]     #produced Quantity
    open warehouse
    ${bookquantity2}=  Get current Quantity of FG Booked Stock  ${itemData1}[0]
    ${finalbookcurrentstock}  Evaluate  eval("${bookquantity1}+${itemData1}[2]")
    Should Be Equal As Integers    ${bookquantity2}    ${finalbookcurrentstock}
    #click on booked quantity and check all detials
    click  (//span[text()="${itemData1}[0]"][1]/../../../../../../../../../td[4])//div[@id="live_inventory_booked"]
     # Wait for the page to contain the order number
    Wait For Elements State    //a[text()="${order_number}"]  visible   timeout=10s
    # Wait for the element to be visible
    Wait For Elements State      //tr[@role="checkbox" and .//th[@scope="row"]/span[contains(text(),"${customername}[0]")] and .//a[contains(text(),"${ORDER_NUMBER}")] and .//td[contains(text(),"${itemData1}[2] piece")]]   visible   timeout=60s
#     //tr[@role="checkbox" and .//th[@scope="row"]/span[contains(text(),"${customername}")] and .//a[contains(text(),"${ORDER_NUMBER}")] and .//td[contains(text(),"${itemData1}[2] piece")]]  10s