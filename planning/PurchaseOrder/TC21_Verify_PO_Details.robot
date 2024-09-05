
*** Settings ***
Documentation    Verify PO Details
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30
${expected_text}    Issued


*** Test Cases ***
Verify PO Status
    Open Browser Site
    Login To ManufApp Site
#    select site    testingsiteautomation #Smart Factory
    Landing On Purchase Order Page
    ${order_number}=   create_po   ${ItemData}  ${vendor}   ${date}

    set selenium speed    0.5s
    Click Element    ${PO_ORDER_DETAIL}
    sleep  2
    wait until element is visible    //a[text()="${order_number}"]  20s
    wait until element is visible    //span[text()="${Vendor}[0]"]  20s
#    wait until element is visible    //span[text()="${date}[0]"]    20s    #date format space problem
    wait until element is visible     (//span[text()='${ItemData}[1]'])[1]    20S    #//span[text()='${ItemData}[1]']   20s

    wait until element is visible   (//td[text()='${ItemData}[2] kg'])[1]   20s
    log  ✅ ${order_number}, ✅ ${Vendor}[0], ✅ ${ItemData}[1], ✅ ${ItemData}[2] kg




