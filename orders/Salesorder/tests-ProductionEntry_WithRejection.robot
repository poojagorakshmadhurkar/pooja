*** Settings ***

Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Resource  ../../inventory/transactions/keywords.robot
#Resource  ../../variables.robot
Resource  ./variables.robot
#Resource  ../../inventory/warehouses/keywords.robot
Library  Browser

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
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State       //div[text()="${order_number}"]    visible   timeout=30s
    ${item1_value}    ${item2_value}    ${item3_value}=    Expand And FetchItems from BOM    ${itemData1}    ${xpath}
    #check the items quanity in warehouse
    Search and Check Item Quantity for Wipitem  ${item3_value}  ${itemData1}[1]  Poojatest01  Test01
    sleep  1
    open production Dropown
    select machinesSo  ${machine}[0]
    select ShiftsSo  ${shift}
    date entryproduction
#    click element   ${intervalDropdown}     #interval dropfown
    select salesorder  ${order_number}
    click  //button[@type="submit"]
    #Production Entries
    set ith item in productionForm  0  ${itemData1}[0]  ${itemData1}[2]
    click  ${productionformsubmitbtn}
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    #verification of production entry is Salesorder
    Wait For Elements State      (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][2]    visible  timeout=60s
#    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][3]     #produced Quantity
   #to get rejected current Quantity
    open warehouse
    Reload
    click  ${rejectedsection}
    #to fetch rejected current quantity of summary view
    ${rejectedsummaryQuantity1} =  rejected current quantity of summary view    ${itemData1}[0]
    #To fetch rejected curent Quantity of detailted view
    ${rejecteddetailedQuantity1} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[0]
    Reload
    ${rejecteddetailedQuantity2} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
    open production Dropown
    Reload
    select machinesSo  ${machine}[0]
    select ShiftsSo  ${shift}
    date entryproduction
    click    ${intervalDropdown}     #interval dropfown
    select salesorder  ${order_number}
    click  (//button[@type='submit'])[1]
    Wait For Elements State     //b[text()="Allocated to : "]   visible   timeout=60s
    click  //button[@type="Edit"]
    #rejction entry in production
    click  ${rejectedbutton}
    rejectionprodform  1  ${rejection}[0]  ${rejection}[2]
    rejectionprodform  2  ${rejection}[1]  ${rejection}[2]
    click  ${productionformsubmitbtn}
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    # verification rejection entry
    ${bookedQuantity}  Evaluate  ${itemData1}[2] - ${rejection}[2] - ${rejection}[2]      #booked Quantity
    Wait For Elements State     (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${bookedQuantity} piece"]   visible   timeout=60s
    ${producedQuantity}  Evaluate  ${itemData1}[2] + ${rejection}[2] + ${rejection}[2]
    Wait For Elements State       (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${producedQuantity} piece"]   visible   timeout=60s
    #verification of rejected Quantity in warehouse
    open warehouse
    Reload
    click  ${rejectedsection}
    #to fetch rejected current quantity
    ${rejectedsummaryQuantity2} =  rejected current quantity of summary view    ${itemData1}[0]
    ${finalrejectedsummaryQuantity}  Evaluate  eval("${rejectedsummaryQuantity1}+${rejection}[2]+${rejection}[2]")
    Should Be Equal As Integers    ${finalrejectedsummaryQuantity}    ${rejectedsummaryQuantity2}
    #to fetch qauntity from detailed view
    ${rejecteddetailedQuantity3} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[0]
    Reload
    ${rejecteddetailedQuantity4} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
    #Validation for rejected quanity detailed view
    ${finalrejectedetailed1Quantity}  Evaluate  eval("${rejecteddetailedQuantity1}+${rejection}[2]")
    Should Be Equal As Integers    ${finalrejectedetailed1Quantity}    ${rejecteddetailedQuantity3}
    ${finalrejectedetailed2Quantity}  Evaluate  eval("${rejecteddetailedQuantity2}+${rejection}[2]")
    Should Be Equal As Integers    ${finalrejectedetailed2Quantity}    ${rejecteddetailedQuantity4}