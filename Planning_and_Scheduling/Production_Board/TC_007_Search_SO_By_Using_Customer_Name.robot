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
@{customername1}   GK_Customer
@{itemData1}   POCO    200   50
@{itemData2}    Mould_MRF-14 8X9    Cutting_MRF-14 8X9   Print_MRF-14 8X9   Emboss_MRF-14 8X9    Stich_MRF-14 8X9    Assy_MRF-14 8X9   MRF-14 8X9
@{machine}    Moulding-Machine   Cutting-Machine   Printing-Machine   Emboss-Machine   Stiching-Machine   Assembling-Machine    Packaging-Machine
@{shift}    GENERAL   First_Shift   morning
@{process}   MOULDING    CUTTING   PRINTING   EMBOSSING    STICHING    ASSY   PACKING
${REGULAR_BROWSER}    None
${INCOGNITO_BROWSER}  None
*** Test Cases ***
Verify That To Set The SO Priority
    set selenium speed    0.5s
    open browser  ${DEVURL}   ${BROWSER}   alias=regular
    Maximize Browser Window
    Login To ManufApp Site2
    # Open Browser In Headless Mode
    select site    productio_board_unit     #t_r_z_m_a_r_t_p_v_t_l_t_d   #Smart Factory        #testingsiteautomation
    sleep   1s
    ${order_number}  ${randomrefNumber}=  Keyword1.Create_SO   ${customername1}[0]   ${itemData1}[0]
    log to console  ${order_number}
    click   //a[normalize-space(text())='${order_number}']
    reload page
    sleep   0.5s
    Check And Click Finalize BOM  ${Finalize_BOM}
    Mouse Over  ${PLANNING_&_SCHEDULING}
    click  ${Production_Board}
    wait until element is visible  ${All_Sales_Order}  30s
    click  ${All_Sales_Order}
    Input  (//*[@id="debit__form__recipient"])[1]  GK_Customer
    click  ${Production Board2}
    wait until element is visible  //*[@class="so_card"]//div//following::span[8][text()="GK_Customer"]   30s
    ${count}=  Get Element Count  //*[@class="so_card"]//div//following::span[8][text()="GK_Customer"]
    log  After Search we get ${count} ${customername1}[0] carts
    sleep  0.05s
    [Teardown]  Close Browser