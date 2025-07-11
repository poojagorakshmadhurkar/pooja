*** Settings ***
Library    SeleniumLibrary
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
@{customername1}    Test01
@{itemData11}    Fgitem1  100  50

*** Test Cases ***
TC_01_VERIFY_INVENTORY_VIEW_RM_ACCESS_ENABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${RM_VIEW_CHECKBOX}
    sleep   0.5s
#    click   ${CLICK_DISALLOW_PRODUCTION_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    wait until element is visible   ${RAW_MATERIAL}   30s
    close Browser
TC_02_VERIFY_INVENTORY_VIEW_RM_ACCESS_DISABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${RM_VIEW_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    element should not be visible    ${RAW_MATERIAL}   30s
    close Browser
TC_03_VERIFY_INVENTORY_VIEW_WIP_ACCESS_ENABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${WIP_VIEW_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    wait until element is visible    ${WIP}   30s
    close Browser
TC_04_VERIFY_INVENTORY_VIEW_WIP_ACCESS_DISABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${WIP_VIEW_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    element should not be visible    ${WIP}   30s
    close Browser
TC_05_VERIFY_INVENTORY_VIEW_FG_ACCESS_ENABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${FG_VIEW_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    wait until element is visible    ${FG}   30s
    close Browser
TC_06_VERIFY_INVENTORY_VIEW_FG_ACCESS_DISABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${FG_VIEW_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    element should not be visible    ${FG}   30s
    close Browser
TC_07_VERIFY_INVENTORY_VIEW_SCRAP_ACCESS_ENABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${SCRAP_VIEW_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    wait until element is visible    ${SCRAP}   30s
    close Browser
TC_08_VERIFY_INVENTORY_VIEW_SCRAP_ACCESS_DISABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${SCRAP_VIEW_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    element should not be visible    ${SCRAP}   30s
    close Browser
TC_09_VERIFY_INVENTORY_VIEW_REJECTED_ACCESS_ENABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${REJECTED_VIEW_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    wait until element is visible    ${REJECTED}   30s
    close Browser
TC_10_VERIFY_INVENTORY_VIEW_REJECTED_ACCESS_DISABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${INVENTORY_VIEW_+_BTN}
    click   ${REJECTED_VIEW_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${WAREHOUSES}   30s
    click   ${WAREHOUSES}
    sleep   0.05s
    reload page
    element should not be visible    ${REJECTED}   30s
    close Browser

TC_11_VERIFY_TRANSACTIONS_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${STORE ACCESS TAB}
    set selenium speed    0.05s
    click   ${TRANSACTIONS_VIEW_+_BTN}
    sleep   0.5s
    click   ${VIEW_ALL_INWARD_REQUESTS_VIEW_CHECKBOX}
    sleep   0.5s
#    click   ${CLICK_DISALLOW_PRODUCTION_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${INVENTRY}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${TRANSACTIONS}   30s
    click   ${TRANSACTIONS}
    sleep   0.05s
#    reload page
    @{ALL_CUSTOMER_SO}=   Get WebElements    ${ALL_CUSTOMER_CREATED_BY_EMP_SO}
    FOR    ${elementt}    IN    @{ALL_CUSTOMER_SO}
        # Check Close Access
#        element should be enabled    ${elementt}
        wait until element is visible   ${elementt}   30s
        Log    All Inward request is visible which is created by Nitesh
    END
    sleep   0.5s
    close Browser