*** Settings ***
#Library  SeleniumLibrary
Resource  ../keywords.robot
#Resource  ../orders/Salesorder/variables.robot
Library  String
Library  Collections
#Resource  ../variables.robot
Resource  ../orders/Salesorder/keywords.robot
Resource   ./variables.robot
Resource   ./keyword.robot
Library    Browser


*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100  50
@{itemData2}  50
@{itemData3}  FGitem2  100





*** Test Cases ***
Dispatch planning for fully recieved
    login devsite
    select site  testingsiteautomation
    ${salesorder_number}=  Create salesorder  ${customername}  ${itemData1}
    #Dispatch validaiton
    click  ${dispatchplanbutton}
#    wait until page contains   ${salesorder_number}
    ${todaysdate}=    delivery date entry in dispatch
    set ith item in Dispatch only quantity  0  ${itemData1}[0]  ${itemData1}[2]
    Click  ${dipatchsubmitbutton}
    ${dispatch_number}=    Get Dispatch Number
    click  ${viewschdeuledispatch}
    #Click on drawer
    Open Event monthwise Drawer  ${dispatch_number}  ${customername}  ${salesorder_number}
    #validation in salesorder
    Open Order Tracker Page
    sleep  1
    search Sonumber in SoListpage for validation  ${salesorder_number}
    click  (//a[text()="${salesorder_number}"]/../../../../../../../../span)[1]
    #wait until element is visible    //a[text()="${itemData1}[0]"]/../../../../../../../../../td[5]//div[text()="${itemData1}[2] piece"]
    #Shiped the Dispatch order
    open dispatch order page
    Open Event monthwise Drawer  ${dispatch_number}  ${customername}  ${salesorder_number}
    click  ${dispatchshipmentbutton}
    Wait For Elements State     //span[text()="${salesorder_number}"]/../../../../../div[1]//span[text()="${customername}[0]"]  visible  timeout=60s
    set ith item only quantity for outward   0   ${itemData1}[0]  ${itemData2}[0]
    click  ${outwardsubmit}
    approve outward
    Reload
    sleep  2
    #verify Dispatch partially recived status
    open dispatch order page
    Select Day Option from dropdown
    Using search filters of SO  ${salesorder_number}
    Open Event Daywise Drawer   ${customername}  ${dispatch_number}
#    Wait For Elements State      //span[text()="Dispatched"]  visible  timeout=60s
    Log  ${itemData1[0]}  # Should log Fgitem1
    Log  ${itemData1[1]}  # Should log 100
    Log  ${itemData1[2]}
    #wait until element is visible  //span[text()="${itemData1[0]}"]/../../../../../../../../../../td[2][text()="${itemData1[2]} piece"]/../../../../../../../div[2]//tr[2]//th[text()="${itemData2}[0] piece"][1]
    ${value}  Set Variable  ${itemData1}[2]-${itemData2}[0]
    ${remainingvalue}  Evaluate  eval("${value}")
    Wait For Elements State       //td[text()="${itemData2}[0] piece"]  visible  timeout=60s
    #Verify Salesorder validation
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${salesorder_number}
    click  (//a[text()="${salesorder_number}"]/../../../../../../../../span)[1]
    sleep  1
#    Wait For Elements State     (//a[text()="${itemData1}[0]"])[1]/../../../../../../../../../td[6]//div[text()="${itemData2}[0] piece"]  visible  timeout=60s
    click  ${dispatchtab}
    click  ${itemviewbutton}
#    Wait For Elements State     //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${itemData1}[2] piece"]/../td[3][text()="${itemData2}[0] piece"]/../td[5]//span[text()="Dispatched"]  vivible  timeout=60s








