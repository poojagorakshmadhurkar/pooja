*** Settings ***
Documentation    Verify Status Of PO
Library    Browser
Library    String
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_Type}  Raw Material  FG
@{Vendor}   Newvendortest01  Gupta Store        #Nandu   #Newvendortest02   Unnati
@{ItemData}  0  HR00004   50  25   1190     #CR00004
@{ItemData1}  1  HR00003  20  5    1178     #CR00003
@{ItemData2}  2  HR00002  30  7    1198      #CR00002
@{ItemData3}  3  HR00001  40  10   1197     #CR00001
${expected_text}    Issued
@{inspected_By}   Akshay    Testingname    Akash   #Afzal   Cindy   Demo Employee
#@{Deliverd_qnt}   5  10  15   20

*** Test Cases ***
PO Inward_Flow(Status - Withdraw)
#    Login To ManufApp Site    # Login To Dev Site
    # select site    testingsiteautomation    #Smart Factory        #testingsiteautomation
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Landing On Purchase Order Page
    Verify Inward Request details(Withdraw)
    [Teardown]    Browser.Close Browser
PO Inward_Flow(Staus - Partially_Received)
    Login To ManufApp Site    # Login To Dev Site
    # select site    testingsiteautomation    #Smart Factory        #testingsiteautomation
    Landing On Purchase Order Page
    Verify Inward Request details(Partially_Received)
    [Teardown]    Browser.Close Browser
PO Inward_Flow(Status - Received)
    Login To ManufApp Site    # Login To Dev Site
    # select site    testingsiteautomation    #Smart Factory        #testingsiteautomation
    Landing On Purchase Order Page
    Verify Inward Request details(Received)
    [Teardown]    Browser.Close Browser

