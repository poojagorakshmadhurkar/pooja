*** Settings ***
Library    SeleniumLibrary
Library     String
Library     Collections
Resource    ./keyword.robot
Resource    ././variable.robot



*** Test Cases ***
TC02_Verify_Column_List_On_PO_Page
    Open Browser Site
    Login To ManufApp Site
    Landing On Purchase Order Page
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
    PO_Page Column_List
    Close The Browser




