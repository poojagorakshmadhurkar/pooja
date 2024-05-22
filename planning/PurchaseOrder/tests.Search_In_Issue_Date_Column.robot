*** Settings ***
Library     SeleniumLibrary
Resource    ./keyword.robot
Resource    ././variable.robot

*** Variables ***


*** Test Cases ***
Search List Page Column
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation
    Landing On Purchase Order Page
    click    purchase_order_refresh
    Searching Issue Date Column
