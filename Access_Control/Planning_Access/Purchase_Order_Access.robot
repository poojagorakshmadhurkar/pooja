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

*** Test Cases ***
TC_01_VERIFY_PURCHASE_ORDER_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${PURCHASE ORDERS}   30s
    sleep   0.05s
    close Browser
TC_02_VERIFY_WITH_PRICE_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_WITH_PRICE_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
    wait until element is visible   ${PRICE_COLUMN}    30s
    click   ${ITEM_VIEW_TOGGLE_BUTTON}
    wait until element is visible   ${PRICE_COLUMN}    30s
    sleep   0.05s
    close Browser
TC_03_VERIFY_WITH_PRICE_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_WITH_PRICE_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
    element should not be visible   ${PRICE_COLUMN}    30s
    click   ${ITEM_VIEW_TOGGLE_BUTTON}
    element should not be visible   ${PRICE_COLUMN}    30s
    sleep   0.05s
    close Browser
TC_04_VERIFY_PO_ADD/EDIT_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
    wait until element is visible   ${CREATE_NEW_BUTTON}    30s
    sleep   0.5s
    click   ${CLICK_PENDING_FILTER}
    click   ${CLICK_1ST_PO}
    wait until element is visible   ${EDIT_PO}  30s
    sleep   0.05s
    close Browser
TC_05_VERIFY_PO_ADD/EDIT_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
    element should not be visible   ${CREATE_NEW_BUTTON}    30s
    click   ${CLICK_PENDING_FILTER}
    click   ${CLICK_1ST_PO}
    element should not be visible   ${EDIT_PO}  30s
    sleep   0.05s
    close Browser
TC_06_VERIFY_PO_REJECTION_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_REJECT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
#   check in pending filter tab
    click   ${CLICK_PENDING_FILTER}
    Check_Elements_Is_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
#   check in issued filter tab
    click   ${CLICK_ISSUED_FILTER}
    Check_Elements_Is_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
#   check in received filter tab
    click   ${CLICK_RECEIVED_FILTER}
    Check_Elements_Is_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
#   check in reject/withdrawn filter tab
    click   ${CLICK_REJECT/WITHDRAWN_FILTER}
    Safe Element Should Not Be Visible  ${PURCHASE_ORDER_REJECT}    10S
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
#   check in partially received filter tab
    click   ${CLICK_PARTIALLY_RECEIVED_FILTER}
    Check_Elements_Is_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
    close Browser
TC_07_VERIFY_PO_REJECTION_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_REJECT_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.07s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_REJECT}    30s
    click   ${CLICK_PENDING_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
    click   ${CLICK_ISSUED_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
    click   ${CLICK_RECEIVED_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
    click   ${CLICK_REJECT/WITHDRAWN_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
    click   ${CLICK_PARTIALLY_RECEIVED_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_REJECT}    Rejection
    close Browser
TC_08_VERIFY_PO_INWARD_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    Set Selenium Speed    0.05s
    Click Element   ${PURCHASE_ORDER_+_BTN}
    Wait Until Element Is Visible   ${CLICK_PO_INWARD_CHECKBOX}   10s
    Click Element   ${CLICK_PO_INWARD_CHECKBOX}
    Click Element   ${CLICK_SUBMIT}
    Close Browser

    # Employee Access Verification
    TC_02Employee Access    ${ORDERS}
    Set Selenium Speed    0.5s
    Wait Until Element Is Visible   ${PURCHASE_ORDERS}   30s
    Click Element   ${PURCHASE_ORDERS}

    # Check in pending filter tab
    Click Element   ${CLICK_PENDING_FILTER}
    Safe Element Should Be Visible   ${PURCHASE_ORDER_INWARD}   30s
    Log    ✅ Inward is visible in Pending filter

    # Check in issued filter tab
    sleep   0.5s
    Click Element   ${CLICK_ISSUED_FILTER}
    Safe Element Should Be Visible   ${PURCHASE_ORDER_INWARD}   30s
    Log    ✅ Inward is visible in Issued filter

    # Check in partially received filter tab
    sleep   0.5s
    Click Element   ${CLICK_PARTIALLY_RECEIVED_FILTER}
    Safe Element Should Be Visible   ${PURCHASE_ORDER_INWARD}   30s
    Log    ✅ Inward is NOT visible in Partially Received filter

    Close Browser
TC_09_VERIFY_PO_INWARD_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_INWARD_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.5s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
#   check in pending filter tab
    click   ${CLICK_PENDING_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_INWARD}    Inward
#   check in issued filter tab
    click   ${CLICK_ISSUED_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_INWARD}    Inward
#   check in received filter tab
    click   ${CLICK_RECEIVED_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_INWARD}    Inward
#   check in reject/withdrawn filter tab
    click   ${CLICK_REJECT/WITHDRAWN_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_INWARD}    Inward
#   check in partially received filter tab
    click   ${CLICK_PARTIALLY_RECEIVED_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_INWARD}    Inward
    close Browser
TC_10_VERIFY_PO_DOWNLOAD_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_DOWNLOAD_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.2s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
    wait until element is visible   ${PURCHASE_ORDER_DOWNLOAD_BTN}   30s
    click   ${1ST_PURCHASE_ORDER_DETAILS_BTN}
    wait until element is visible   ${PURCHASE_ORDER_PRINTOUT_BTN}   30s
    close Browser
TC_11_VERIFY_PO_DOWNLOAD_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_DOWNLOAD_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.2s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
    element should not be visible   ${PURCHASE_ORDER_DOWNLOAD_BTN}   30s
    click   ${1ST_PURCHASE_ORDER_DETAILS_BTN}
    element should not be visible   ${PURCHASE_ORDER_PRINTOUT_BTN}   30s
    close Browser
TC_12_VERIFY_PO_APPROVE_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_APPROVE_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.3s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
#   check in pending filter tab
    click   ${CLICK_PENDING_FILTER}
    click   ${1ST_PURCHASE_ORDER_DETAILS_BTN}
    Safe Element Should Be Visible  ${PURCHASE_ORDER_INNER_APPROVE_BTN}   30s
    click   ${CLOSE_POPUP}
    Safe Element Should Be Visible  ${PURCHASE_ORDER_APPROVE}   30s
    Check_Elements_Is_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
#   check in issued filter tab
    click   ${CLICK_ISSUED_FILTER}
    Safe Element Should Be Visible  ${PURCHASE_ORDER_APPROVE}   30s
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
#   check in received filter tab
    click   ${CLICK_RECEIVED_FILTER}
    Safe Element Should Be Visible  ${PURCHASE_ORDER_APPROVE}   30s
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
#   check in reject/withdrawn filter tab
    click   ${CLICK_REJECT/WITHDRAWN_FILTER}
    Safe Element Should Be Visible  ${PURCHASE_ORDER_APPROVE}   30s
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
    sleep   1s
#   check in partially received filter tab
    click   ${CLICK_PARTIALLY_RECEIVED_FILTER}
    Safe Element Should Be Visible  ${PURCHASE_ORDER_APPROVE}   30s
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
    close Browser
TC_13_VERIFY_PO_APPROVE_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.05s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_APPROVE_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.2s
    wait until element is visible   ${PURCHASE ORDERS}   30s
    click   ${PURCHASE ORDERS}
#   check in pending filter tab
    click   ${CLICK_PENDING_FILTER}
    click   ${1ST_PURCHASE_ORDER_DETAILS_BTN}
    Safe Element Should Be Visible  ${PURCHASE_ORDER_INNER_APPROVE_BTN1}   30s
    click   ${CLOSE_POPUP}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
#   check in issued filter tab
    click   ${CLICK_ISSUED_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
#   check in received filter tab
    click   ${CLICK_RECEIVED_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
#   check in reject/withdrawn filter tab
    click   ${CLICK_REJECT/WITHDRAWN_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
#   check in partially received filter tab
    click   ${CLICK_PARTIALLY_RECEIVED_FILTER}
    Check_Elements_Is_Not_Visible   ${PURCHASE_ORDER_APPROVE}    Approve
    close Browser
TC_14_VERIFY_PO_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.5s
    click   ${PURCHASE_ORDER_+_BTN}
    sleep   0.5s
    click   ${CLICK_PO_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${ORDERS}
    set selenium speed    0.2s
    reload page
    element should not be visible   ${PURCHASE ORDERS}   30s
    close Browser



































































