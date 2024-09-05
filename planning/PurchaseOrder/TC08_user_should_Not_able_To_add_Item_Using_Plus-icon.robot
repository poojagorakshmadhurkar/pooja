*** Settings ***
Documentation    create Purchase Order
Library    SeleniumLibrary
Library  String
Library  Collections
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
Resource  ../../variables.robot
Resource  ../../inventory/transactions/keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Xyzzz   Nandu   Unnati  Vendor55
@{ItemData}  0   LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  4000  100

*** Test Cases ***
User Should Not add duplicate Item using (+) sign
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation  #Smart Factory
    set selenium speed    0.05
    Landing On Purchase Order Page
    wait until page contains element    ${CREATE_NEW_BUTTON}  timeout=10s
    click    ${CREATE_NEW_BUTTON}
    Select Vendor for PO  ${vendor}[0]
    select Delivery Date  ${date}[0]
#    delivery date entry
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]
    click    ${ADD_NEW_ROW}
#    click on (+) icon
    click    ${+ICON}
    input text    ${ENTER_ITEM}      ${ItemData}[1]
    click    ${SELECT_ITEMS}
    click    ${SUBMIT4}
    #   get the row count
    ${row_count}=   Get Element Count    //tr[@class="MuiTableRow-root css-io0ou8"]
#    check row count
    Run keyword if    "${row_count}" == "2"
    ...    log    Fail - duplicate Item add
    ...    ELSE
    ...    log    Pass - We can not add duplicate Item
    log    no of rows = ${row_count}
