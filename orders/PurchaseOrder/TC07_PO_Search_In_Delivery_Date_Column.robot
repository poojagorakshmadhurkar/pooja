*** Settings ***
Library    Browser
Resource   ./keyword.robot
Resource   ././variable.robot
*** Variables ***
*** Test Cases ***
Search List Page Column
#    Login To ManufApp Site
#    select site    testingsiteautomation
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Landing On Purchase Order Page
    Searching Delivery Date Column
    [Teardown]    Browser.Close Browser

