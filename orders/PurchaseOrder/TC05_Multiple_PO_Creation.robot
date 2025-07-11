*** Settings ***
Documentation    create Purchase Order
Library    Browser
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
#@{date}   ${D_Date}
@{Item_Type}  Raw Material  FG
@{Vendor}   Newvendortest01  Niteshmoon   Nandu   Unnati  Newvendortest02
@{ItemData}  0  HR00005   1000  25   101       #CR00002
@{ItemData1}  1  HR00004  2000  50   102       #HR00003
@{ItemData2}  2  HR00003  3000  75   103       #HR00002
@{ItemData3}  3  HR00002  4000  100   104       #HR00001

*** Test Cases ***
Create Multiple PO
#    Login To ManufApp Site
#    select site    testingsiteautomation
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Landing On Purchase Order Page
    ${PO_No}=   Multiple PO Creation   ${vendor}   ${ItemData}
    [Teardown]    Browser.Close Browser
#    sleep   2s
#    ${Status}   get text    //div[normalize-space(text())='${PO_No} Issued']



