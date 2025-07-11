*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    DateTime
Resource   ../../././Access_Control/Keyword.robot
Resource   ../../././Access_Control/Variable.robot
Resource   ../../././orders/PurchaseOrder/keyword.robot
Resource   ../../././orders/PurchaseOrder/variable.robot
*** Variables ***
${customername1}
@{itemData11}
*** Test Cases ***
TC_01_VERIFY_JOBWORK_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_03Employee Access    ${JOBWORK_}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${JOBWORK_}   30s
    sleep   0.05s
    close Browser
TC_02_VERIFY_JOBWORK_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
    close Browser
    Open Chrome Browser In Incognito Mode
    sleep   1s
    element should not be visible   ${JOBWORK_}   30s
    close Browser
TC_03_VERIFY_JOBWORK_ADD/EDIT_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_VIEW_CHECKBOX}
    click   ${CLICK_JOBWORK_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${JOBWORK_}
    set selenium speed    0.07s
    wait until element is visible   ${TRANSACTIONS}   30s
    click   ${TRANSACTIONS}
    wait until element is visible   ${+JOBWORK}   30s
    Safe Click Element   ${+JOBWORK}
    Select into Dropdown    ${JOBWORK_VENDOR_INPUTBOX}    JWVEN0018
    Select Date   ${DELIVERY_DATE}   Today
    ${randomrefNumber}=   Generate Random number_2_digit
    input   ${ENTER_JOW_COST}   ${randomrefNumber}
    ${ranNumber}=   Generate Random number_6_digit
    input   ${ENTER_SHP_NUM}   ${ranNumber}
    Select Shipement Type   ${SELECT_SHP_TYPE}  fresh
    sleep   0.5s
    Select Date    ${ACTUAL_DATE}   Today
    Select into Dropdown    ${SELECT_ITEM_CODE}     WIP00004
    ${randomfNum}=   Generate Random number_2_digit
    input   ${ENTER_QTY}    ${randomfNum}
    click   ${JBW_SUBMIT}
    sleep   0.05s
    mouse over   ${JOBWORK_}
    click   ${TRANSACTIONS}
    click   ${CREATED_JBW_NOTE}
    wait until element is visible    ${JOBW_EDIT}    30s
    sleep   0.05s
    close Browser
TC_04_VERIFY_JOBWORK_ADD/EDIT_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${JOBWORK_}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${TRANSACTIONS}   30s
    click   ${TRANSACTIONS}
    element should not be visible   ${+JOBWORK}   30s
    sleep   0.05s
    click   ${CREATED_JBW_NOTE}
    sleep   0.5s
    element should not be visible   ${JOBW_EDIT}   30s
    close Browser
TC_05_VERIFY_JOBWORK_APPROVE_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_VIEW_CHECKBOX}
    click   ${CLICK_JOBWORK_APPROVAL_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${JOBWORK_}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${TRANSACTIONS}   30s
    click   ${TRANSACTIONS}
    wait until element is visible   ${+JOBWORK}   30s
    sleep   0.05s
    close Browser
TC_06_VERIFY_JOBWORK_ADD/EDIT_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_VIEW_CHECKBOX}
    click   ${CLICK_JOBWORK_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${JOBWORK_}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${TRANSACTIONS}   30s
    click   ${TRANSACTIONS}
    wait until element is visible   ${+JOBWORK}   30s
    sleep   0.05s
    close Browser
TC_07_VERIFY_JOBWORK_ADD/EDIT_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_VIEW_CHECKBOX}
    click   ${CLICK_JOBWORK_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${JOBWORK_}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${TRANSACTIONS}   30s
    click   ${TRANSACTIONS}
    wait until element is visible   ${+JOBWORK}   30s
    sleep   0.05s
    close Browser
TC_08_VERIFY_JOBWORK_ADD/EDIT_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_VIEW_CHECKBOX}
    click   ${CLICK_JOBWORK_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${JOBWORK_}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${TRANSACTIONS}   30s
    click   ${TRANSACTIONS}
    wait until element is visible   ${+JOBWORK}   30s
    sleep   0.05s
    close Browser
TC_09_VERIFY_JOBWORK_ADD/EDIT_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_VIEW_CHECKBOX}
    click   ${CLICK_JOBWORK_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${JOBWORK_}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${TRANSACTIONS}   30s
    click   ${TRANSACTIONS}
    wait until element is visible   ${+JOBWORK}   30s
    sleep   0.05s
    close Browser
TC_10_VERIFY_JOBWORK_ADD/EDIT_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${JOBWORK_+_BTN}
    sleep   0.5s
    click   ${CLICK_JOBWORK_VIEW_CHECKBOX}
    click   ${CLICK_JOBWORK_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${JOBWORK_}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${TRANSACTIONS}   30s
    click   ${TRANSACTIONS}
    wait until element is visible   ${+JOBWORK}   30s
    sleep   0.05s
    close Browser
