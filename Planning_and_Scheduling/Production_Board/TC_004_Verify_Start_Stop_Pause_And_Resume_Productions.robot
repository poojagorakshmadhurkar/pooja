*** Settings ***
Library   SeleniumLibrary
Library   String
Library   Collections
Library   DateTime
Library   BuiltIn
Resource  ../../keywords.robot
Resource  ../../variables.robot
Resource  ../../././orders/PurchaseOrder/keyword.robot
Resource  ../../././orders/PurchaseOrder/variable.robot
Resource  ../../././orders/Salesorder/keywords.robot
Resource  ../../././orders/Salesorder/variables.robot
Resource  ../../././inventory/Rework_Reuse_Scrap/Keyword1.robot
Resource  ../../././inventory/Rework_Reuse_Scrap/Variable1.robot
Resource  ../../././Access_Control/Variable.robot
Resource  ../../././Access_Control/Keyword.robot
Resource  ../Production_Board/Variable.robot
Resource  ../Production_Board/Keyword.robot
Resource  ../WorkordersFlow/keyword.robot
*** Variables ***
@{customername1}   Nitesh_Customer  Nitesh1
@{itemData1}   MRF-14 8X9    200   50   400
@{itemData2}   Mould_MRF-14 8X9    Cutting_MRF-14 8X9   Print_MRF-14 8X9   Emboss_MRF-14 8X9    Stich_MRF-14 8X9    Assy_MRF-14 8X9   MRF-14 8X9
@{machine}   Moulding-Machine   Cutting-Machine   Printing-Machine   Emboss-Machine   Stiching-Machine   Assembling-Machine    Packaging-Machine
@{shift}    GENERAL   First_Shift   morning
@{process}   MOULDING    CUTTING   PRINTING   EMBOSSING    STICHING    ASSY   PACKING
${REGULAR_BROWSER}    None
${INCOGNITO_BROWSER}  None
*** Test Cases ***
Verify The Production Activity
    set selenium speed    0.5s
    open browser   ${DEVURL}   ${BROWSER}    alias=regular
    Maximize Browser Window
    Login To ManufApp Site2
    # Open Browser In Headless Mode
    select site    productio_board_unit     #t_r_z_m_a_r_t_p_v_t_l_t_d   #Smart Factory        #testingsiteautomation
    sleep   1s
    ${order_number}   ${randomrefNumber}=  Keyword1.Create_SO   ${customername1}[0]   ${itemData1}[0]
    log to console    ${order_number}
    click   //a[normalize-space(text())='${order_number}']
    sleep   0.5s
    reload page
    Check And Click Finalize BOM    ${Finalize_BOM}
    wait until element is visible   ${Expand_All_Btn}   30s
    click   ${Expand_All_Btn}
    Scroll Element Into View    ${Expand_All_Btn2}
    wait until element is visible   ${Expand_All_Btn2}   30s
    click   ${Expand_All_Btn2}
    Mouse Over    ${PLANNING_&_SCHEDULING}
    click   ${Production_Board}
    wait until element is visible   ${All_Sales_Order}  30s
    click   ${All_Sales_Order}
    Input   ${By_Sales_Order_SearchBox}   ${order_number}
    click   ${Production Board2}
    wait until element is visible   (//*[@class="ant-select-arrow"])[3]  30s
    sleep   0.5s
    Safely Click Element   ${Set_Priority}
    wait until element is visible   ${Set_High}  30s
    Safely Click Element   ${Set_High}
    click   ${Agree}
    wait until element is visible   //div[normalize-space(text())='${order_number} set High Priority']  30s
    ${msg}=    get text    //div[normalize-space(text())='${order_number} set High Priority']
    log    ${msg}
    Go Back
    wait until element is visible   ${Createe_WO}   30s
    set selenium speed  0.5s
    Safely Click Element   ${Createe_WO}
    sleep   0.5s
    ${Chrome_windows}=    Get Window Handles
    Log    ${Chrome_windows}
    Switch Window    ${Chrome_windows[1]}
    Log    Switched to window: ${Chrome_windows[1]}
    sleep   0.5s
    Safely Click Element   ${Show Filters}
    Safely Click Element   //*[text()="Item"]
#    click   ${Createe_WO}
    Scroll Up To Element    ${itemData2}[0]    ${order_number}
    Safely Click Element   ${click to create wo}
    Safely Click Element   ${Bulk plann}
    Safely Click Element   ${Review_Change}
    Safely Click Element   ${+Create}
    wait until element is visible   ${WO_creation_Note}    30s
    ${WO_Note}=     get Text   ${WO_creation_Note}
    log    ${WO_Note}
    sleep   0.5s
    ${WO_ID}=   Get All Workorders IDs
    log   ${WO_ID}
    click   //div[@data-task-id="${WO_ID}"]
    wait until element is visible   (//div[@class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 css-15j76c0"])[2]   30s
    ${WO_Details}=  get text    (//div[@class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 css-15j76c0"])[2]
    log   ${WO_Details}
    wait until element is visible   //div[text()="${customername1}[0]"]/..//div[2][text()="${randomrefNumber}"]/..//div[3]//a[text()="${order_number}"]    30s
    ${WO_Num}=  get text    ${woNo}
    log   ${WO_Num}
    Supervisor Access   ${Supervisor_Email}   ${Supervisor_Pass}    ${order_number}
    set selenium speed  0.05s
    Mouse Over    ${PLANNING_&_SCHEDULING}
    click   ${Production_Board}
    sleep   0.05s
    Input   ${By_Sales_Order_SearchBox}   ${order_number}
    click   ${Production Board2}
    Select data   ${Machines_Dropdown}   ${Machine}[0]
    sleep   0.5s
    click   //*[@data-testid="RefreshIcon"]
    wait until element is visible   //span[text()="${customername1}[0]"]//following::span[text()="H"]//following::div[3]//span//a[text()="${order_number}"]   30s
    wait until element is visible   (//*[text()="${itemData2}[0]"])[1]//following::td[1]//span[text()="${process}[0]"]  30s
    wait until element is visible   ${SO_Cart}   30s
    Safely Click Element   ${Start}
    wait until element is visible   //div[text()="${order_number} has been Started"]    30s
    sleep   1s
    click   ${In_production}
    wait until element is visible   //span[text()="${customername1}[0]"]//following::span[text()="H"]//following::div[3]//span//a[text()="${order_number}"]    30s
    wait until element is visible   (//*[text()="${itemData2}[0]"])[1]//following::td[1]//span[text()="${process}[0]"]  30s
    wait until element is visible   ${SO_Cart}   30s
    wait until element is visible   //*[text()="${itemData1}[1] pair"][1]    30s
    wait until element is visible    ${SO_Cart}    30s
    sleep   0.05s
    ${Cart}=    get text    ${SO_Cart}
    log  ${Cart}
    wait until element is visible    ${Record Production}    30s
    Safely Click Element    ${Record Production}
    ${incognito_windows}=    Get Window Handles
    Log    ${incognito_windows}
    Switch Window    ${incognito_windows[1]}
    Log    Switched to window: ${incognito_windows[1]}
    wait until element is visible   //*[text()="Production Reports"]    timeout=50s
    select machinesSo  ${machine}[0]
    sleep   1s
#    select ShiftsSo   ${shift}[0]
    Wait Until Element Is Not Visible    ${loaderinterval}    timeout=30s
    Select data    ${Select_WO_To_Enter_Production}    ${WO_Num}
    sleep   1s
    click  ${productionsubmitbutton}
    sleep   1s
    ${enter qty}=   Generate Random number_2_digit
    wait Until Element is visible   ${Enter_Production_Qty}     30s
    sleep   0.5s
    input   ${Enter_Production_Qty}    ${enter qty}
    log    production entered Qty = ${enter qty}
    click   ${Submit_Enter_Production}
    wait Until Element is visible   ${Success_msg}     30s
    ${production_Success_msg}=  get text    ${Success_msg}
    log   ${production_Success_msg}
    sleep   0.5s
    Switch Window    ${incognito_windows[0]}
    click   //*[@data-testid="RefreshIcon"]
    ${Remaning}    Evaluate    (${itemData1}[1] - ${enter qty})
    wait until element is visible   (//*[text()="${itemData2}[0]"])[1]//following::td[1]//span[text()="${process}[0]"]  30s
    wait until element is visible   //span[text()="${itemData1}[1] pair"]/../..//td[4]//span[text()="${enter qty} pair"]/../..//td[5]//span[text()="${Remaning} pair"]  30s
    click   //button[text()="Pause"]
    wait until element is visible   //div[text()="${order_number} has been Paused"]     30s
    ${Notification msg}=    get text    //div[text()="${order_number} has been Paused"]
    log    ${Notification msg}
    wait until element is visible   //button[text()="Resume"]
    element text should be  //button[text()="Resume"]   Resume
