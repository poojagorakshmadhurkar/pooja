*** Settings ***
Documentation    Verify PO Details
Library    Browser
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Nitesh_Vendor   Newvendortest01
@{ItemData}  0  MR1_7_ABC_18  50   30  101  #LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK
${expected_text}    Issued
*** Test Cases ***
Verify PO RM_Name Should Be Visible in Dropdown
    Login To ManufApp Site2     # Login To ManufApp Site
    Select Your Site  4   Main_Automation_Unit     #purchase_order_unit    #testingsiteautomation #Smart Factory
    Landing On Purchase Order Page
    Sleep   4s
    Wait For Load State    domcontentloaded    timeout=30s
    click   ${CREATE_NEW_BUTTON}
    Sleep   4s
    Select Vendor for PO  ${vendor}[0]
    select Delivery Date
    ${today1}  Get Current Date  result_format=%d-%m-%Y
    Fill Text    //*[@id="purchase_order_remarks"]    Normal
    Sleep    1s
    Select From Dropdown    (//*[@class="ant-select-selection-search-input"])[3]    Plant 2
    input  ${ITEM CODE}  ${ItemData}[1]
    click  (//*[contains(text(), '${ItemData}[1]')])[2]
    Wait For Elements State  ${PO_QTY_INPUBOX}  visible   timeout=30s
    input  ${PO_QTY_INPUBOX}  20
    input    //*[@id="purchase_order_0_hsn"]    121
    input    //*[@id="purchase_order_0gst"]    17
    click  ${SUBMIT}
    log to console  PO creation Successfully done
    ${order_info}    Browser.Get Text   xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}   Evaluate   "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}   Evaluate   "${order_info}"[${start_index}:${end_index}]
    click  ${BACK}
    Wait For Elements State  ${SEARCH ICON}  visible   timeout=30s
    Search In PO  ${order_number}
    click  ${ITEM_VIEW_TOGGLE_BUTTON}
    click  ${PO_ITEM_DETAILS_SEARCH}
    input  ${ITEM_DETAILS_SEARCH_INPUTBOX}   CR00015
    sleep  1s
    Wait For Elements State   (//*[contains(text(), '${ItemData}[1]')])[1]    visible   timeout=30s
    sleep  0.5s
    click  ${ITEM_DETAILS_SEARCH_ICON}
    sleep  0.05s
    [Teardown]    Browser.Close Browser

