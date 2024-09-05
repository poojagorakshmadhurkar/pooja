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
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    ${item1_value}    ${item2_value}    ${item3_value}=    Expand And FetchItems from BOM    ${itemData1}    ${xpath}
    #check the items quanity in warehouse
    Search and Check Item Quantity for Wipitem  ${item3_value}  ${itemData1}[1]  Poojatest01  Test01
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
#    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][3]     #produced Quantity
    sleep  2
   #to get rejected current Quantity
    open warehouse
    sleep  2
    reload page
    click  ${rejectedsection}
    #to fetch rejected current quantity of summary view
    ${rejectedsummaryQuantity1} =  rejected current quantity of summary view    ${itemData1}[0]
    sleep  1
    #To fetch rejected curent Quantity of detailted view
    ${rejecteddetailedQuantity1} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[0]
    reload page
    ${rejecteddetailedQuantity2} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
    sleep  1
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
    click  ${edit}
    #rejction entry in production
    click  ${rejectedbutton}
    rejectionprodform  1  ${rejection}[0]  ${rejection}[2]
    rejectionprodform  2  ${rejection}[1]  ${rejection}[2]
    click  ${productionformsubmitbtn}
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    sleep  2
    # verification rejection entry
    ${bookedQuantity}  Evaluate  ${itemData1}[2] - ${rejection}[2] - ${rejection}[2]      #booked Quantity
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${bookedQuantity} piece"]
    ${producedQuantity}  Evaluate  ${itemData1}[2] + ${rejection}[2] + ${rejection}[2]
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${producedQuantity} piece"]
    #verification of rejected Quantity in warehouse
    sleep  1
    open warehouse
    reload page
    click  ${rejectedsection}
    #to fetch rejected current quantity
    ${rejectedsummaryQuantity2} =  rejected current quantity of summary view    ${itemData1}[0]
    ${finalrejectedsummaryQuantity}  Evaluate  eval("${rejectedsummaryQuantity1}+${rejection}[2]+${rejection}[2]")
    Should Be Equal As Integers    ${finalrejectedsummaryQuantity}    ${rejectedsummaryQuantity2}
    #to fetch qauntity from detailed view
    sleep  1
    ${rejecteddetailedQuantity3} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[0]
    reload page
    ${rejecteddetailedQuantity4} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
    #Validation for rejected quanity detailed view
    ${finalrejectedetailed1Quantity}  Evaluate  eval("${rejecteddetailedQuantity1}+${rejection}[2]")
    Should Be Equal As Integers    ${finalrejectedetailed1Quantity}    ${rejecteddetailedQuantity3}
    ${finalrejectedetailed2Quantity}  Evaluate  eval("${rejecteddetailedQuantity2}+${rejection}[2]")
    Should Be Equal As Integers    ${finalrejectedetailed2Quantity}    ${rejecteddetailedQuantity4}