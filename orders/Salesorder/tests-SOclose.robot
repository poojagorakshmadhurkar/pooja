*** Settings ***
#Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
#Resource  ../../inventory/transactions/keywords.robot
#Resource  ../../variables.robot
Resource  ./variables.robot
#Resource  ../../inventory/warehouses/keywords.robot
Library    Browser


*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100

${xpath}  //span[contains(@class, 'ant-tree-title')]
${machine}  P2
${shift}  Morning Shift




*** Test Cases ***

SO Close
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible   timeout=60s
    click  (//*[name()='svg'][@id='so_details_menu'])[1]
    click  ${closebutton}
    Wait For Elements State        (//a[text()="${itemData1}[0]"])[2]  visible   timeout=60s
    input  ${closereasoninput}  Notgood
    click  //div[text()="Close ${order_number}"]
#    Wait Until Page Contains  "SO Closed Successfully"  timeout=10s
    Wait For Elements State      //span[text()="Closed"]    visible   timeout=60s
