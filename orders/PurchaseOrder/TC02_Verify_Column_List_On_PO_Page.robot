*** Settings ***
Library    Browser
Library     String
Library     Collections
Resource    ./keyword.robot
Resource    ././variable.robot

*** Test Cases ***
TC02_Verify_Column_List_On_PO_Page
#    Login To ManufApp Site
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Landing On Purchase Order Page
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
    PO Table Heading List
    PO_Page Column_List     ${PO NUMBER COLUMN DATA LIST}   PO Number column Data List
    PO_Page Column_List     ${ITEM DETAILS COLUMN DATA}   Item Details column Data List
    PO_Page Column_List     ${PARTNER ITEM DETAILS COLUMN DATA}   Partner Item Details column Data List
    PO_Page Column_List     ${ORDERED (Primary) COLUMN DATA}   Ordered (Primary) column Data List
    PO_Page Column_List     ${DELEVERD COLUMN DATA}   Delivered column Data List
    PO_Page Column_List     ${REJECTED COLUMN DATA}   Rejected column Data List
    PO_Page Column_List     ${REMAINING COLUMN DATA}   Remaining Column Data List
    PO_Page Column_List     ${VENDER COLUMN DATA}   Vendor Column Data List
    PO_Page Column_List     ${ISSUE DATE COLUMN DATA}   Issue Date Column Data List
    PO_Page Column_List     ${DELIVERY DATE COLUMN DATA}   Delivery Date Column Data List
    PO_Page Column_List     ${PRICE COLUMN DATA}   Price Column Data List
    PO_Page Column_List     ${CREATED BY COLUMN DATA}   Created by column Data List
    PO_Page Column_List     ${APPROVED BY COLUMN DATA}   Approved by column Data List
    PO_Page Column_List     ${STATUS COLUMN LIST}   Status column Data List
    [Teardown]    Browser.Close Browser








