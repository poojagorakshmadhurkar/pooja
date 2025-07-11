*** Settings ***
Library    Browser
Library    String
Library    String
Library    Collections
Resource   ./keyword.robot
Resource   ././variable.robot

*** Variables ***

*** Test Cases ***
TC03_Sorting_Columns_On_PO_Page
#    Login To ManufApp Site
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Landing On Purchase Order Page
    click   ${ITEM_VIEW_TOGGLE_BUTTON}
    click    ${REFRESH_ELEMENT_LOCATOR}
    Sorting   ${PO NUMBER COLUMN DATA LIST}   ${SORT_PO}    ${AFTER CLK SORT DATA2}   PO Number
#    Sorting   ${ITEM DETAILS COLUMN DATA}   ${SORT_ITEM_DETAILS}    ${AFTER CLK SORT DATA2}    Item Details
    Sorting   ${VENDER COLUMN DATA}   ${SORT_VENDER}    ${AFTER CLK SORT DATA2}    Vendor
    Sorting   ${ISSUE DATE COLUMN DATA}   ${SORT_ISSUE_DATE}    ${AFTER CLK SORT DATA2}    Issue Date
    Sorting   ${DELIVERY DATE COLUMN DATA}   ${SORT_DELIVERY_DATE}  ${AFTER CLK SORT DATA2}    Delivery Date
    [Teardown]    Browser.Close Browser





