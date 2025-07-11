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
Resource    ../../././inventory/Rework_Reuse_Scrap/Keyword1.robot
Resource    ../../././inventory/Rework_Reuse_Scrap/Variable1.robot
Resource    ../../././Access_Control/Variable.robot
Resource    ../../././Access_Control/Keyword.robot
Resource    ../Production_Board/Variable.robot
Resource    ../Production_Board/Keyword.robot
*** Variables ***
@{customername1}   GK_Customer  Nitesh_Customer
@{itemData1}   POCO  200   50   200
@{itemData2}   POCO    Mould_MRF-14 8X9    Cutting_MRF-14 8X9   Print_MRF-14 8X9   Emboss_MRF-14 8X9    Stich_MRF-14 8X9    Assy_MRF-14 8X9   MRF-14 8X9
@{machine}    ASSEMBLING    Moulding-Machine   Cutting-Machine   Printing-Machine   Emboss-Machine   Stiching-Machine   Assembling-Machine    Packaging-Machine
@{shift}    GENERAL   First_Shift   morning
@{process}   MOULDING    CUTTING   PRINTING   EMBOSSING    STICHING    ASSY   PACKING
${REGULAR_BROWSER}    None
${INCOGNITO_BROWSER}  None
*** Test Cases ***
Enter_production
    set selenium speed  0.05s
    Open Browser Site
    Login To ManufApp Site2    # Login To ManufApp Site
    # Open Browser In Headless Mode
    select site   productio_board_unit     #productio_board_unit  #t_r_z_unit1   #Smart Factory  #testingsiteautomation
    sleep  0.5s
    ${order_number}  ${randomrefNumber}=  Keyword1.Create_SO  ${customername1}[0]   ${itemData1}[0]
    log to console  ${order_number}
    click  //a[normalize-space(text())='${order_number}']
    sleep  0.5s
    Check And Click Finalize BOM  ${Finalize_BOM}
    sleep  0.5s
    Mouse Over  ${PLANNING_&_SCHEDULING}
    click  ${Production_Board}
    set selenium speed  0.5s
    wait until element is visible  ${All_Sales_Order}  30s
    click  ${All_Sales_Order}
    Input  ${By_Sales_Order_SearchBox}  ${order_number}
    click  ${Production Board2}
    wait until element is visible  (//*[@class="ant-select-arrow"])[3]  30s
    Safely Click Element  ${Set_Priority}
    click  //*[text()="High"]
    click  ${Agree}
    wait until element is visible  //div[normalize-space(text())='${order_number} set High Priority']  30s
    ${msg}=  get text  //div[normalize-space(text())='${order_number} set High Priority']
    log  ${msg}
    Go Back
    Supervisor Access  ${Supervisor_Email}  ${Supervisor_Pass}    #${order_number}
    set selenium speed  0.5s
    Mouse Over  ${PLANNING_&_SCHEDULING}
    click  ${Production_Board}
    sleep  0.5s
    # click   ${Show Filters}
    Input  ${By_Sales_Order_SearchBox}  ${order_number}
    click  ${Production Board2}
    wait until element is visible   ${SO_Cart}   30s
    Safely Click Element   ${Start}
    sleep  1s
    click  ${In_production}
    Input  ${By_Sales_Order_SearchBox}   ${order_number}
    wait until element is visible    ${SO_Cart}    30s
    sleep  0.5s
    wait until element is visible   //*[text()="${customername1}[0]"]/../../../../../../../..//*[text()="H"][1]//following::div[3]//span//a[text()="${order_number}"]   30s
    wait until element is visible   //*[text()="200 piece"][1]    30s
    ${Cart}=  get text    ${SO_Cart}
    log to console  ${Cart}
    sleep  0.5s
    Safely Click Element    ${Record Production}
    Switch Window   title=Production Reports | MES
    wait until element is visible   //*[text()="Production Reports"]    timeout=50s
    select machinesSo  ${machine}[0]
    sleep  1s
    select ShiftsSo  ${shift}[1]
    Wait Until Element Is Not Visible    ${loaderinterval}    timeout=30s
    # click element   ${intervalDropdown}     #interval dropfown
    Select SO  ${order_number}
    sleep  1s
    click  ${productionsubmitbutton}
    sleep  1s
    ${enter qty}=   Generate Random number_2_digit
    wait Until Element is visible   //input[@id="production_qty_0"]     30s
    input   //input[@id="production_qty_0"]    ${enter qty}







