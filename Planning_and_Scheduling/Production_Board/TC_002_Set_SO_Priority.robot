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
Verify That To Set The SO Priority
    Login To ManufApp Site2
    Select Your Site    2     #t_r_z_m_a_r_t_p_v_t_l_t_d   #Smart Factory        #testingsiteautomation
    sleep   1s
    ${order_number}   ${randomrefNumber}=  Keyword1.Create_SO   ${customername1}[0]   ${itemData1}[0]
    log to console    ${order_number}
    click   //a[normalize-space(text())='${order_number}']
    sleep   0.5s
    Reload
    Check And Click Finalize BOM    ${Finalize_BOM}
    Wait For Elements State   ${Expand_All_Btn}  visible    timeout=30s
    click   ${Expand_All_Btn}
    Scroll Element Into View    ${Expand_All_Btn2}
    Wait For Elements State   ${Expand_All_Btn2}  visible    timeout=30s
    click   ${Expand_All_Btn2}
    Hover   ${PLANNING_&_SCHEDULING}
    click   ${Production_Board}
    Wait For Elements State   ${All_Sales_Order}  visible    timeout=30s
    click   ${All_Sales_Order}
    Input   ${By_Sales_Order_SearchBox}   ${order_number}
    click   ${Production Board2}
    Wait For Elements State   (//*[@class="ant-select-arrow"])[3]  visible    timeout=30s
    sleep   0.05s
    Click   ${Set_Priority}
    Wait For Elements State   //*[text()="High"]  visible    timeout=30s
    Click   //*[text()="High"]
    Click   ${Agree}
    Wait For Elements State   //div[normalize-space(text())='${order_number} set High Priority']  visible    timeout=30s
    ${msg}=    Browser.Get Text    //div[normalize-space(text())='${order_number} set High Priority']
    log    ${msg}
    log to console  Priority Set is successfully Complited
    sleep  1s
    [Teardown]   Browser.Close Browser