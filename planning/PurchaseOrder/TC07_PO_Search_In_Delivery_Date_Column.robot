*** Settings ***
Library    SeleniumLibrary
Resource    ./keyword.robot
Resource    ././variable.robot

*** Variables ***


*** Test Cases ***
Search List Page Column
    Open Browser Site
    Login To ManufApp Site
    sleep    0.05s
    select site    testingsiteautomation
    Landing On Purchase Order Page
#    click    purchase_order_refresh
    sleep    1s
    Searching Delivery Date Column
