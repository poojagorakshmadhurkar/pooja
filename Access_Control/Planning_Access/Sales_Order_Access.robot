*** Settings ***
Library    Browser
Library    String
Library    Collections
Library    DateTime
#Library    SeleniumLibrary
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
#Open Chrome in Incognito and Headless Mode
#  ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
#    Call Method    ${options}    add_argument    --headless
#    Call Method    ${options}    add_argument    --incognito
#    Call Method    ${options}    add_argument    --disable-gpu
#    Create WebDriver    Chrome    options=${options}
#    Go To    https://www.google.com
#    [Teardown]    Browser.Close Browser


TC_01_VERIFY_SALES_ORDER_VIEW_ACCESS
#    Set Selenium Speed  0.5s
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep   3s
#    Wait For Load State   networkidle   timeout=60 seconds
#    Wait For Elements State    ${CLICK_SO_VIEW_CHECKBOX}    visible   timeout=60s
    click   ${CLICK_SO_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}
#   View access check
    Wait For Elements State  ${SALES ORDERS}   visible   timeout=60s
#    sleep   0.05s
    Browser.Close Browser
TC_02_VERIFY_ADD/EDIT_ACCESS
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep   3s
#    Wait For Load State   networkidle   timeout=60 seconds
#    Wait For Elements State  ${CLICK_SO_ADD/EDIT_CHECKBOX}   visible   timeout=60s
    click   ${CLICK_SO_ADD/EDIT_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}

#   View add/edit check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    sleep   0.05s
    click   ${SALES ORDERS}
    sleep   0.05s
    #   Verify Add New SO access
    Wait For Elements State   ${CREATE_NEW_SO_BUTTON}   visible   timeout=60s
    Wait For Elements State    ${CLICK_1ST_SO_NUMBER}   visible   timeout=60s
#    reload page
    click   ${CLICK_1ST_SO_NUMBER}
    sleep   3s
    Wait For Elements State   ${CLICK_ON_MORE_BUTTON}    visible   timeout=60s
    Hover   ${CLICK_ON_MORE_BUTTON}
    Wait For Elements State   ${EDIT SO}  visible   timeout=60s
    Browser.Close Browser
TC_03_VERIFY_BOOK_INVENTORY_ACCESS
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep   3s
#    Wait For Load State   networkidle   timeout=60 seconds
#    Wait For Elements State    ${CLICK_BOOK_INVENTORY_CHECKBOX}   visible   timeout=60s
    click   ${CLICK_BOOK_INVENTORY_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.5s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}
#   View add/edit check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    sleep   0.05s
    click   ${SALES ORDERS}
#    sleep   0.05s
    #   Verify Add New SO access
    Wait For Elements State   ${CLICK_1ST_SO_NUMBER}   visible   timeout=60s
#    reload page
    click   ${CLICK_1ST_SO_NUMBER}
    sleep   3s
    Wait For Elements State    ${BOOK_INVENTORY}   visible   timeout=60s
#    sleep   0.05s
    Browser.Close Browser
TC_04_VERIFY_ISSUE_MATERIAL_ACCESS
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep   3s
#    Wait For Load State   networkidle   timeout=60 seconds
#    Wait For Elements State    ${CLICK_ISSUE_MATERIAL_CHECKBOX}   visible   timeout=60s
    click   ${CLICK_ISSUE_MATERIAL_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}

#   View add/edit check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    sleep   0.05s
    click   ${SALES ORDERS}
#    sleep   0.05s
    #   Verify Add New SO access
    Wait For Elements State   ${CLICK_1ST_SO_NUMBER}   visible   timeout=60s
#    reload page
    click   ${CLICK_1ST_SO_NUMBER}
    sleep   3s
    Wait For Elements State    ${ISSUE_MATERIAL}   visible   timeout=60s
#    sleep   0.05s
    Browser.Close Browser
TC_05_VERIFY_CREATE_WO_ACCESS
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep    3s
#    Wait For Load State   networkidle   timeout=60 seconds
#    Wait For Elements State    ${CLICK_CREATE_WO_CHECKBOX}  visible   timeout=60s
    click   ${CLICK_CREATE_WO_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}
#   View add/edit check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    sleep   0.05s
    click   ${SALES ORDERS}
#    sleep   0.05s
    #   Verify Add New SO access
    Wait For Elements State   ${CLICK_1ST_SO_NUMBER}   visible   timeout=60s
#    reload page
    click   ${CLICK_1ST_SO_NUMBER}
    sleep   3s
    Wait For Elements State    ${CREATE_WO}   visible   timeout=60s
#    sleep   0.05s
    Browser.Close Browser
TC_06_VERIFY_CLOSE_SO_ACCESS
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep    3s
#    Wait For Load State   networkidle   timeout=60 seconds
#    Wait For Elements State    ${CLICK_CLOSE_SO_CHECKBOX}   visible   timeout=60s
    click   ${CLICK_CLOSE_SO_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}

#   View add/edit check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    sleep   0.05s
    click   ${SALES ORDERS}
#    sleep   0.05s
#    get list of SO close list icon
    @{CLOSE_SO_ICON_ELEMENTS}=    Get Elements    ${CLOSE_SO_ICON}
    # For each loop
    FOR    ${element1}    IN    @{CLOSE_SO_ICON_ELEMENTS}
        # Check Close Access
        Wait For Elements State    ${element1}    visible   timeout=60s
        Log    Close SO Icon is visible
    END
    sleep   0.5s
    Wait For Elements State   ${CLICK_1ST_SO_NUMBER}   visible   timeout=60s
#    reload page
    click   ${CLICK_1ST_SO_NUMBER}
    sleep   3s
    Wait For Elements State   ${CLICK_ON_MORE_BUTTON}     visible   timeout=60s
    Hover   ${CLICK_ON_MORE_BUTTON}
    Wait For Elements State    ${CLOSE SO}   visible   timeout=60s
    sleep   0.05s
    Browser.Close Browser
TC_07_VERIFY_DELETE_SO_ACCESS
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep    3s
#    Wait For Load State   networkidle   timeout=60 seconds
#    Wait For Elements State    ${CLICK_DELETE_SO_CHECKBOX}  visible   timeout=60s
    click   ${CLICK_DELETE_SO_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}

#   View add/edit check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    sleep   0.05s
    click   ${SALES ORDERS}
#    sleep   0.05s
#    Get list of DELETE SO list icon
    @{DELETE_SO_ICON_ELEMENTS}=    Get Elements    ${DELETE_SO_ICON}
    # For each loop
    FOR    ${element2}    IN    @{DELETE_SO_ICON_ELEMENTS}
        # Check Delete SO Access
        Wait For Elements State    ${element2}    visible   timeout=60s
        Log    ${element2} is visible
    END
    sleep   0.05s
    Wait For Elements State   ${CLICK_1ST_SO_NUMBER}   visible   timeout=60s
#    reload page
    click   ${CLICK_1ST_SO_NUMBER}
    sleep   3s
    Wait For Elements State   ${CLICK_ON_MORE_BUTTON}     visible   timeout=60s
    Hover   ${CLICK_ON_MORE_BUTTON}
    Wait For Elements State    ${CLOSE SO}   visible   timeout=60s
    sleep   0.05s
    Browser.Close Browser
TC_08_VERIFY_DOWNLOAD_ACCESS
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep    3s
#    Wait For Load State   networkidle   timeout=10 seconds
#    Wait For Elements State    ${CLICK_DOWNLOAD_CHECKBOX}   visible   timeout=60s
    click   ${CLICK_DOWNLOAD_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}

#   View add/edit check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    sleep   0.05s
    click   ${SALES ORDERS}
#    sleep   0.05s
    #   Verify Add New SO access
    Wait For Elements State   ${DOWNLOAD_CSV_ICON}   visible   timeout=60s
#    sleep   0.05s
    Wait For Elements State   ${CLICK_1ST_SO_NUMBER}   visible   timeout=60s
#    reload page
    click   ${CLICK_1ST_SO_NUMBER}
#    sleep   3s
    Wait For Elements State   ${CLICK_ON_MORE_BUTTON}    visible   timeout=60s
    Hover   ${CLICK_ON_MORE_BUTTON}
    Wait For Elements State   ${PRINT SO}   visible   timeout=60s
    Browser.Close Browser
TC_09_VERIFY_UPLOAD_ACCESS
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep    3s
#    Wait For Load State   networkidle   timeout=10 seconds
#    Wait For Elements State    ${CLICK_UPLOAD_CHECKBOX}   visible   timeout=60s
    click   ${CLICK_UPLOAD_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}

#   View add/edit check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    sleep   0.05s
    click   ${SALES ORDERS}
#    sleep   0.05s
    #   Verify Add New SO access
    Wait For Elements State   ${UPLOAD_CSV_ICON}   visible   timeout=60s
#    sleep   0.05s
    Browser.Close Browser
TC_10_VERIFY_ALL_SALES_ORDER_TAB_ACCESS_PERMISSON
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep    3s
#    Wait For Load State   networkidle   timeout=10 seconds
#    Wait For Elements State    ${CLICK_SO_CHECKBOX}   visible   timeout=60s
    click   ${CLICK_SO_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}

#    View access check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
    click   ${SALES ORDERS}
#    sleep   0.05s
#   Verify Add New SO access
    Wait For Elements State   ${CREATE_NEW_SO_BUTTON}   visible   timeout=60s
    #   Verify Upload access
    Wait For Elements State   ${UPLOAD_CSV_ICON}    visible   timeout=60s
    #   Verify Download access
    Wait For Elements State   ${DOWNLOAD_CSV_ICON}   visible   timeout=60s
#    get list of SO close list icon
    @{CLOSE_SO_ICON_ELEMENTS}=    Get Elements    ${CLOSE_SO_ICON}
    # For each loop
    FOR    ${element1}    IN    @{CLOSE_SO_ICON_ELEMENTS}
        # Check Close Access
        Wait For Elements State    ${element1}    visible   timeout=60s
        Log    ${element1} is visible
    END
#    sleep   0.5s
    # Get list of DELETE SO list icon
    @{DELETE_SO_ICON_ELEMENTS}=    Get Elements    ${DELETE_SO_ICON}
    # For each loop
    FOR    ${element2}    IN    @{DELETE_SO_ICON_ELEMENTS}
        # Check Delete SO Access
        Wait For Elements State    ${element2}    visible   timeout=60s
        Log    ${element2} is visible
    END
    Wait For Elements State    ${CLICK_1ST_SO_NUMBER}   visible   timeout=60s
#    reload page
    click   ${CLICK_1ST_SO_NUMBER}
    sleep   3s
    Wait For Elements State   ${BOOK_INVENTORY}   visible   timeout=60s
    Wait For Elements State   ${ISSUE_MATERIAL}   visible   timeout=60s
    Wait For Elements State   ${CREATE_WO}    visible   timeout=60s
    Hover   ${CLICK_ON_MORE_BUTTON}
    Wait For Elements State   ${EDIT SO}  visible   timeout=60s
    Wait For Elements State   ${CLOSE SO}   visible   timeout=60s
    Wait For Elements State   ${PRINT SO}   visible   timeout=60s
#    sleep   0.5s
    Browser.Close Browser
TC_11_VERIFY_ALL_SALES_ORDER_TAB_ACCESS_PERMISSON_DENIED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
#    Sleep    2s
    Wait For Elements State    ${CLICK_SO_CHECKBOX}   visible   timeout=30s
#    click   ${CLICK_SO_VIEW_CHECKBOX}
#    sleep   0.5s
    Click   ${CLICK_SO_CHECKBOX21}
#    Not access of SO
    click   ${CLICK_SUBMIT}
#    sleep   0.5s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}
    Wait For Elements State   ${SALES ORDERS}   hidden   timeout=30s
    sleep   1s
TC_12_VERIFY_SALES_ORDER_VIEW_ACCESS_ONLY
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    click   ${SALES_ORDER_+_BTN}
    Sleep    3s
#    Wait For Load State   networkidle   timeout=10 seconds
#    Wait For Elements State    ${CLICK_SO_VIEW_CHECKBOX}    visible   timeout=60s
    click   ${CLICK_SO_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
#    sleep   0.05s
    Browser.Close Browser
    TC_02Employee Access    ${ORDERS}

#   View access check
    Wait For Elements State   ${SALES ORDERS}   visible   timeout=30s
#    sleep   0.05s
    click   ${SALES ORDERS}
    Click    //img[@alt='Manufapp']
#    sleep   0.05s
    Wait For Elements State  ${CREATE_NEW_SO_BUTTON}  hidden   timeout=30s
    Wait For Elements State   ${UPLOAD_CSV_ICON}    hidden   timeout=30s
    Wait For Elements State   ${DOWNLOAD_CSV_ICON}   hidden   timeout=30s
    #    get list of SO close list icon
    @{CLOSE_SO_ICON_ELEMENTS}=    Get Elements    ${CLOSE SO ICON}
    sleep   1s
    FOR    ${element3}    IN    @{CLOSE_SO_ICON_ELEMENTS}
        # Check Close Access
        Wait For Elements State    ${element3}  hidden   timeout=30s
        Log    Close SO Icon is not visible
    END
    sleep   0.5s
    #    get list of DELETE SO list icon
    @{DELETE_SO_ICON_ELEMENTS}=    Get Elements    ${DELETE SO ICON}
    # For each loop
    Sleep    0.5s
    FOR    ${element4}    IN    @{DELETE_SO_ICON_ELEMENTS}
        # Check Delete SO Access
        Sleep    0.05s
        Wait For Elements State    ${element4}  hidden   timeout=30s
        Log    Delete SO Icon is not visible
    END
    sleep   1s
    Wait For Elements State   ${CLICK_1ST_SO_NUMBER}   visible   timeout=60s
    sleep   0.5s
    click   ${CLICK_1ST_SO_NUMBER}
    sleep   3s
    Wait For Elements State   ${BOOK_INVENTORY}   hidden    timeout=60s
    Wait For Elements State   ${ISSUE_MATERIAL}   hidden    timeout=60s
    Wait For Elements State   ${CREATE_WO}    hidden    timeout=60s
    sleep   0.5s
    Wait For Elements State   ${CLICK_ON_MORE_BUTTON}     visible   timeout=60s
    Hover   ${CLICK_ON_MORE_BUTTON}
    Wait For Elements State   ${EDIT SO}  hidden    timeout=60s
    Wait For Elements State   ${CLOSE SO}  hidden   timeout=60s
    Wait For Elements State   ${PRINT SO}  hidden   timeout=60s
    sleep   1s
    Browser.Close Browser
#TC_13_VERIFY_SALES_ORDER_VIEW_ALL_SO_ACCESS
#    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
#    click   ${SALES_ORDER_+_BTN}
#    Sleep    3s
##    Wait For Load State   networkidle   timeout=10 seconds
##    Wait For Elements State    ${CLICK_SO_VIEW_ALL_SO_CHECKBOX}   visible   timeout=60s
##    click   ${CLICK_SO_VIEW_CHECKBOX}
#    click   ${CLICK_SO_VIEW_ALL_SO_CHECKBOX}
#    click   ${CLICK_SUBMIT}
##    sleep   0.05s
#    Browser.Close Browser
#    TC_02Employee Access    ${ORDERS}
#
##   View access check
#    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    @{ALL_CUSTOMER_SO}=   Get Elements    ${ALL_CUSTOMER_SO}
#    FOR    ${elementt}    IN    @{ALL_CUSTOMER_SO}
#        # Check Close Access
#        Wait For Elements State    ${elementt}  hidden   timeout=30s
#        Log    All SO is visible which is created by all customers
#    END
##    sleep   0.5s
##    sleep   0.05s
#    Browser.Close Browser
#TC_14_VERIFY_SALES_ORDER_VIEW_EMP_LEVEL_SO_ACCESS
#    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
#    click   ${SALES_ORDER_+_BTN}
#    Sleep    3s
##    Wait For Load State   networkidle   timeout=10 seconds
##    Wait For Elements State    ${CLICK_SO_VIEW_ALL_SO_CHECKBOX}   visible   timeout=60s
#    click   ${CLICK_SO_VIEW_ALL_SO_CHECKBOX}
#    click   ${CLICK_SUBMIT}
##    sleep   0.05s
#    Browser.Close Browser
#    TC_02Employee Access    ${ORDERS}
#
##   View access check
#    Wait For Elements State   ${SALES ORDERS}   visible   timeout=60s
#    @{ALL_CUSTOMER_SO}=   Get Elements    ${ALL_CUSTOMER_CREATED_BY_EMP_SO}
#    FOR    ${elementt}    IN    @{ALL_CUSTOMER_SO}
#        # Check Close Access
#        Wait For Elements State    ${elementt}  hidden   timeout=30s
#        Log    All SO is visible which is created by all customers
#    END
##    sleep   0.5s
#    Browser.Close Browser

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


