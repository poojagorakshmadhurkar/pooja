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
@{ItemData}   FG00004   WIP00001    RM00001
${JW_Vendor}   Nitesh_JW_Subcontractor
*** Test Cases ***
Create_Repair_Request
    Login To ManufApp Site2
    Select Your Site    7    Main_Automation_Unit
    ${qty}=   Repair Request    ${ItemData}[0]    ${ItemData}[1]   ${JW_Vendor}
