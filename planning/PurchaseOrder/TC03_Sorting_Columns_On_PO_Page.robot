*** Settings ***
Library    SeleniumLibrary
Library     String
Library     String
Library     Collections
Resource    ./keyword.robot
Resource    ././variable.robot

*** Variables ***

*** Test Cases ***
TC03_Sorting_Columns_On_PO_Page
    Open Browser Site
    Login To ManufApp Site
    Landing On Purchase Order Page
    click   ${ITEM_VIEW_TOGGLE_BUTTON}
    set selenium speed    0.5s
    click    ${REFRESH_ELEMENT_LOCATOR}
    Sorting   ${PO NUMBER COLUMN DATA LIST}   ${SORT_PO}    PO Number
    Sorting   ${ITEM DETAILS COLUMN DATA}   ${SORT_ITEM_DETAILS}    Item Details
    Sorting   ${VENDER COLUMN DATA}   ${SORT_VENDER}    Vendor
    Sorting   ${ISSUE DATE COLUMN DATA}   ${SORT_ISSUE_DATE}    Issue Date
    Sorting   ${DELIVERY DATE COLUMN DATA}   ${SORT_DELIVERY_DATE}  Delivery Date
    Close The Browser



