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

So Delete
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    sleep  1
    click  //a[text()="${order_number}"]/../../../../../../../../../../td[11]//*[name()='svg'][@id='sales_order_delete']
    click  ${deactivatebutton}
    reload page
    sleep  2
    search Sonumber in SoListpage for validation  ${order_number}
    wait until page does not contain element    //a[text()="${order_number}"]  timeout=30s
