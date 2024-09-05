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

SO Close
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    sleep  1
    click  (//*[name()='svg'][@id='so_details_menu'])[1]
    click  ${closebutton}
    wait until element is visible    (//a[text()="${itemData1}[0]"])[2]
    input  ${closereasoninput}  Notgood
    sleep  1
    click  //button[text()="Close ${order_number}"]
#    Wait Until Page Contains  "SO Closed Successfully"  timeout=10s

    wait until element is visible  //span[text()="Closed"]
