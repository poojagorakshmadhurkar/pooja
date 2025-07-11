*** Settings ***
#Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Resource  ../../inventory/transactions/keywords.robot
#Resource  ../../variables.robot
Resource  ./variables.robot
#Resource  ../../inventory/warehouses/keywords.robot
Library    Browser


*** Variables ***

@{customername}  Test01
@{itemData1}  fgitem1  100  50
@{rejection}  CheckNUt  Damage  10
${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}  P2
${shift}  Morning Shift




*** Test Cases ***

SoFGProduction
    login devsite
    select site  TestingSite_Automation_LOTcase4
    open warehouse
    ${bookquantity1} =  Get current Quantity of FG Booked Stock  ${itemData1}[0]
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible  timeout=30s