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
@{customername1}   Nitesh_Customer  Nitesh1
@{itemData1}   iPhone 15Pro   200    30
${REGULAR_BROWSER}    None
${INCOGNITO_BROWSER}  None
*** Test Cases ***
Create Sales Order And Finalize BOM
    set selenium speed    0.5s
    open browser   ${DEVURL}   ${BROWSER}    alias=regular
    Maximize Browser Window
    Login To ManufApp Site2
    sleep   1s
    select site    productio_board_unit
    ${order_number}   ${randomrefNumber}=    Keyword1.Create_SO    ${customername1}[0]    ${itemData1}
    Log To Console    ${order_number}
    Click    //a[normalize-space(text())='${order_number}']
    reload page
    Sleep    0.5s
    ${is_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Finalize_BOM}    30s
    Run Keyword If    ${is_visible}    Finalize BOM
    ...    ELSE    Log    BOM finalization is not visible
    sleep  0.5s
    [Teardown]    Close Browser

*** Keywords ***
Finalize BOM
    Click    ${Finalize_BOM}
    Wait Until Element Is Visible    (//*[normalize-space(text())='${itemData1}[0]'])[3]    30s
    Select Checkbox    ${Select_all}
    Click    ${Save}
    Wait Until Element Is Visible    ${Finalize_BOM_Text}    30s
    ${Text}=    Get Text    ${Finalize_BOM_Text}
    Log    ${Text}
    Log    Finalization is completed