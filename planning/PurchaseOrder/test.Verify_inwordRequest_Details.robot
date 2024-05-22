*** Settings ***
Documentation    Verify Status Of PO
Library    SeleniumLibrary
Library    String
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_Type}  Raw Material  FG
@{Vendor}  Gupta Store  #Nandu   Unnati  Newvendortest02
@{ItemData}  0  HR00004   50  25
@{ItemData1}  1  HR00003  20  5
@{ItemData2}  2  HR00002  30  7
@{ItemData3}  3  HR00001  40  10
${expected_text}    Issued
@{inspected_By}   Testingname   #Afzal   Cindy   Demo Employee
#@{Deliverd_qnt}   5  10  15   20

*** Test Cases ***
PO Inward_Flow(Status - Withdraw)
    set selenium speed    0.05s
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation    #Smart Factory        #testingsiteautomation
    Move to Purchase Order Page
    Verify Inward Request details(Withdraw)

PO Inward_Flow(Staus - Partially_Received)
    set selenium speed    0.05s
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation    #Smart Factory        #testingsiteautomation
    Move to Purchase Order Page
    Verify Inward Request details(Partially_Received)

PO Inward_Flow(Status - Received)
    set selenium speed    0.05s
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation    #Smart Factory        #testingsiteautomation
    Move to Purchase Order Page
    Verify Inward Request details(Received)