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
Create_JobWork
    Login To ManufApp Site2
    Select Your Site    7    Main_Automation_Unit
    ${qty}=   JOW_Creation    ${ItemData}[0]    ${ItemData}[1]   ${JW_Vendor}


*** Keywords ***
Validation 1
    log to console   ✅ Current Stock Qty is Accurate
Validation 2
    log to console   ❌ Current Stock Qty is Wrong
Validation 3
    log to console   ✅ On Hand Qty is Accurate
Validation 4
    log to console   ❌ On Hand Qty is Wrong


Search And Extract Item Details
    [Arguments]    ${item_data}    ${category_locator}    ${column_start}    ${cs_column}    ${booked_column}    ${oh_column}    ${ordered_column}    ${subcon_column}    ${net_column}
    Search Item in Item Details SearchBox    ${item_data}    1    1    2
    Sleep    2s
    ${cs}=    Get Text    (//td[@class='ant-table-cell'])[${cs_column}]
    ${booked}=    Get Text    (//td[@class='ant-table-cell'])[${booked_column}]
    ${oh}=    Get Text    (//td[@class='ant-table-cell'])[${oh_column}]
    ${ordered}=    Get Text    (//td[@class='ant-table-cell'])[${ordered_column}]
    ${subcon_qty}=    Get Text    (//td[@class='ant-table-cell'])[${subcon_column}]
    ${net_qty}=    Run Keyword If    ${net_column}    Get Text    (//td[@class='ant-table-cell'])[${net_column}]    ELSE    Set Variable    ${EMPTY}
    Log    CS of ${item_data} is = ✅ ${cs}
    Log    Booked Qty of ${item_data} is = ✅ ${booked}
    Log    OH Qty of ${item_data} is = ✅ ${oh}
    Log    Ordered Qty of ${item_data} is = ✅ ${ordered}
    Log    Subcon Qty of ${item_data} is = ✅ ${subcon_qty}
    Run Keyword If    $net_column    Log    Net Qty of ${item_data} is = ✅ ${net_qty}
    # Extract numeric value (integer or float) and handle invalid cases
    ${initial_cs_qty}=    Extract Numeric Value    ${cs}
    ${initial_booked_qty}=    Extract Numeric Value    ${booked}
    ${initial_oh_qty}=    Extract Numeric Value    ${oh}
    ${initial_ordered_qty}=    Extract Numeric Value    ${ordered}
    ${initial_subcon_qty}=    Extract Numeric Value    ${subcon_qty}
    ${initial_net_qty}=    Run Keyword If    $net_column    Extract Numeric Value    ${net_qty}    ELSE    Set Variable    0.0
    RETURN    ${initial_cs_qty}    ${initial_booked_qty}    ${initial_oh_qty}    ${initial_ordered_qty}    ${initial_subcon_qty}    ${initial_net_qty}

Extract Numeric Value
    [Arguments]    ${text}
    # Ensure text is a string and strip whitespace
    ${text}=    Convert To String    ${text}
    # Replace commas and remove non-numeric characters except decimal and negative sign
    ${cleaned_text}=    Run Keyword If    '${text}' != '${EMPTY}'    Evaluate    re.sub(r'[^\d]', '', '${text}'.replace(',', ''))
    ...    modules=re
    ...    ELSE    Set Variable    "0"
    # Check for special cases
    ${is_no_data}=    Set Variable If    "${cleaned_text}" == "-"    True    False
    ${has_decimal}=    Set Variable If    "." in "${cleaned_text}" and "${cleaned_text}" != "."    True    False
    # Determine numeric value based on conditions
    ${numeric_value}=    Run Keyword If    ${is_no_data} or "${cleaned_text}" == "" or "${cleaned_text}" == "."
    ...    Set Variable    0.0
    ...    ELSE IF    ${has_decimal}
    ...    Convert To Number    ${cleaned_text}
    ...    ELSE IF    any(c.isdigit() for c in "${cleaned_text}")
    ...    Convert To Integer    ${cleaned_text}
    ...    ELSE
    ...    Set Variable    0.0
    RETURN    ${numeric_value}
