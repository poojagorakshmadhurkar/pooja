*** Settings ***
Documentation    Verify PO Details
Library    Browser
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30    101
${expected_text}    Issued

*** Test Cases ***
Verify PO Status
    Login To ManufApp Site
#    select site    testingsiteautomation #Smart Factory
    Landing On Purchase Order Page
    ${order_number}=   create_po   ${ItemData}  ${vendor}
    Click    ${PO_ORDER_DETAIL}
    sleep  2
    Wait For Elements State   (//a[text()="${order_number}"])[2]  visible   timeout=30s
    Wait For Elements State   //span[text()="${Vendor}[0]"]  visible   timeout=30s
#    Wait For Elements State   //span[text()="${date}[0]"]    visible   timeout=30s    #date format space problem
    Wait For Elements State   (//span[text()='${ItemData}[1]'])[1]    timeout=30s    #//span[text()='${ItemData}[1]']   visible   timeout=30s
    Wait For Elements State   (//td[text()='${ItemData}[2] kg'])[1]   visible   timeout=30s
    log  ✅ ${order_number}, ✅ ${Vendor}[0], ✅ ${ItemData}[1], ✅ ${ItemData}[2] kg
    [Teardown]    Browser.Close Browser



