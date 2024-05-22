*** Settings ***
Library    SeleniumLibrary
Resource    ./keyword.robot
Resource    ././variable.robot


#Verify PO Action column should have 3 button (1.Action ,inward ,close)
*** Test Cases ***
Verify PO_Action Column
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation
    Landing On Purchase Order Page
    Verify Buttons

*** Keywords ***
Verify Buttons
   set selenium speed    0.05s
   wait until element is visible    ${PO_HOLE_PAGE_HIGHLIGHT}   20s
#   Verify Details Button
   page should contain element  purchase_order_details      Details
#   Verify Inward Button
   page should contain element  purchase_order_inward       Inward
#   Verify Withdraw button
   page should contain element  (//*[name()='svg'][@id='purchase_order_withdraw '])     Withdraw          #purchase_order_withdraw     Withdraw