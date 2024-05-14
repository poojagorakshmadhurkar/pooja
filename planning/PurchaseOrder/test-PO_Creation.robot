*** Settings ***
Documentation    create Purchase Order
Library    SeleniumLibrary
Library  String
Library  Collections
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
Resource  ../../variables.robot
Resource  ../../inventory/transactions/keywords.robot


*** Variables ***
@{date}   15-05-2024
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Xyzzz   Nandu   Unnati  Vendor55
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30

*** Test Cases ***
PO Creation
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation  #Smart Factory
    Landing On Purchase Order Page
    create_po   ${ItemData}  ${vendor}   ${date}





