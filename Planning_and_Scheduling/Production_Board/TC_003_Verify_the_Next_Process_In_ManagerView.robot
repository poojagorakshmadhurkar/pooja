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
@{itemData2}    Mould_MRF-14 8X9    Cutting_MRF-14 8X9   Print_MRF-14 8X9   Emboss_MRF-14 8X9    Stich_MRF-14 8X9    Assy_MRF-14 8X9   MRF-14 8X9
@{machine}    Moulding-Machine   Cutting-Machine   Printing-Machine   Emboss-Machine   Stiching-Machine   Assembling-Machine    Packaging-Machine
@{shift}    GENERAL   First_Shift   morning
@{process}   MOULDING    CUTTING   PRINTING   EMBOSSING    STICHING    ASSY   PACKING
${REGULAR_BROWSER}    None
${INCOGNITO_BROWSER}  None
*** Test Cases ***
Verify the Processs
    set selenium speed    0.5s
    open browser  ${DEVURL}  ${BROWSER}   alias=regular
    Maximize Browser Window
    Login To ManufApp Site2
    # Open Browser In Headless Mode
    select site   productio_board_unit     #t_r_z_m_a_r_t_p_v_t_l_t_d   #Smart Factory        #testingsiteautomation
    sleep  1s
    ${order_number}  ${randomrefNumber}=  Keyword1.Create_SO   ${customername1}[0]   ${itemData1}[0]
    log to console   ${order_number}
    click  //a[normalize-space(text())='${order_number}']
    sleep  0.5s
    reload page
    Check And Click Finalize BOM   ${Finalize_BOM}
    wait until element is visible  ${Expand_All_Btn}   30s
    click  ${Expand_All_Btn}
    Scroll Element Into View   ${Expand_All_Btn2}
    wait until element is visible  ${Expand_All_Btn2}   30s
    click  ${Expand_All_Btn2}
    Mouse Over  ${PLANNING_&_SCHEDULING}
    click  ${Production_Board}
    wait until element is visible   ${All_Sales_Order}  30s
    click   ${All_Sales_Order}
    Input   ${By_Sales_Order_SearchBox}   ${order_number}
    click   ${Production Board2}
    wait until element is visible   (//*[@class="ant-select-arrow"])[3]  30s
    sleep   0.05s
    Safely Click Element   ${Set_Priority}
    wait until element is visible   ${Set_High}  30s
    Safely Click Element   ${Set_High}
    click   ${Agree}
    wait until element is visible   //div[normalize-space(text())='${order_number} set High Priority']  30s
    ${msg}=    get text    //div[normalize-space(text())='${order_number} set High Priority']
    log    ${msg}
    log to console  Priority Set is successfully Complited
    sleep  1s
    Go Back
    wait until element is visible   ${PLANNING_&_SCHEDULING}  30s
    Mouse Over    ${PLANNING_&_SCHEDULING}
    click   ${Production_Board}
    wait until element is visible   ${All_Sales_Order}  30s
    click   ${All_Sales_Order}
    Input   ${By_Sales_Order_SearchBox}   ${order_number}
    click   ${Production Board2}
    click   ${Section_View}
    wait until element is visible    //*[text()="${machine}[1]"]   30s
    wait until element is visible    //*[text()="${machine}[0]"]   30s
    log    We can produce the next process on these two machines i,e ${machine}[1], ${machine}[0]
    sleep   0.5s
    [Teardown]    Close Browser




