*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    DateTime
Resource   ../../././Access_Control/Keyword.robot
Resource   ../.././orders/PurchaseOrder/keyword.robot
Resource   ../.././orders/PurchaseOrder/variable.robot
Resource   ../.././inventory/Rework_Reuse_Scrap/Keyword1.robot
Resource   ../.././inventory/Rework_Reuse_Scrap/Variable1.robot
*** Variables ***
${my_text}    Sales Orders
@{customername1}    Test01
@{itemData11}    Fgitem1  100  50

*** Test Cases ***
#TC_01_VERIFY_SALES_ORDER_VIEW_ACCESS
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_SO_VIEW_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View access check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    close Browser
#TC_02_VERIFY_ADD/EDIT_ACCESS
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View add/edit check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    click   ${SALES ORDERS}
#    sleep   0.05s
#    #   Verify Add New SO access
#    wait until element is visible   ${CREATE_NEW_SO_BUTTON}   30s
#    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
#    sleep   0.05s
##    reload page
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   2s
#    mouse over   ${CLICK_ON_MORE_BUTTON}
#    wait until element is visible   ${EDIT SO}  30s
#    sleep   0.05s
#    close Browser
#TC_03_VERIFY_BOOK_INVENTORY_ACCESS
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_BOOK_INVENTORY_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View add/edit check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    click   ${SALES ORDERS}
#    sleep   0.05s
#    #   Verify Add New SO access
#    wait until element is clickable   ${CLICK_1ST_SO_NUMBER}   30s
##    reload page
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   2s
#    wait until element is visible    ${BOOK_INVENTORY}   30s
#    sleep   0.05s
#    close Browser
#TC_04_VERIFY_ISSUE_MATERIAL_ACCESS
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_ISSUE_MATERIAL_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View add/edit check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    click   ${SALES ORDERS}
#    sleep   0.05s
#    #   Verify Add New SO access
#    wait until element is clickable   ${CLICK_1ST_SO_NUMBER}   30s
##    reload page
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   2s
#    wait until element is visible    ${ISSUE_MATERIAL}   30s
#    sleep   0.05s
#    close Browser
#TC_05_VERIFY_CREATE_WO_ACCESS
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_CREATE_WO_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View add/edit check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    click   ${SALES ORDERS}
#    sleep   0.05s
#    #   Verify Add New SO access
#    wait until element is clickable   ${CLICK_1ST_SO_NUMBER}   30s
##    reload page
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   2s
#    wait until element is visible    ${CREATE_WO}   30s
#    sleep   0.05s
#    close Browser
#TC_06_VERIFY_CLOSE_SO_ACCESS
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_CLOSE_SO_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View add/edit check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    click   ${SALES ORDERS}
#    sleep   0.05s
##    get list of SO close list icon
#    @{CLOSE_SO_ICON_ELEMENTS}=    Get WebElements    ${CLOSE_SO_ICON}
#    # For each loop
#    FOR    ${element1}    IN    @{CLOSE_SO_ICON_ELEMENTS}
#        # Check Close Access
#        Wait Until Element Is Visible    ${element1}    30s
#        Log    Close SO Icon is visible
#    END
#    sleep   0.5s
#    wait until element is clickable   ${CLICK_1ST_SO_NUMBER}   30s
##    reload page
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   2s
#    mouse over   ${CLICK_ON_MORE_BUTTON}
#    wait until element is visible    ${CLOSE SO}   30s
#    sleep   0.05s
#    close Browser
#TC_07_VERIFY_DELETE_SO_ACCESS
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_DELETE_SO_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View add/edit check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    click   ${SALES ORDERS}
#    sleep   0.05s
##    Get list of DELETE SO list icon
#    @{DELETE_SO_ICON_ELEMENTS}=    Get WebElements    ${DELETE_SO_ICON}
#    # For each loop
#    FOR    ${element2}    IN    @{DELETE_SO_ICON_ELEMENTS}
#        # Check Delete SO Access
#        Wait Until Element Is Visible    ${element2}    30s
#        Log    ${element2} is visible
#    END
#    sleep   0.05s
#    wait until element is clickable   ${CLICK_1ST_SO_NUMBER}   30s
##    reload page
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   2s
#    mouse over   ${CLICK_ON_MORE_BUTTON}
#    wait until element is visible    ${CLOSE SO}   30s
#    sleep   0.05s
#    close Browser
#TC_08_VERIFY_DOWNLOAD_ACCESS
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_DOWNLOAD_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View add/edit check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    click   ${SALES ORDERS}
#    sleep   0.05s
#    #   Verify Add New SO access
#    wait until element is visible   ${DOWNLOAD_CSV_ICON}   30s
#    sleep   0.05s
#    wait until element is clickable   ${CLICK_1ST_SO_NUMBER}   30s
##    reload page
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   2s
#    mouse over   ${CLICK_ON_MORE_BUTTON}
#    wait until element is visible   ${PRINT SO}   30s
#    close Browser
#TC_09_VERIFY_UPLOAD_ACCESS
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_UPLOAD_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View add/edit check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    click   ${SALES ORDERS}
#    sleep   0.05s
#    #   Verify Add New SO access
#    wait until element is visible   ${UPLOAD_CSV_ICON}   30s
#    sleep   0.05s
#    close Browser
#TC_10_VERIFY_ALL_SALES_ORDER_TAB_ACCESS_PERMISSON
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_SO_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##    View access check
#    wait until element is visible   ${SALES ORDERS}   30s
#    click   ${SALES ORDERS}
#    sleep   0.05s
##   Verify Add New SO access
#    wait until element is visible   ${CREATE_NEW_SO_BUTTON}   30s
#    #   Verify Upload access
#    wait until element is visible   ${UPLOAD_CSV_ICON}    30s
#    #   Verify Download access
#    wait until element is visible   ${DOWNLOAD_CSV_ICON}   30s
##    get list of SO close list icon
#    @{CLOSE_SO_ICON_ELEMENTS}=    Get WebElements    ${CLOSE_SO_ICON}
#    # For each loop
#    FOR    ${element1}    IN    @{CLOSE_SO_ICON_ELEMENTS}
#        # Check Close Access
#        Wait Until Element Is Visible    ${element1}    30s
#        Log    ${element1} is visible
#    END
#    sleep   0.5s
#    # Get list of DELETE SO list icon
#    @{DELETE_SO_ICON_ELEMENTS}=    Get WebElements    ${DELETE_SO_ICON}
#    # For each loop
#    FOR    ${element2}    IN    @{DELETE_SO_ICON_ELEMENTS}
#        # Check Delete SO Access
#        Wait Until Element Is Visible    ${element2}    30s
#        Log    ${element2} is visible
#    END
#    wait until element is clickable    ${CLICK_1ST_SO_NUMBER}   30s
##    reload page
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   2s
#    wait until element is visible   ${BOOK_INVENTORY}   30s
#    wait until element is visible   ${ISSUE_MATERIAL}   30s
#    wait until element is visible   ${CREATE_WO}    30s
#    mouse over   ${CLICK_ON_MORE_BUTTON}
#    wait until element is visible   ${EDIT SO}  30s
#    wait until element is visible   ${CLOSE SO}   30s
#    wait until element is visible   ${PRINT SO}   30s
#    sleep   0.5s
#    close browser
#TC_11_VERIFY_ALL_SALES_ORDER_TAB_ACCESS_PERMISSON_DENIED
#    Owner Login
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_SO_CHECKBOX}
##    Not access of SO
#    click   ${CLICK_SUBMIT}
#    sleep   0.5s
#    TC_02Employee Access
#    set selenium speed    0.05s
#    element should not be visible   ${SALES ORDERS}
#    sleep   1s
#TC_12_VERIFY_SALES_ORDER_VIEW_ACCESS_ONLY
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    sleep   0.5s
#    click   ${CLICK_SO_VIEW_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    TC_02Employee Access
#    set selenium speed    0.07s
##   View access check
#    wait until element is visible   ${SALES ORDERS}   30s
#    sleep   0.05s
#    click   ${SALES ORDERS}
#    sleep   0.05s
#    element should not be visible  ${CREATE_NEW_SO_BUTTON}  30s
#    element should not be visible   ${UPLOAD_CSV_ICON}    30s
#    element should not be visible   ${DOWNLOAD_CSV_ICON}   30s
#    #    get list of SO close list icon
#    @{CLOSE_SO_ICON_ELEMENTS}=    Get WebElements    ${CLOSE_SO_ICON}
#    FOR    ${element3}    IN    @{CLOSE_SO_ICON_ELEMENTS}
#        # Check Close Access
#        element should be disabled    ${element3}
#        Log    Close SO Icon is not visible
#    END
#    sleep   0.5s
#    #    get list of DELETE SO list icon
#    @{DELETE_SO_ICON_ELEMENTS}=    Get WebElements    ${DELETE_SO_ICON}
#    # For each loop
#    Sleep    0.5s
#    FOR    ${element4}    IN    @{DELETE_SO_ICON_ELEMENTS}
#        # Check Delete SO Access
#        Sleep    0.05s
#        element should be disabled    ${element4}
#        Log    Delete SO Icon is not visible
#    END
#    sleep   1s
#    wait until element is clickable   ${CLICK_1ST_SO_NUMBER}   30s
#    sleep   0.5s
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   2s
#    element should not be visible   ${BOOK_INVENTORY}
#    element should not be visible   ${ISSUE_MATERIAL}
#    element should not be visible   ${CREATE_WO}
#    sleep   0.5s
#    mouse over   ${CLICK_ON_MORE_BUTTON}
#    element should not be visible   ${EDIT SO}  30s
#    element should not be visible   ${CLOSE SO}  30s
#    element should not be visible   ${PRINT SO}  30s
#    sleep   1s
#    close browser

##----------------------------------------------------------
#    Owner Login
#    click   ${SALES_ORDER_+_BTN}
#    click   ${CLICK_SO_CHECKBOX}
##    click   ${CLICK_SO_VIEW_CHECKBOX}       #1
##    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}    #2
#    click   ${CLICK_SUBMIT}
#    sleep   0.5s
#    close browser
##----------------------------------------------------------
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    click   ${CLICK_SO_CHECKBOX}
#    click   ${CLICK_SO_VIEW_CHECKBOX}
#    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.5s
#    close browser
##----------------------------------------------------------
#    TC_02Employee Access
#    set selenium speed    0.05s
#    element should be visible   ${SALES ORDERS}
#    click   ${SALES ORDERS}
##    check access of create new so button should not be accessible
#    sleep   0.5s
#    element should be visible  ${CREATE_NEW_SO_BUTTON}  30s
#    sleep   1s
#    wait until element is clickable   ${CLICK_1ST_SO_NUMBER}   30s
#    sleep   0.5s
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   1s
#    mouse over   ${CLICK_ON_MORE_BUTTON}
#    wait until element is visible   ${EDIT SO}  30s
#    sleep   1s
#    click   ${EDIT SO}
#    sleep   1s
#    wait until page contains element    ${SO_ISSUE_DATE}    30s
#    ${issue_date1}=  get text    ${SO_ISSUE_DATE}
#    ${delevery_date1}=  get text    ${SO_DELEVERY_DATE}
#    sleep   0.5s
#    ${qty1}=  get text    ${SO_ITEM_CODE_QTY}
#    log   ✅ Issue date = ${issue_date1}, Delevery date = ${delevery_date1}, SO qty = ${qty1}
#    click   ${CLICK_EDIT_BTN}
#    sleep   2s
#    wait until page contains element    ${SO_PAge_ELEMENT}  30s
#    select Issue Date
#    sleep   0.5s
#    ${randomrefqty}=     generate random number_2_digit
#    click   ${INPUT_SO_QTY}
#    Press Keys    ${INPUT_SO_QTY}    CTRL+a    BACKSPACE    ${randomrefqty}
#    click   ${SUBMIT_AFTER_EDIT}
#    sleep   0.5s
#    click   ${BACK_TO_SO_DETAILS_PAGE}
#    sleep   0.5s
#    close browser
##----------------------------------------------------------
#    Owner Login
#    click   ${SALES_ORDER_+_BTN}
#    click   ${CLICK_SO_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.5s
#    close browser
##----------------------------------------------------------
#    Owner Login
#    set selenium speed    0.05s
#    click   ${SALES_ORDER_+_BTN}
#    click   ${CLICK_SO_CHECKBOX}
#    click   ${CLICK_SO_VIEW_CHECKBOX}
#    click   ${CLICK_BOOK_INVENTORY_CHECKBOX}
#    click   ${CLICK_ISSUE_MATERIAL_CHECKBOX}
#    click   ${CLICK_CREATE_WO_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.5s
#    close browser
##----------------------------------------------------------
#    TC_02Employee Access
#    set selenium speed    0.05s
#    element should be visible   ${SALES ORDERS}
#    click   ${SALES ORDERS}
#    sleep   1s
#    wait until element is clickable   ${CLICK_1ST_SO_NUMBER}   30s
#    sleep   0.5s
#    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   1s
#    element should be visible   ${BOOK_INVENTORY}
#    element should be visible   ${ISSUE_MATERIAL}
#    element should be visible   ${CREATE_WO}
#    sleep   0.5s
#    close browser
##----------------------------------------------------------
#    Owner Login
#    click   ${SALES_ORDER_+_BTN}
#    click   ${CLICK_SO_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.5s
#    close browser
##----------------------------------------------------------


#TC_01_VERIFY_ALL_CUSTOMER/VENDOR_VIEW_ACCESS
#    Owner Login
#    Set Selenium Speed    0.05s
#    Click Element   ${CUSTOMER/VENDOR_+_BTN}
#    Wait Until Element Is Visible  ${CLICK_VIEW_ALL_CUSTOMER/VENDOR_CHECKBOX}
#    Click Element   ${CLICK_VIEW_ALL_CUSTOMER/VENDOR_CHECKBOX}
#    Click Element   ${CLICK_SUBMIT}
#
#    # Employee Access
#    Set Selenium Speed    0.07s
#    Mouse Over   ${MASTERS1}
#    Click Element   ${CUSTOMERS}
#    click   ${MASTERS1}
#    Wait Until Page Contains Element   ${ALL_CUSTOMERS_LIST}   10s
#    @{Customer_list}=   Get WebElements   ${ALL_CUSTOMERS_LIST}
#
#    # For each loop for customers
#    FOR    ${element1}    IN    @{Customer_list}
#        Wait Until Element Is Visible    ${element1}    30s
#        Log    All Customers are visible
#    END
#
#    ${count}=   Get Element Count   ${ALL_CUSTOMERS_LIST}
#    Log   ✅ Total Customers Count: ${count}
#
#    # Vendors List
#    Click Element   ${JOBWORK_CUSTOMER}
#    Wait Until Page Contains Element   ${ALL_VENDORS_LIST}   10s
#    @{Vendor_list}=   Get WebElements   ${ALL_VENDORS_LIST}
#
#    # For each loop for vendors
#    FOR    ${element2}    IN    @{Vendor_list}
#        Wait Until Element Is Visible    ${element2}    30s
#        Log    All Vendors are visible
#    END
#
#    ${count}=   Get Element Count   ${ALL_VENDORS_LIST}
#    Log   ✅ Total Vendors Count: ${count}
#
#    Close Browser
#
#TC_02_VERIFY_EMP_LEVEL_CUSTOMER/VENDOR_VIEW_ACCESS
#    Owner Login
#    Set Selenium Speed    0.05s
#    Click Element   ${CUSTOMER/VENDOR_+_BTN}
#    Wait Until Element Is Visible  ${CLICK_VIEW_ALL_CUSTOMER/VENDOR_CHECKBOX}
#    Click Element   ${CLICK_VIEW_ALL_CUSTOMER/VENDOR_CHECKBOX}
#    Click Element   ${CLICK_SUBMIT}
#
#    # Employee Access
#    Set Selenium Speed    0.07s
#    Mouse Over   ${MASTERS1}
#    Click Element   ${CUSTOMERS}
#    click   ${MASTERS1}
#    Wait Until Page Contains Element   ${EMP_LEVEL_CUSTOMER_LIST}   10s
#    @{Customer_list}=   Get WebElements   ${EMP_LEVEL_CUSTOMER_LIST}
#
#    # For each loop for employee level customers
#    FOR    ${element1}    IN    @{Customer_list}
#        Wait Until Element Is Visible    ${element1}    30s
#        Log    Created by employee Customers are visible only
#    END
#
#    ${count}=   Get Element Count   ${EMP_LEVEL_CUSTOMER_LIST}
#    Log   ✅ Total Customer Count: ${count}
#
#    # Vendors List
#    Click Element   ${JOBWORK_CUSTOMER}
#    Wait Until Page Contains Element   ${ALL_VENDORS_LIST}   10s
#    @{Vendor_list}=   Get WebElements   ${ALL_VENDORS_LIST}
#
#    # For each loop for vendors
#    FOR    ${element2}    IN    @{Vendor_list}
#        Wait Until Element Is Visible    ${element2}    30s
#        Log    All Vendors are visible
#    END
#
#    Close Browser
#
#TC_03_VERIFY_MASK_CUSTOMER/VENDOR_CODE
#    Owner Login
#    Set Selenium Speed    0.05s
#    Click Element   ${CUSTOMER/VENDOR_+_BTN}
#    Wait Until Element Is Visible  ${CLICK_MASK_CUSTOMER_NAME_CHECKBOX}
#    Click Element   ${CLICK_MASK_CUSTOMER_NAME_CHECKBOX}
#    Click Element   ${CLICK_SUBMIT}
#
#    # Employee Access
#    Set Selenium Speed    0.07s
#    Mouse Over   ${MASTERS1}
#    Click Element   ${CUSTOMERS}
#    click   ${MASTERS1}
#    Wait Until Page Contains Element   ${MASK_CUSTOMER_CODE}   10s
#    @{Mask_Cust_list}=   Get WebElements   ${MASK_CUSTOMER_CODE}
#
#    # For each loop for masked customers
#    FOR    ${element2}    IN    @{Mask_Cust_list}
#        Wait Until Element Is Visible    ${element2}    30s
#        Log    Customer code is visible
#    END
#
#    Close Browser
#
#TC_04_VERIFY_UNMASK_CUSTOMER/VENDOR_CODE
#    Owner Login
#    Set Selenium Speed    0.05s
#    Click Element   ${CUSTOMER/VENDOR_+_BTN}
#    Wait Until Element Is Visible  ${CLICK_MASK_CUSTOMER_NAME_CHECKBOX}
#    Click Element   ${CLICK_MASK_CUSTOMER_NAME_CHECKBOX}
#    Click Element   ${CLICK_SUBMIT}
#
#    # Employee Access
#    Set Selenium Speed    0.07s
#    Mouse Over   ${MASTERS1}
#    Click Element   ${CUSTOMERS}
#    click   ${MASTERS1}
#    Wait Until Page Contains Element   ${UNMASK_CUSTOMER_CODE}   10s
#    Wait Until Element Is Visible   ${UNMASK_CUSTOMER_CODE}
#
#    Close Browser
#
#    @{Vendor_list}=    Get WebElements    ${ALL_VENDORS_LIST}
#    # For each loop
#    FOR    ${element2}    IN    @{Vendor_list}
#        # Check Close Access
#        Wait Until Element Is Visible    ${element2}    30s
#        Log    All Vendors is visible
#    END
#    @{count2}=   Get Element Count   ${ALL_VENDORS_LIST}
#    Log   ✅ Total Vendors Count: ${count}
#
#
#    sleep   0.5s
#    click   ${JOBWORK_CUSTOMER}
#    sleep   0.5s
#    @{Vendor_list}=    Get WebElements    ${ALL_VENDORS_LIST}
#    # For each loop
#    FOR    ${element2}    IN    @{Vendor_list}
#        sleep   0.5s
#        Wait Until Element Is Visible    ${element2}    30s
#        Log    All Vendors is visible
#    END

*** Test Cases ***
TC_08_VERIFY_PO_INWARD_ACCESS_ENABLED
#    Owner Login
#    Set Selenium Speed    0.05s
#    Safe Click Element   ${PURCHASE_ORDER_+_BTN}
#
#    Safe Wait Until Element Is Visible   ${CLICK_PO_INWARD_CHECKBOX}   10s
#    Safe Click Element   ${CLICK_PO_INWARD_CHECKBOX}
#
#    Safe Wait Until Element Is Visible   ${CLICK_SUBMIT}   10s
#    Safe Click Element   ${CLICK_SUBMIT}
#
#    Close Browser

    TC_02Employee Access
    Set Selenium Speed    0.3s

    Safe Wait Until Element Is Visible   ${PURCHASE_ORDERS}   30s
    Safe Click Element   ${PURCHASE_ORDERS}

    # Check in pending filter tab
    Safe Click Element   ${CLICK_PENDING_FILTER}
    Safe Element Should Be Visible   ${PURCHASE_ORDER_INWARD}   10s
    Log    ✅ Inward is visible in Pending filter

    # Check in issued filter tab
    Safe Click Element   ${CLICK_ISSUED_FILTER}
    Safe Element Should Be Visible   ${PURCHASE_ORDER_INWARD}   10s
    Log    ✅ Inward is visible in Issued filter

    # Check in received filter tab
    Safe Click Element   ${CLICK_RECEIVED_FILTER}
    Safe Element Should Be Visible   ${PURCHASE_ORDER_INWARD}   10s
    Log    ❌ Inward is NOT visible in Received filter

    # Check in reject/withdrawn filter tab
    Safe Click Element   ${CLICK_REJECT/WITHDRAWN_FILTER}
    Safe Element Should Be Visible   ${PURCHASE_ORDER_INWARD}   10s
    Log    ❌ Inward is NOT visible in Reject/Withdrawn filter

    # Check in partially received filter tab
    Safe Click Element   ${CLICK_PARTIALLY_RECEIVED_FILTER}
    Safe Element Should Be Visible   ${PURCHASE_ORDER_INWARD}   10s
    Log    ❌ Inward is NOT visible in Partially Received filter

    Close Browser

*** Keywords ***
Open Chrome Browser In Incognito Mode
    Set Selenium Speed  1s
    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()
    Call Method  ${options}  add_argument  incognito
    Create WebDriver  Chrome  options=${options}
    Go To  ${URL}
    reload page
    maximize browser window
    sleep   1s
    wait until page contains element    ${MOBILE OR EMAIL}  30s
    wait until element is visible   ${MOBILE OR EMAIL}  30s
    Input Text   ${MOBILE OR EMAIL}   nitesh_@gmail.com     #abhijit@gmail.com   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    Input Text   ${PASSWORD}   9377668854   #8605544332    #${Pass}     #8824427172   #4652049559
    click button    ${SIGNIN}
    wait until page contains  OEE Dashboard  30
    sleep    0.05s
Owner Login
    Set Selenium Speed  0.05s
    Open Browser Site
    reload page
    login to manufapp site
    Set Selenium Speed  0.5s
    mouse over  ${MASTERS1}
    click   ${EMPLOYEE_&_ACCESS}
    click   ${MASTERS1}
    wait until element is visible   ${CLICK_SEARCH_ICON}    30s
    click   ${CLICK_SEARCH_ICON}
    input   ${SEARCH_EMPLOYEE_NAME}   Nitesh
    click   ${CLICK_NITESH}
    click   ${PLANNING ACCESS TAB}
    click   ${CLICK_EDIT}
    sleep   1s
TC_02Employee Access
    Open Chrome Browser In Incognito Mode
    sleep   1s
    mouse over   ${ORDERS}
Check_Elements_Is_Visible
    [Arguments]    ${elements_xpath1}   ${textName}
    set selenium speed    0.5s
    @{ELEMENTS}=    Get WebElements    ${elements_xpath1}
    FOR    ${i}    IN    @{ELEMENTS}
        # Check Close Access
        Wait Until Page Contains Element   ${i}    30s
        Element Should Be Enabled    ${i}
        Log    ${textName} Icon is visible
    END
    sleep   0.5s
Check_Elements_Is_Not_Visible
    [Arguments]    ${elements_xpath2}   ${textName}
    set selenium speed    0.5s
    @{ELEMENTS}=    Get WebElements    ${elements_xpath2}
    FOR    ${j}    IN    @{ELEMENTS}
        # Check Close Access
        Element Should Be Disabled    ${j}
        Log    ${textName} Icon is not visible
    END
    sleep   0.5s
Retry Element Verification
    [Arguments]  ${locator}  ${visibility}
    # Attempt to interact with the element up to 3 times
    :FOR  ${i}  IN RANGE  1  4
        ${status}=  Run Keyword And Ignore Error  Element Should Be ${visibility}  ${locator}
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Retry locating element: ${locator} (Attempt ${i})
        Sleep  1s
    END
Check Outer Checkbox If Unchecked
    # Check if the checkbox is checked or not
    ${is_checked1}=  Get Element Attribute  ${CLICK_SO_CHECKBOX}  ant-tree-checkbox ant-tree-checkbox-checked
    ${is_checked2}=  Get Element Attribute  ${CLICK_SO_CHECKBOX}  ant-tree-checkbox-inner
    ${is_unchecked}=  Get Element Attribute  ${CLICK_SO_CHECKBOX}  ant-tree-checkbox-inner

    # If the checkbox is unchecked (i.e., ${is_checked} is None), then check it
    Run Keyword If  '${is_checked1}' == 'none'  Click Element   ${CLICK_SO_CHECKBOX}
    Run Keyword If  '${is_checked2}' == 'none'  Click Element   ${CLICK_SO_CHECKBOX}
    Log  'Checkbox was unchecked, now it is checked'

    # If the checkbox is already checked, log that it is skipped
    Run Keyword If  '${is_checked}' != 'None'  Log  'Checkbox is already checked, skipping'
Safe Click Element
    [Arguments]  ${locator}
    # Try to click the element, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error  Click Element  ${locator}
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to click element: ${locator} (Attempt ${i})
        Sleep  1s
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to click element after 3 attempts: ${locator}
Safe Wait Until Element Is Visible
    [Arguments]  ${locator}  ${timeout}=10s
    # Try to wait until the element is visible, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error  Wait Until Element Is Visible  ${locator}  ${timeout}
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to locate visible element: ${locator} (Attempt ${i})
        Sleep  1s
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to locate visible element after 3 attempts: ${locator}
Safe Element Should Be Visible
    [Arguments]  ${locator}  ${timeout}=10s
    # Try to check if the element is visible, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error  Element Should Be Visible  ${locator}  ${timeout}
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to check visibility of element: ${locator} (Attempt ${i})
        Sleep  1s
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to check visibility of element after 3 attempts: ${locator}
Safe Element Should Not Be Visible
    [Arguments]  ${locator}  ${timeout}=10s
    # Try to check if the element is not visible, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error  Element Should Not Be Visible  ${locator}  ${timeout}
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to check non-visibility of element: ${locator} (Attempt ${i})
        Sleep  1s
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to check non-visibility of element after 3 attempts: ${locator}



Test Case With Conditional Logic
    ${full_checked}=    Set Variable    (//span[@class="ant-tree-checkbox ant-tree-checkbox-checked"])[1]
    ${half_checked}=    Set Variable    (//span[@class="ant-tree-checkbox ant-tree-checkbox-indeterminate"])[1]
    ${no_checked}=    Set Variable    (//span[@class="ant-tree-checkbox"])[1]
    Run Keyword If    Webelement == ${full_checked}    click   ${full_checked}

    ...    ELSE IF    Webelement == ${half_checked}    click   ${half_checked}     click    ${full_checked}
    ...    ELSE    log    no check