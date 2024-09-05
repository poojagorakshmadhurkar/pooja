*** Settings ***
Documentation    create Purchase Order
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_Type}  Raw Material  FG
@{Vendor}   Gupta Store  Niteshmoon   Nandu   Unnati  Newvendortest02
@{ItemData}  0   HR00005   1000  25          #CR00002
@{ItemData1}  1  HR00004  2000  50          #HR00003
@{ItemData2}  2  HR00003  3000  75          #HR00002
@{ItemData3}  3  HR00002  4000  100         #HR00001

*** Test Cases ***
Create Multiple PO
    Open Browser Site
    Login To ManufApp Site
    sleep    1s
    select site    testingsiteautomation
    Landing On Purchase Order Page
    multiple po creation    ${vendor}  ${date}   ${ItemData}


