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
${customername1}
@{itemData11}
*** Test Cases ***
TC_01_VERIFY_SCHEDULING_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_03Employee Access    ${PLANNING_&_SCHEDULING}
#   View access check
    wait until element is visible   ${SCHEDULING}   30s
    sleep   0.05s
    close Browser
TC_02_VERIFY_SCHEDULING_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_03Employee Access    ${PLANNING_&_SCHEDULING}    
    set selenium speed    0.07s
#   View access check
    element should not be visible   ${SCHEDULING}   30s
    sleep   0.05s
    close Browser
TC_03_VERIFY_ENTER_PRODUCTION_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_VIEW_CHECKBOX}
    click   ${CLICK_Sche_ENTER_PRODUCTION_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_03Employee Access    ${PLANNING_&_SCHEDULING}    
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${SCHEDULING}   30s
    click   ${SCHEDULING}
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    click   ${SELECT_WO_DATE_RANGE}
    click   ${SELECT_START_DATE}
    click   ${SELECT_END_DATE}
    click   ${CLICK_ON_PLANNED_WO}
    wait until element is visible   ${ENTER_PRODUCTION_ICON}    30s
    sleep   0.05s
    close Browser
TC_04_VERIFY_ENTER_PRODUCTION_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_ENTER_PRODUCTION_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_03Employee Access    ${PLANNING_&_SCHEDULING}    
    set selenium speed    0.07s
    wait until element is visible   ${SCHEDULING}   30s
    click   ${SCHEDULING}
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    click   ${SELECT_WO_DATE_RANGE}
    click   ${SELECT_START_DATE}
    click   ${SELECT_END_DATE}
    click   ${CLICK_ON_PLANNED_WO}
    element should not be visible   ${ENTER_PRODUCTION_ICON}    30s
    sleep   0.05s
    close Browser
TC_05_VERIFY_CREATE_WO_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SALES_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_SO_VIEW_CHECKBOX}
    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}
    click   ${CLICK_CREATE_WO_CHECKBOX}
    click   ${SALES_ORDER_-_BTN}
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
#    reload page
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    click   ${SELECT_WO_DATE_RANGE}
    click   ${SELECT_START_DATE}
    click   ${SELECT_END_DATE}
    wait until element is visible   ${CREATE_WO_+_BTN}    30S
    element should not be visible   ${ENTER_PRODUCTION_ICON}    30s
    sleep   0.05s
    close Browser
TC_06_VERIFY_CREATE_WO_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    click   ${SELECT_WO_DATE_RANGE}
    click   ${SELECT_START_DATE}
    click   ${SELECT_END_DATE}
    element should not be visible   ${CREATE_WO_+_BTN}    30S
    sleep   0.05s
    close Browser
TC_07_VERIFY_EDIT_WO_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SALES_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_SO_VIEW_CHECKBOX}
    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}
    click   ${CLICK_CREATE_WO_CHECKBOX}
    click   ${SALES_ORDER_-_BTN}
    click   ${SCHEDULING_+_BTN}
    click   ${CLICK_Sche_VIEW_CHECKBOX}
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
#    click   ${SELECT_WO_DATE_RANGE}
#    click   ${SELECT_START_DATE}
#    click   ${SELECT_END_DATE}
    click   (//span[text()="Akash"])[3]     #${CLICK_ON_PLANNED_WO}
    wait until element is visible   ${EDIT_WO}
    sleep   0.05s
    close Browser
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SALES_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_SO_VIEW_CHECKBOX}
    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}
    click   ${CLICK_CREATE_WO_CHECKBOX}
    click   ${SALES_ORDER_-_BTN}
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
#    reload page
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    click   ${CREATE_WO+_BTN2}
    ${input_qty}=    Generate Random number_2_digit
    input   ${WO_QTY_INPUTBOX}  ${input_qty}
    click   ${REVIEW_CHANGE_BTN}
    click   ${CREATE_INNER_BTN}
    click   ${CLICK_SELECTED_WO}

    sleep   0.05s
    close Browser
TC_08_VERIFY_EDIT_WO_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    element should not be visible   ${CREATE_WO_+_BTN}    30S
    sleep   0.05s
    close Browser
TC_09_VERIFY_DELETE_WO_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    element should not be visible   ${CREATE_WO_+_BTN}    30S
    sleep   0.05s
    close Browser
TC_10_VERIFY_DELETE_WO_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    element should not be visible   ${CREATE_WO_+_BTN}    30S
    sleep   0.05s
    close Browser
TC_11_VERIFY_MOVE_WO_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SALES_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_SO_VIEW_CHECKBOX}
    click   ${CLICK_CREATE_WO_CHECKBOX}
    click   ${SALES_ORDER_-_BTN}
    click   ${SCHEDULING_+_BTN}
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    element should not be visible   ${CREATE_WO_+_BTN}    30S
    sleep   0.05s
    close Browser
TC_12_VERIFY_MOVE_WO_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SCHEDULING_+_BTN}
    sleep   0.5s
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    element should not be visible   ${CREATE_WO_+_BTN}    30S
    sleep   0.05s
    close Browser
TC_13_VERIFY_SHORT_CLOSE_WO_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SALES_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_SO_VIEW_CHECKBOX}
    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}
    click   ${CLICK_CREATE_WO_CHECKBOX}
    click   ${SALES_ORDER_-_BTN}
    click   ${SCHEDULING_+_BTN}
    click   ${CLICK_Sche_VIEW_CHECKBOX}
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_Sche_SHORT_CLOSE_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    click    ${SELECT_WO_DATE_RANGE}
    click    ${SELECT_START_DATE}
    click    ${SELECT_END_DATE}
    click   ${CLICK_ON_PLANNED_WO}
    wait until element is visible   ${CLICK_Sche_SHORT_CLOSE_CHECKBOX}
    sleep   0.05s
    close Browser
TC_14_VERIFY_MATERIAL_REQUEST_ACCESS_ENAABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SALES_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_SO_VIEW_CHECKBOX}
    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}
    click   ${CLICK_CREATE_WO_CHECKBOX}
    click   ${SALES_ORDER_-_BTN}
    click   ${SCHEDULING_+_BTN}
    click   ${CLICK_Sche_VIEW_CHECKBOX}
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_Sche_MATERIAL_RQST_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    click    ${SELECT_WO_DATE_RANGE}
    click    ${SELECT_START_DATE}
    click    ${SELECT_END_DATE}
    click   ${CLICK_ON_PLANNED_WO}
    wait until element is visible   ${MATERIAL_MATERIAL_ICON}
    sleep   0.05s
    close Browser
TC_15_VERIFY_MATERIAL_REQUEST_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${SALES_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_SO_VIEW_CHECKBOX}
    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}
    click   ${CLICK_CREATE_WO_CHECKBOX}
    click   ${SALES_ORDER_-_BTN}
    click   ${SCHEDULING_+_BTN}
    click   ${CLICK_Sche_VIEW_CHECKBOX}
    click   ${CLICK_Sche_CREATE/EDIT_WO_CHECKBOX}
    click   ${CLICK_Sche_MATERIAL_RQST_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${SALES ORDERS}   30s
    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
    click   ${CLICK_ON_SO_CREATE_WO}
    sleep   2s
    click   ${PLANNED_MACHINE_TOGGLE_BTN}
    click    ${SELECT_WO_DATE_RANGE}
    click    ${SELECT_START_DATE}
    click    ${SELECT_END_DATE}
    click   ${CLICK_ON_PLANNED_WO}
    element should not be visible   ${MATERIAL_MATERIAL_ICON}
    sleep   0.05s
    close Browser



