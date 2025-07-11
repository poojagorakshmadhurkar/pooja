*** Settings ***
Library    Browser
Resource    ./keyword.robot
Resource    ././variable.robot

#Verify PO Action column should have 3 button (1.Action ,inward ,close)
*** Test Cases ***
Verify PO_Action Column
    Login To ManufApp Site
    Select Your Site  11   Smart Factory   #testingsiteautomation
    Landing On Purchase Order Page
    sleep    1s
    Verify Buttons

*** Keywords ***
Verify Buttons
   Wait For Elements State    ${PO_HOLE_PAGE_HIGHLIGHT}   visible   timeout=30s
   # Verify Details Button
   Wait For Elements State   ${PO_ORDER_DETAIL}   Details
   # Verify Inward Button
   Wait For Elements State   ${INWARD}   Inward
   # Verify Withdraw button
   Wait For Elements State   ${WITHDRAW}   Withdraw          #purchase_order_withdraw     Withdraw
   [Teardown]    Browser.Close Browser
