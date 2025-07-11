*** Settings ***
Documentation    create Purchase Order
Library    Browser
Library  String
Library  Collections
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
Resource  ../../variables.robot
Resource  ../../inventory/transactions/keywords.robot

*** Variables ***
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Xyzzz   Nandu   Unnati  Vendor55
@{ItemData}  0   LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  4000  100    2311

*** Test Cases ***
User Should Not add duplicate Item using (+) sign
#    Login To ManufApp Site
#    select site    testingsiteautomation  #Smart Factory
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Landing On Purchase Order Page
    Sleep    3s
    Wait For Load State    domcontentloaded    timeout=30s
    click   ${CREATE_NEW_BUTTON}
    Wait For Load State    domcontentloaded    timeout=30s
    Select Vendor for PO  ${vendor}[0]
    select Delivery Date
    # delivery date entry
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]  ${ItemData}[4]
    # click    ${ADD_NEW_ROW}
    # click on (+) icon
    click    ${+ICON}
    input    ${ENTER_ITEM}      ${ItemData}[1]
    click    ${SELECT_ITEMS}
    click    ${SUBMIT4}
    # get the row count
    ${row_count}=   Get Element Count    //tr[@class="MuiTableRow-root css-io0ou8"]
    # check row count
    Run keyword if    "${row_count}" == "2"
    ...    log    Fail - duplicate Item add
    ...    ELSE
    ...    log    Pass - We can not add duplicate Item
    log    no of rows = ${row_count}
    [Teardown]    Browser.Close Browser
