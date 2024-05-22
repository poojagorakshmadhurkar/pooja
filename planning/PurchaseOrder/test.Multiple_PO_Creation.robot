*** Settings ***
Documentation    create Purchase Order
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_Type}  Raw Material  FG
@{Vendor}  Gupta Store  Nandu   Unnati  Newvendortest02
@{ItemData}  0  HR00004   1000  25
@{ItemData1}  1  HR00003  2000  50
@{ItemData2}  2  HR00002  3000  75
@{ItemData3}  3  HR00001  4000  100

*** Test Cases ***
Create Multiple PO
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation
    Landing On Purchase Order Page
    multiple po creation    ${vendor}  ${date}   ${ItemData}


