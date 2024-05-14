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
@{itemData1}  Fgitem1  100

${xpath}  //span[contains(@class, 'ant-tree-title')]
${machine}  P2
${shift}  Morning Shift




*** Test Cases ***

SoFGProduction
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    ${item1_value}    ${item2_value}    ${item3_value}=    Expand And FetchItems from BOM    ${itemData1}    ${xpath}
    #check the items quanity in warehouse
    Search and Check Item Quantity for Wipitem  ${item3_value}  ${itemData1}[1]  Poojatest01  Test01
    open production Dropown
    reload page
    select machinesSo  ${machine}
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
    set ith item in productionForm  0  ${itemData1}[0]  ${itemData1}[1]
    sleep  1
    click  ${productionformsubmitbtn}
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    sleep  1
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[1] piece"][2]     #booked Quantity
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[1] piece"][3]     #produced Quantity
    sleep  2

