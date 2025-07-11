*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    DateTime
Resource   ./../././Jobwork/Keyword.robot
Resource   ./../././Jobwork/Variable.robot
Resource   ./../././Access_Control/Keyword.robot
Resource   ./../././Access_Control/Variable.robot
Resource   ./../././orders/PurchaseOrder/keyword.robot
Resource   ./../././orders/PurchaseOrder/variable.robot

*** Variables ***

*** Test Cases ***
JW_Sorting_Column
    set selenium speed  0.05s
#    Open Browser Site
#    Login To ManufApp Site
    Open Browser In Headless Mode
    set selenium speed  0.8s
    wait until element is visible   ${JOBWORK_}    30s
    reload page
    wait until element is visible   ${JOBWORK_}    30s
    mouse over   ${JOBWORK_}
    wait until element is visible   ${TRANSACTIONS}   30s
    Safe Click Element   ${TRANSACTIONS}
    set selenium speed    0.05s
    JW_Sorting    ${Material Issue Note}   Material Issue Note
    sleep   1s
    reload page
    JW_Sorting    ${SO}   SO
    sleep   1s
    reload page
    JW_Sorting    ${Partner_Col}   Partner
    sleep   1s
    reload page
    JW_Sorting    ${Cost_Col}   Cost
    sleep   1s
    reload page
    JW_Sorting    ${Shipment_Number_Column}   Shipment Number
    sleep   1s
    reload page
    JW_Sorting    ${Test_Field_Column}    Test Field
    sleep   1s
    reload page
    JW_Sorting    ${Shipment_Type_Column}    Shipment Type
    sleep   1s
    reload page
    JW_Sorting    ${Actual_Date_Column}    Actual Date
    sleep   1s
    reload page
    JW_Sorting    ${Requested_On_Column}    Requested On
    sleep   1s
    reload page
    JW_Sorting    ${Approved_On_Column}    Approved On
    sleep   1s
    reload page
    JW_Sorting    ${Expected_On_Column}    Expected On
    sleep   1s
    [Teardown]    Close Browser




