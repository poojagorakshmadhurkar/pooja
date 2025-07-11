*** Settings ***
Library    Browser
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
Searching On Jobwork
    Login To ManufApp Site
    Wait For Elements State   ${Subcontracting}   visible  timeout=30s
    Reload
    Wait For Elements State   ${Subcontracting}   visible  timeout=30s
    Hover   ${Subcontracting}
    Wait For Elements State   ${TRANSACTIONS}  visible  timeout=30s
    Click   ${TRANSACTIONS}
    sleep   1s
    Wait For Elements State   ${JW_Item_View_toggle}  visible  timeout=30s
    Click   ${JW_Item_View_toggle}
    sleep   1s
    JBW_Searching   Item Details    Core_i5_DRESSING PROCESS     1    1   2
    Close Browser