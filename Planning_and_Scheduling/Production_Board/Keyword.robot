*** Settings ***
Library     SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Library     BuiltIn
Resource    ../../keywords.robot
Resource    ../../variables.robot
Resource    ../../././orders/PurchaseOrder/keyword.robot
Resource    ../../././orders/PurchaseOrder/variable.robot
Resource    ../../././orders/Salesorder/keywords.robot
Resource    ../../././orders/Salesorder/variables.robot
Resource   ../WorkordersFlow/keyword.robot
*** Keywords ***
Open Chrome Browser In Incognito Mode
    [Arguments]   ${Email}  ${Pass}
    Set Selenium Speed  1s
    ${options}=   Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method   ${options}  add_argument  --headless
    Call Method   ${options}  add_argument  --incognito
    Call Method   ${options}  add_argument  --disable-gpu
    Create WebDriver   Chrome  options=${options}
    Go To  ${AWS_URL}
    # reload page
    maximize browser window
    sleep   1s
    wait until page contains element    ${MOBILE OR EMAIL}  30s
    wait until element is visible   ${MOBILE OR EMAIL}  30s
    Input Text   ${MOBILE OR EMAIL}   ${Email}     #abhijit@gmail.com   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    Input Text   ${PASSWORD}   ${Pass}   #8605544332    #${Pass}     #8824427172   #4652049559
    click    ${SIGNIN}
    # wait until page contains  OEE Dashboard  30
    sleep    0.05s
Supervisor Login
    [Arguments]    ${Name}  ${xpath}
    Login To ManufApp Site
#    Open Browser In Headless Mode
    wait until page contains element    ${MASTERS1}  30s
    mouse over  ${MASTERS1}
    click   ${EMPLOYEE_&_ACCESS}
    click   ${MASTERS1}
#    wait until element is visible   ${CLICK_SEARCH_ICON}    30s
#    click   ${CLICK_SEARCH_ICON}
#    input   ${SEARCH_EMPLOYEE_NAME}   ${Name}
#    Search Employee Name    Nitesh
    sleep   0.05S
    click   ${xpath}
    click   ${CLICK_EDIT}
    sleep   1s
TC_02Employee Access
    [Arguments]    ${xpath}
#    Open Chrome Browser In Incognito Mode
    sleep   1s
    wait until element is visible   ${xpath}    30s
    mouse over   ${xpath}
TC_03Employee Access
    [Arguments]    ${xpath}
    wait until element is visible   ${xpath}   30s
Supervisor Access
    [Arguments]    ${Email}   ${Pass}   #${order_number}
    Input   ${MOBILE OR EMAIL}   ${Email}   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    Input   ${PASSWORD}   ${Pass}    #${Pass}     #8824427172   #4652049559
    click   //*[text()='Sign In']
    wait until element is visible    ${PLANNING_&_SCHEDULING}   30s
Format And Print Table Data
    [Arguments]    ${table_data}
    # Splitting lines and processing as needed
    Log    | Item                | Process           | Total       | Produced    | Remaining   | Process Time |
    Log    |---------------------|-------------------|-------------|-------------|-------------|--------------|
    # Assuming the text is split by newlines or tabs
    FOR    ${line}    IN    @{table_data.splitlines()}
        Log    ${line}
    END

Select data
#    [Arguments]  ${input}   ${item}
#    wait until element is visible   ${input}    30s
#    input  ${input}  ${item}
##    click  (//*[text()="${item}"])[2]    #(//*[contains(text(),'${item}')])[2]
#    Press Keys  (//*[text()="${item}"])[2]  ARROW_DOWN   ENTER
    [Arguments]  ${input}   ${item}
    Wait Until Element Is Visible   ${input}    30s
    Input Text  ${input}  ${item}
    Sleep  0.5s  # Allow dropdown to load suggestions
    Press Keys  ${input}  ARROW_DOWN
    Sleep  0.2s
    Press Keys  ${input}  ENTER
Select
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Click Element  ${locator}  # Click input to activate dropdown
    Sleep  0.5s
    Press Keys  ${locator}  ARROW_DOWN
    Sleep  0.2s
    Press Keys  ${locator}  ENTER
select Shift
    [Arguments]  ${input}  ${shiftname}
    input  ${input}  ${shiftname}
    click  (//*[contains(text(),'${shiftname}')])[2]
Select SO
    [Arguments]    ${SO_Num}
    input   ${Input SO}   ${SO_Num}
    click   (//span[contains(text(),'${SO_Num}')])[2]
Select_WO
    [Arguments]    ${WO_Num}
    input   ${Input WO}   ${WO_Num}
    click   (//span[contains(text(),'${WO_Num}')])[2]
Check And Click Finalize BOM
    [Arguments]    ${FINALIZE_BOM}
    Sleep    0.1s
    ${is_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Finalize_BOM}    30s
    Run Keyword If    ${is_visible}    Finalize BOM
    ...    ELSE    Log    BOM finalization is not visible
Finalize BOM
    Click  ${Finalize_BOM}
    Wait Until Element Is Visible  (//*[normalize-space(text())='${itemData1}[0]'])[5]    30s
    Select Checkbox  ${Select_all}
    Click  ${Save}
    Wait Until Element Is Visible  ${Finalize_BOM_Text}    30s
    ${Text}=  Get Text  ${Finalize_BOM_Text}
    Log  ${Text}
    Log  Finalization is completed
Scroll Up To Element
    [Arguments]    ${process}   ${order_Num}
    set selenium speed  0.5s
    Scroll Element Into View   (//*[text()="${process}"]/../../..//div)[8]//div[text()="${order_Num}"]
    wait until element is visible  (//*[text()="${process}"]/../../..//div)[8]//div[text()="${order_Num}"]    30s
    click  (//*[text()="${process}"]/../../..//div)[8]//div[text()="${order_Num}"]
Select Machine For Production
    [Arguments]  ${input}  ${item}
    wait until element is visible  ${input}    30s
    input  ${input}  ${item}
    click  //span[contains(text(),'${item}')]


