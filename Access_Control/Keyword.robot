*** Settings ***
Library   Browser
Library   String
Library   Collections
Library   DateTime
Resource   .././orders/PurchaseOrder/keyword.robot
Resource   .././orders/PurchaseOrder/variable.robot
Resource   .././././Access_Control/Variable.robot

*** Keywords ***
Open Chrome Browser In Incognito Mode
    New Browser    chromium   headless=True    args=["--incognito"]    # Shows Chrome's incognito UI
    New Page    ${DEVURL}   #${PRODUCTION}
    Set Viewport Size    1521   695
    Wait For Elements State    ${MOBILE OR EMAIL}  visible  timeout=30s
    Fill Text   ${MOBILE OR EMAIL}   nitesh_@gmail.com    #nitesh@gmail.com    #abhijit@gmail.com   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    Fill Text   ${PASSWORD}   9377668854     #9373941111   #8605544332    #${Pass}     #8824427172   #4652049559
    click    ${SIGNIN}
Owner Login
    [Arguments]    ${Name}  ${xpath}
    Login To ManufApp Site
    Wait For Elements State    ${MASTERS1}  visible  timeout=30s
    Hover  ${MASTERS1}
    click   ${EMPLOYEE_&_ACCESS}
    click   ${MASTERS1}
    Search Employee Name    Nitesh
    click   ${xpath}
    click   ${CLICK_EDIT}
TC_02Employee Access
    [Arguments]    ${xpath}
    Open Chrome Browser In Incognito Mode
    Wait For Elements State   ${xpath}    timeout=30s
    Hover   ${xpath}
TC_03Employee Access
    [Arguments]    ${xpath}
    Open Chrome Browser In Incognito Mode
    Wait For Elements State   ${xpath}   timeout=30s
TC_04Supervisor Access
    Wait For Elements State    ${PAGE TEXT CHECK}  visible  timeout=30s
    ${element_text}    browser.Get Text    ${PAGE TEXT CHECK}
    Log    ${element_text}
    input   ${MOBILE OR EMAIL}   ujjwal@manufapp.com   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    input   ${PASSWORD}   9876543211    #${Pass}     #8824427172   #4652049559
    Click    ${SIGNIN}
Check_Elements_Is_Visible
    [Arguments]    ${elements_xpath1}   ${textName}
    @{ELEMENTS}=    Get Elements    ${elements_xpath1}
    FOR    ${i}    IN    @{ELEMENTS}
        # Check Close Access
        Wait For Elements State   ${i}  visible  timeout=30s
        Log    ${textName} Icon is visible
    END
Check_Elements_Is_Not_Visible
    [Arguments]    ${elements_xpath2}   ${textName}
    @{ELEMENTS}=    Get Elements    ${elements_xpath2}
    FOR    ${j}    IN    @{ELEMENTS}
        # Check Close Access
        Wait For Elements State    ${j}  visible  timeout=30s
        Log    ${textName} Icon is not visible
    END
    sleep   0.5s
Retry Element Verification
    [Arguments]  ${locator}  ${visibility}
    # Attempt to interact with the element up to 3 times
    FOR  ${i}  IN RANGE  1  4
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
    Run Keyword If  '${is_checked1}' == 'none'  Click   ${CLICK_SO_CHECKBOX}
    Run Keyword If  '${is_checked2}' == 'none'  Click   ${CLICK_SO_CHECKBOX}
    Log  'Checkbox was unchecked, now it is checked'

    # If the checkbox is already checked, log that it is skipped
    Run Keyword If  '${is_checked}' != 'None'  Log  'Checkbox is already checked, skipping'
Safe Click Element
    [Arguments]  ${locator}
    # Try to click the element, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error  Click  ${locator}
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
        ${result}=  Run Keyword And Ignore Error  Wait For Elements State  ${locator}  visible  timeout=30s
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to locate visible element: ${locator} (Attempt ${i})
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to locate visible element after 3 attempts: ${locator}
Safe Element Should Be Visible
    [Arguments]  ${locator}  ${timeout}=10s
    # Try to check if the element is visible, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error  Wait For Elements State  ${locator}  visible  timeout=30s
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to check visibility of element: ${locator} (Attempt ${i})
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to check visibility of element after 3 attempts: ${locator}
Safe Element Should Not Be Visible
    [Arguments]  ${locator}  ${timeout}=10s
    # Try to check if the element is not visible, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error  Wait For Elements State  ${locator}  visible  timeout=30s
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to check non-visibility of element: ${locator} (Attempt ${i})
        Sleep  1s
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to check non-visibility of element after 3 attempts: ${locator}

Select into Dropdown
    [Arguments]    ${xpath}    ${customer}
    input  ${xpath}  ${customer}
    click   //*[text() = "${customer}"]
Select Date
    [Arguments]    ${xpath}    ${date}
    click   ${xpath}
    click   //*[@class="ant-picker-cell ant-picker-cell-in-view ant-picker-cell-today"]     #//a[contains(text(),'${date}')]
Select Shipement Type
    [Arguments]    ${xpath}    ${shptype}
    input   ${xpath}    ${shptype}
    click   //span[contains(text(),'${shptype}')]
Search Employee Name
    [Arguments]    ${Name}
    click   (//*[@id="undefined_Name_search"])[1]
    input   //input[@placeholder="Search Name"]    ${Name}
    click   (//*[@id="undefined_Name_search"])[2]
    click   //a[text()="${Name}"]