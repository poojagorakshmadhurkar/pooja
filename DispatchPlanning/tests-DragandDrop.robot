*** Settings ***
Library  SeleniumLibrary
Resource  ../keywords.robot
#Resource  ../orders/Salesorder/variables.robot
Library  String
Library  Collections
#Resource  ../variables.robot
#Resource  ../orders/Salesorder/keywords.robot
Resource   ./variables.robot
Resource   ./keyword.robot
Library    CustomSeleniumKeywords.py



*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100   50
@{itemData2}  FGitem3  100
@{itemData3}  FGitem2  100
${DRAGGABLE}  //div[@id="DO-204"]
${DROPPABLE}  //div[@data-date='2024-08-15']





*** Test Cases ***
Dispatch planning
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create salesorder  ${customername}  ${itemData1}
    sleep  1
    #Dispatch validaiton
    click  ${dispatchplanbutton}
    wait until page contains   ${order_number}
    ${todaysdate}=    delivery date entry in dispatch
    set ith item in Dispatch only quantity  0  ${itemData1}[0]  ${itemData1}[2]
    sleep  1
    Click  ${dipatchsubmitbutton}
    sleep  1
    ${dispatch_number}=    Get Dispatch Number
    sleep  1
    click  ${viewschdeuledispatch}
    sleep  2
    Log    Today's date: ${todaysdate}
    Log    Customer name: ${customername}
    #Click on drawer
    Using search filters of SO  ${order_number}
    sleep  4
    CustomSeleniumKeywords.Drag And Drop  ${DRAGGABLE}  ${DROPPABLE}
    sleep  4