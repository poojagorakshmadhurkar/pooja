*** Settings ***
Library    Browser
Library     String
Library     Collections
Resource    ./keyword.robot
Resource    ./variable.robot


*** Test Cases ***
TC01_Refresh_Purchase_Order_Page
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Landing On Purchase Order Page
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
    [Teardown]    Browser.Close Browser

