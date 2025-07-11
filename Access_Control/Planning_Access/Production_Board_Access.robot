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
TC_01_VERIFY_PRODUCTION_BOARD_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.2s
    click   ${PRODUCTION_BOARD_+_BTN}
    click   ${CLICK_PRODN_BOARD_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access   ${PLANNING_&_SCHEDULING}
    set selenium speed    0.07s
    wait until element is visible   ${PLANNING_&_SCHEDULING}   30s
    mouse over   ${PLANNING_&_SCHEDULING}
    wait until element is visible   ${PRODUCTION_BOARD}   30s
    sleep   0.05s
    close Browser
TC_02_VERIFY_PRODUCTION_BOARD_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.2s
    click   ${PRODUCTION_BOARD_+_BTN}
    click   ${CLICK_PRODN_BOARD_VIEW_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access   ${PLANNING_&_SCHEDULING}
    set selenium speed    0.07s
    wait until element is visible   ${PLANNING_&_SCHEDULING}   30s
    mouse over   ${PLANNING_&_SCHEDULING}
    element should not be visible   ${PRODUCTION_BOARD}   30s
    sleep   0.05s
    close Browser
TC_03_VERIFY_PRODUCTION_BOARD_RECORD_PRODUCTION_ACCESS_ENAABLED
    Owner Login   Ujjwal    ${PLANNING ACCESS TAB}
    set selenium speed    0.5s
    click   ${PRODUCTION_BOARD_+_BTN}
    click   ${CLICK_PRODN_BOARD_VIEW_CHECKBOX}
    click   ${CLICK_PRODN_BOARD_RECORD_PROD_CHECKBOX}
    click   ${PRODUCTION_BOARD_-_BTN}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_04Supervisor Access
    set selenium speed    0.07s
    wait until element is visible   ${PLANNING_&_SCHEDULING}   30s
    mouse over   ${PLANNING_&_SCHEDULING}
    wait until element is visible   ${PRODUCTION_BOARD}   30s
    click   ${PRODUCTION_BOARD}
    sleep   0.5s
    set selenium speed    0.5s
    @{ELEMENTS}=    Get WebElements    ${RECORD_PRODUCTION}
    FOR    ${i}    IN    @{ELEMENTS}
        # Check Close Access
        Wait Until Page Contains Element   ${i}    30s
        Element Should Be Enabled    ${i}
    END
    sleep   0.5s
    close Browser
TC_04_VERIFY_PRODUCTION_BOARD_RECORD_PRODUCTION_ACCESS_DISABLED
    wner Login   Ujjwal    ${PLANNING ACCESS TAB}
    set selenium speed    0.2s
    click   ${PRODUCTION_BOARD_+_BTN}
    click   ${CLICK_PRODN_BOARD_RECORD_PROD_CHECKBOX}
    click   ${PRODUCTION_BOARD_-_BTN}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_04Supervisor Access
    set selenium speed    0.07s
    wait until element is visible   ${PLANNING_&_SCHEDULING}   30s
    mouse over   ${PLANNING_&_SCHEDULING}
    wait until element is visible   ${PRODUCTION_BOARD}   30s
    click   ${PRODUCTION_BOARD}
    set selenium speed    0.5s
    @{ELEMENTS}=    Get WebElements    ${RECORD_PRODUCTION}
    FOR    ${i}    IN    @{ELEMENTS}
        # Check Close Access
        Wait Until Page Contains Element   ${i}    30s
        Element Should not Be Enabled    ${i}
    END
    sleep   0.5s
    close Browser
TC_05_VERIFY_PRODUCTION_BOARD_SET_PRIORITY_ACCESS_ENAABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.2s
    click   ${PRODUCTION_BOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_PRODN_BOARD_VIEW_CHECKBOX}
    click   ${CLICK_PRODN_BOARD_SET_PRIORITY_CHECKBOX}
    click   ${PRODUCTION_BOARD_-_BTN}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${PLANNING_&_SCHEDULING}
    set selenium speed    0.07s
    wait until element is visible   ${PLANNING_&_SCHEDULING}   30s
    mouse over   ${PLANNING_&_SCHEDULING}
    wait until element is visible   ${PRODUCTION_BOARD}   30s
    click   ${PRODUCTION_BOARD}
    sleep   0.5s
    click   ${ALL_SALES_ORDER_BTN}
    set selenium speed    0.5s
    @{ELEMENTS}=    Get WebElements    ${SET_PRIORITY_BTN}
    FOR    ${i}    IN    @{ELEMENTS}
        # Check Close Access
        Wait Until Page Contains Element   ${i}    30s
        Element Should Be Enabled    ${i}
    END
    sleep   0.5s
    close Browser
TC_06_VERIFY_PRODUCTION_BOARD_SET_PRIORITY_ACCESS_DISABLED
    Owner Login   Nitesh    ${PLANNING ACCESS TAB}
    set selenium speed    0.2s
    click   ${PRODUCTION_BOARD_+_BTN}
    click   ${CLICK_PRODN_BOARD_SET_PRIORITY_CHECKBOX}
    sleep   0.5s
    click   ${PRODUCTION_BOARD_-_BTN}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${PLANNING_&_SCHEDULING}
    set selenium speed    0.07s
    wait until element is visible   ${PLANNING_&_SCHEDULING}   30s
    mouse over   ${PLANNING_&_SCHEDULING}
    wait until element is visible   ${PRODUCTION_BOARD}   30s
    click   ${PRODUCTION_BOARD}
    click   ${ALL_SALES_ORDER_BTN}
    set selenium speed    0.5s
    @{ELEMENTS}=    Get WebElements    ${SET_PRIORITY_BTN}
    FOR    ${i}    IN    @{ELEMENTS}
        # Check Close Access
        Wait Until Page Contains Element   ${i}    30s
        Element Should not Be Enabled    ${i}
    END
    sleep   0.5s
    close Browser
TC_07_VERIFY_PRODUCTION_BOARD_START/STOP_ACCESS_ENABLED
    wner Login   Ujjwal    ${PLANNING ACCESS TAB}
    set selenium speed    0.2s
    click   ${PRODUCTION_BOARD_+_BTN}
    click   ${CLICK_PRODN_BOARD_VIEW_CHECKBOX}
    click   ${CLICK_PRODN_BOARD_START/STOP_CHECKBOX}
    click   ${PRODUCTION_BOARD_-_BTN}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_04Supervisor Access
    set selenium speed    0.07s
    wait until element is visible   ${PLANNING_&_SCHEDULING}   30s
    mouse over   ${PLANNING_&_SCHEDULING}
    wait until element is visible   ${PRODUCTION_BOARD}   30s
    click   ${PRODUCTION_BOARD}
    click   ${ALL ORDER}
    set selenium speed    0.5s
    @{ELEMENTS}=    Get WebElements    ${START}
    FOR    ${i}    IN    @{ELEMENTS}
        Wait Until Page Contains Element   ${i}    30s
        Element Should Be Enabled    ${i}
    END
    sleep   0.5s
    click   ${IN PRODUCTION}
    set selenium speed    0.5s
    @{ELEMENTS1}=    Get WebElements    ${STOP}
    FOR    ${i}    IN    @{ELEMENTS1}
        Wait Until Page Contains Element   ${i}    30s
        Element Should Be Enabled    ${i}
    END
    sleep   0.5s
    close Browser
TC_08_VERIFY_PRODUCTION_BOARD_START/STOP_ACCESS_DISABLED
    wner Login   Ujjwal    ${PLANNING ACCESS TAB}
    set selenium speed    0.2s
    click   ${PRODUCTION_BOARD_+_BTN}
    click   ${CLICK_PRODN_BOARD_START/STOP_CHECKBOX}
    click   ${PRODUCTION_BOARD_-_BTN}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_04Supervisor Access
    set selenium speed    0.07s
    wait until element is visible   ${PLANNING_&_SCHEDULING}   30s
    mouse over   ${PLANNING_&_SCHEDULING}
    wait until element is visible   ${PRODUCTION_BOARD}   30s
    click   ${PRODUCTION_BOARD}
    click   ${ALL ORDER}
    set selenium speed    0.5s
    @{ELEMENTS}=    Get WebElements    ${START}
    FOR    ${i}    IN    @{ELEMENTS}
        Wait Until Page Contains Element   ${i}    30s
        element should not be visible    ${i}
    END
    sleep   0.5s
    click   ${IN PRODUCTION}
    set selenium speed    0.5s
    @{ELEMENTS1}=    Get WebElements    ${STOP}
    FOR    ${i}    IN    @{ELEMENTS1}
        Wait Until Page Contains Element   ${i}    30s
        element should not be visible    ${i}
    END
    sleep   0.5s
    close Browser

*** Keywords ***

Test Case With Conditional Logic
    ${full_checked}=    Get WebElement    (//span[@class="ant-tree-checkbox ant-tree-checkbox-checked"])[1]
    ${half_checked}=    Get WebElement    (//span[@class="ant-tree-checkbox ant-tree-checkbox-indeterminate"])[1]
    ${no_checked}=    Get WebElement    (//span[@class="ant-tree-checkbox"])[1]

    Run Keyword If    ${full_checked}    Click Element    ${full_checked}
    ...    ELSE IF    ${half_checked}    Click Element    ${half_checked}
    ...    AND    Click Element    ${full_checked}
    ...    ELSE    Log    No check found


    Run Keyword If