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
@{itemData1}  Fgitem1  100   50
@{itemData2}  FGitem3  100
@{itemData3}  FGitem2  100





*** Test Cases ***
Dispatch planning

    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create salesorder  ${customername}  ${itemData1}
    #Dispatch validaiton
    click  ${dispatchplanbutton}
    Wait For Elements State    (//span[text()="${order_number}"])[1]  visible   timeout=60s
    ${todaysdate}=    delivery date entry in dispatch
    set ith item in Dispatch only quantity  0  ${itemData1}[0]  ${itemData1}[2]
    Click  ${dipatchsubmitbutton}
    ${dispatch_number}=    Get Dispatch Number
    click  ${viewschdeuledispatch}
    #Click on drawer
     ${dispatchordernumber}=    Strip String    ${dispatch_number}

    #Click on drawer
    Open Event monthwise Drawer  ${dispatchordernumber}  ${customername}  ${order_number}
    #validation in salesorder
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    #wait until element is visible    //a[text()="${itemData1}[0]"]/../../../../../../../../../td[5]//div[text()="${itemData1}[2] piece"]
    #Editing Dispatch order
    open dispatch order page
     ${dispatchordernumber}=    Strip String    ${dispatch_number}
    #Click on drawer
    Open Event monthwise Drawer  ${dispatchordernumber}  ${customername}  ${order_number}
    click  ${editdispatcheventbutton}
    click  ${dipatcheditbutton}
    set ith item in Dispatch only quantity  0  ${itemData1}[0]  ${itemData1}[1]
    Click  ${dipatchsubmitbutton}
    click  ${dispatchbackbutton}
     ${dispatchordernumber}=    Strip String    ${dispatch_number}
    #Click on drawer
    Open Event monthwise Drawer  ${dispatchordernumber}  ${customername}  ${order_number}
    #validation in salesorder
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    #wait until element is visible    //a[text()="${itemData1}[0]"]/../../../../../../../../../td[5]//div[text()="${itemData1}[1] piece"]





