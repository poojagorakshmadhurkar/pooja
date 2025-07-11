*** Settings ***
Library   Browser
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
@{itemData2}    Mould_MRF-14 8X9    Cutting_MRF-14 8X9   Print_MRF-14 8X9   Emboss_MRF-14 8X9    Stich_MRF-14 8X9    Assy_MRF-14 8X9   MRF-14 8X9
@{machine}    Moulding-Machine   Cutting-Machine   Printing-Machine   Emboss-Machine   Stiching-Machine   Assembling-Machine    Packaging-Machine
@{shift}    GENERAL   First_Shift   morning
@{process}   MOULDING    CUTTING   PRINTING   EMBOSSING    STICHING    ASSY   PACKING
${REGULAR_BROWSER}    None
${INCOGNITO_BROWSER}  None
*** Test Cases ***
Verify Production Flow
    set selenium speed    0.5s
    Login To ManufApp Site
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
    sleep   0.05s
    Safely Click Element   ${Set_Priority}
    wait until element is visible   //*[text()="High"]  30s
    Safely Click Element   //*[text()="High"]
    click   ${Agree}
    wait until element is visible   //div[normalize-space(text())='${order_number} set High Priority']  30s
    ${msg}=    Browser.Get Text    //div[normalize-space(text())='${order_number} set High Priority']
    log    ${msg}
    Browser.Go Back
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
#    Safely Click Element   //*[text()="Item"]
    click   ${Selects_all}
    click   ${Bulk_plan}
    wait until element is visible   ${Plan_All1}    30s
    click   ${Plan_All1}
    click   ${Continue}
    click   ${click_schedule}
    click   ${Optimize}
    wait until element is visible   (//*[@class="MuiTableBody-root css-1xnox0e"])[2]    30s
    ${Optimize data}=    Browser.Get Text    (//*[@class="MuiTableBody-root css-1xnox0e"])[2]
    log     ${Optimize data}
    log to console    ${Optimize data}
    ${Estimate of WO}=  Browser.Get Text    //*[@style="display: flex; gap: 50px;"]
    log to console   ${Estimate of WO}
    log   ${Estimate of WO}
    click   ${Regview Sequence}
    click   ${Schedule_WO}
    wait until element is visible   ${WO_creation_Note}    30s
    ${WO_Note}=  Browser.Get Text    ${WO_creation_Note}
    log to console  ${WO_Note}
    Switch Window    ${Chrome_windows[0]}
    ${WONo}=  Get WO_No's   ${machine}[0]
    Supervisor Access   ${Supervisor_Email}   ${Supervisor_Pass}    #${order_number}
    Mouse Over    ${PLANNING_&_SCHEDULING}
    click   ${Production_Board}
    set selenium speed   0.05s
    Input   ${By_Sales_Order_SearchBox}   ${order_number}
    click   ${Production Board2}
    Select data   ${Machines_Dropdown}   ${Machine}[0]
    sleep   0.5s
    click   //*[@data-testid="RefreshIcon"]
    sleep   0.5s
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
    ${Cart}=    Browser.Get Text    ${SO_Cart}
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
    # select Shift   ${shift}[0]
    Wait Until Element Is Not Visible    ${loaderinterval}    timeout=30s
    Select data    ${Select_WO_To_Enter_Production}    ${WONo}
    sleep   1s
    click  ${productionsubmitbutton}
    sleep   1s
    ${enter qty}=   Generate Random number   2
    wait Until Element is visible   ${Enter_Production_Qty}     30s
    sleep   1s
    input   ${Enter_Production_Qty}    ${enter qty}
    log   production entered Qty = ${enter qty}
    click   ${Submit_Enter_Production}
    wait Until Element is visible   ${Success_msg}     30s
    ${production_Success_msg}=  Browser.Get Text    ${Success_msg}
    log   ${production_Success_msg}
    sleep   0.5s
    Switch Window  ${incognito_windows[0]}
    click   //*[@data-testid="RefreshIcon"]
    ${Remaning}  Evaluate  (${itemData1}[1] - ${enter qty})
    wait until element is visible   (//*[text()="${itemData2}[0]"])[1]//following::td[1]//span[text()="${process}[0]"]  30s
    wait until element is visible   //span[text()="${itemData1}[1] pair"]/../..//td[4]//span[text()="${enter qty} pair"]/../..//td[5]//span[text()="${Remaning} pair"]  30s
    click   //button[text()="Pause"]
    wait until element is visible   //div[text()="${order_number} has been Paused"]     30s
    ${Notification msg}=    Browser.Get Text    //div[text()="${order_number} has been Paused"]
    log    ${Notification msg}
    # wait until element is visible   //button[text()="Resume"]
    # element text should be  //button[text()="Resume"]   Resume
    Browser.Close Browser
    # Switch Window    ${Chrome_windows[0]}
    ${WONo}=  Get WO No's   ${machine}[1]

*** Keywords ***
Get WO_No's
    [Arguments]  ${machine}
    sleep  0.5s
    click  //*[text()="Work Orders"]
    wait until element is visible  (//*[text()="${machine}"])[1]   30s  #click checkbox for selecting machine
    click element  (//*[text()="${machine}"])[1]   #WO checkbox click
    wait until element is visible  //span[text()="${machine}"]//following::div[17]//*[text()="${machine}"]   30s
    ${WO_Num}=  Browser.Get Text  ${woNo}
    log  ${WO_Num}
    RETURN  ${WO_Num}
