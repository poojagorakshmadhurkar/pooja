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
@{itemData1}  Fgitem1  100

${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}  P2
${shift}  Morning Shift




*** Test Cases ***

SoFGProduction
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible   timeout=30s
    ${item1_value}    ${item2_value}    ${item3_value}=    Expand And FetchItems from BOM    ${itemData1}    ${xpath}
    sleep  1
    #check the items quanity in warehouse
    Search and Check Item Quantity for Wipitem  ${item3_value}  ${itemData1}[1]  Poojatest01  Test01
    sleep  1
    open production Dropown
#    Reload
    select machinesSo  ${machine}[0]
    select ShiftsSo  ${shift}
    date entryproduction
#    click element   ${intervalDropdown}     #interval dropfown
    sleep  1
    select salesorder  ${order_number}
    click  //button[@type="submit"]
    sleep  1
    #Production Entries
    set ith item in productionForm  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${productionformsubmitbtn}
    Open Order Tracker Page
    Wait For Elements State    //h5[text()="sales orders"]    visible   timeout=120s
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[1] piece"][2]   visible   timeout=60s   #booked Quantity
#    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[1] piece"][3]     #produced Quantity

