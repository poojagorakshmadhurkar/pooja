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

*** Variables ***
${TABLE_XPATH}   //div[@class="ant-table-body"]


*** Test Cases ***

So Delete
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
#    Evaluate Javascript       document.querySelector('.ant-table-body').scrollLeft = 1000
    click  //a[text()="${order_number}"]//ancestor::tr/td[13]//button[@text="Delete"]
    click  ${deactivatebutton}
    Reload
    search Sonumber in SoListpage for validation  ${order_number}
    Wait For Elements State       //a[text()="${order_number}"]  hidden   timeout=60s
