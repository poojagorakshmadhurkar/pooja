*** Settings ***
Library    Browser
Library    String
Library    Collections
Library    DateTime
Resource   ../../././Access_Control/Keyword.robot
Resource   ../../././orders/PurchaseOrder/keyword.robot
Resource   ../../././orders/PurchaseOrder/variable.robot
Resource   ../.././inventory/Rework_Reuse_Scrap/Keyword1.robot
Resource   ../.././inventory/Rework_Reuse_Scrap/Variable1.robot
*** Variables ***
${my_text}    Sales Orders

*** Test Cases ***
TC_01_VERIFY_ALL_CUSTOMER/VENDOR_VIEW_ACCESS
    Owner Login    Nitesh   ${PLANNING ACCESS TAB}
    click   ${CUSTOMER/VENDOR_+_BTN}
    Wait For Elements State  ${CLICK_VIEW_ALL_CUSTOMER/VENDOR_CHECKBOX}   visible  timeout=60s
    Sleep   1s
    Click   ${CLICK_VIEW_ALL_CUSTOMER/VENDOR_CHECKBOX}
    Sleep   1s
    click   ${CLICK_SUBMIT}
    TC_02Employee Access    ${ORDERS}
    Hover  ${MASTERS1}
    click   ${CUSTOMERS}
    click   ${MASTERS1}
    Wait For Load State
#    Wait For Elements State   ${ALL_CUSTOMERS_LIST}   visible  timeout=30s
    @{Customer_list}=    Get Elements    ${ALL_CUSTOMERS_LIST}
    # For each loop
    FOR    ${element1}    IN    @{Customer_list}
        # Check Close Access
       Wait For Elements State    ${element1}    visible  timeout=30s
       Log    All Customers is visible
    END
    click   ${JOBWORK_CUSTOMER}
    close Browser
TC_02_VERIFY_EMP_LEVEL_CUSTOMER/VENDOR_VIEW_ACCESS
    Owner Login    Nitesh   ${PLANNING ACCESS TAB}
    click   ${CUSTOMER/VENDOR_+_BTN}
    Wait For Elements State    ${CLICK_VIEW_ALL_CUSTOMER/VENDOR_CHECKBOX_UNCHECK}   visible  timeout=60s
    Sleep   2s
    Click   ${CLICK_VIEW_ALL_CUSTOMER/VENDOR_CHECKBOX}
    Sleep   1s
    click   ${CLICK_SUBMIT}
    TC_02Employee Access    ${ORDERS}
    Hover  ${MASTERS1}
    click   ${CUSTOMERS}
    click   ${MASTERS1}
    Reload
#    Wait For Elements State   ${EMP_LEVEL_CUSTOMER_LIST}  visible  timeout=30s
    @{Customer_list}=    Get Elements    ${EMP_LEVEL_CUSTOMER_LIST}
    # For each loop
    FOR    ${element1}    IN    @{Customer_list}
       Wait For Elements State    ${element1}    visible  timeout=30s
       Log    Created by employee Customers is visible only
    END
    close browser
#TC_03_VERIFY_MASK_CUSTOMER/VENDOR_CODE
#    Owner Login    Nitesh   ${PLANNING ACCESS TAB}
#    click   ${CUSTOMER/VENDOR_+_BTN}
#    click   ${CLICK_MASK_CUSTOMER_NAME_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    TC_02Employee Access    ${ORDERS}
#    Hover  ${MASTERS1}
#    click   ${CUSTOMERS}
#    click   ${MASTERS1}
#    Wait For Elements State   ${MASK_CUSTOMER_CODE}   visible  timeout=30s
#    @{Mask_Cust_list}=    Get Elements   ${MASK_CUSTOMER_CODE}
#    # For each loop
#    FOR    ${element2}    IN    @{Mask_Cust_list}
#       Wait For Elements State    ${element2}    visible  timeout=30s
#        Log    Customer code is visible
#    END
#    Browser.Close Browser
#TC_04_VERIFY_UNMASK_CUSTOMER/VENDOR_CODE
#    Owner Login    Nitesh   ${PLANNING ACCESS TAB}
#    click   ${CUSTOMER/VENDOR_+_BTN}
#    click   ${CLICK_MASK_CUSTOMER_NAME_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access    ${ORDERS}
#    Hover  ${MASTERS1}
#    click   ${CUSTOMERS}
#    click   ${MASTERS1}
#    Reload
#    Wait For Elements State   ${UNMASK_CUSTOMER_CODE}   visible  timeout=30s
#    close browser
*** Keywords ***
Check Outer Checkbox If Unchecked
    # Check if the checkbox is checked or not
    ${is_checked1}=  Get Attribute  ${CLICK_SO_CHECKBOX}  ant-tree-checkbox ant-tree-checkbox-checked
    ${is_checked2}=  Get Attribute  ${CLICK_SO_CHECKBOX}  ant-tree-checkbox-inner
    ${is_unchecked}=  Get Attribute  ${CLICK_SO_CHECKBOX}  ant-tree-checkbox-inner

    # If the checkbox is unchecked (i.e., ${is_checked} is None), then check it
    Run Keyword If  '${is_checked1}' == 'none'  Click   ${CLICK_SO_CHECKBOX}
    Run Keyword If  '${is_checked2}' == 'none'  Click   ${CLICK_SO_CHECKBOX}
    Log  'Checkbox was unchecked, now it is checked'

    # If the checkbox is already checked, log that it is skipped
    Run Keyword If  '${is_checked1}' != 'None'  Log  'Checkbox is already checked, skipping'
