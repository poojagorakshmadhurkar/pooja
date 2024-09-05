*** Settings ***
Library  SeleniumLibrary
Resource  ../keywords.robot
Resource  ../planning/Salesorder/variables.robot
Library  String
Library  Collections
Resource  ../variables.robot
Resource  ../planning/Salesorder/keywords.robot
Resource   ./variables.robot
Resource   ./keyword.robot


*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100  50
@{itemData2}  50
@{itemData3}  FGitem2  100





*** Test Cases ***
Dispatch planning for fully recieved
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    ${salesorder_number}=  Create salesorder  ${customername}  ${itemData1}
    sleep  1
    #Dispatch validaiton
    click  ${dispatchplanbutton}
    wait until page contains   ${salesorder_number}
    ${todaysdate}=    delivery date entry in dispatch
    set ith item in Dispatch only quantity  0  ${itemData1}[0]  ${itemData1}[2]
    sleep  1
    Click  ${dipatchsubmitbutton}
    sleep  1
    ${dispatch_number}=    Get Dispatch Number
    sleep  1
    click  ${viewschdeuledispatch}
    sleep  2
    #Click on drawer
    Open Event monthwise Drawer  ${dispatch_number}  ${customername}  ${salesorder_number}
    sleep  2
    #validation in salesorder
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${salesorder_number}
    click  //a[text()="${salesorder_number}"]/../../../../../../../../span
    sleep  2
    wait until element is visible    //a[text()="${itemData1}[0]"]/../../../../../../../../../td[5]//div[text()="${itemData1}[2] piece"]
    #Shiped the Dispatch order
    sleep  2
    open dispatch order page
    Open Event monthwise Drawer  ${dispatch_number}  ${customername}  ${salesorder_number}
    sleep  1
    click  ${dispatchshipmentbutton}
    sleep  1
    wait until element is visible  //span[text()="${salesorder_number}"]/../../../../../div[1]//span[text()="${customername}[0]"]
    set ith item only quantity for outward   0   ${itemData1}[0]  ${itemData2}[0]
    click  ${outwardsubmit}
    sleep  2
    approve outward
    reload page
    sleep  2
    #verify Dispatch partially recived status
    open dispatch order page
    Select Day Option from dropdown
    Using search filters of SO  ${salesorder_number}
    sleep  2
    Open Event Daywise Drawer   ${customername}  ${dispatch_number}
    wait until element is visible  //span[text()="Dispatched"]
    Log  ${itemData1[0]}  # Should log Fgitem1
    Log  ${itemData1[1]}  # Should log 100
    Log  ${itemData1[2]}
    wait until element is visible  //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${itemData1}[2] piece"]/../td[3][text()="${itemData2}[0] piece"]
    ${value}  Set Variable  ${itemData1}[2]-${itemData2}[0]
    ${remainingvalue}  Evaluate  eval("${value}")
    wait until element is visible    //td[text()="${itemData2}[0] piece"]
    #Verify Salesorder validation
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${salesorder_number}
    click  //a[text()="${salesorder_number}"]/../../../../../../../../span
    sleep  2
    wait until element is visible  (//a[text()="${itemData1}[0]"])[1]/../../../../../../../../../td[6]//div[text()="${itemData2}[0] piece"]
    click  ${dispatchtab}
    sleep  1
    click  ${itemviewbutton}
    wait until element is visible  //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${itemData1}[2] piece"]/../td[3][text()="${itemData2}[0] piece"]/../td[5]//span[text()="Dispatched"]








