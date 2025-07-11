*** Settings ***
Library   Browser
Library   String
Library   Collections
Library   DateTime
Library   BuiltIn
Resource  ../PurchaseOrder/variable.robot
Resource  ../PurchaseOrder/keyword.robot
#Resource  ../NPD/Keyword.robot
Resource  ../NPD/Variable.robot
*** Variables ***
${FILE_PATH}  ${EXECDIR}/../Files/RO-002.pdf
*** Test Cases ***
Create_Inquiry
    Login To ManufApp Site
    Hover  ${ORDERS}
    Click  ${inquiry}
    Sleep  4s
    Wait For Load State   domcontentloaded   timeout=30s
    Click  ${NEW}
    Sleep  4s
    Wait For Load State   domcontentloaded   timeout=30s
    Wait For Elements State    //*[@class="ant-select-selection-search-input"]  visible  timeout=30s
    Select From Dropdown   //*[@class="ant-select-selection-search-input"]   Rajan
    Click  ${Item Details + button}
    Sleep  1s
    Hover  ${Add Item}  #add item
    Click  ${Add Formulation Item}
    Wait For Elements State    ${submit}   visible  timeout=30s
    Click  ${F_item_submit}
    ${success_msg}=  Get Text    //div[normalize-space(text())='Item Created Successfully']
    Log   ${success_msg}
    input  (//input[@class='ant-input-number-input'])[2]   10
    input  (//input[@class='ant-input-number-input'])[3]   20
    input  (//input[@class='ant-input-number-input'])[4]   10
    input  (//input[@class='ant-input-number-input'])[5]   2
    input  (//input[@class='ant-input'])[2]    78
    Click  (//*[@data-testid="AddOutlinedIcon"])[2]
    Upload File By Selector  ${Brows File}    C:/Users/nites/Downloads/RO-002.pdf
    Click   ${submit}
    ${textA}=   Get Text  //div[normalize-space(text())='Data added']
    Log  ${textA}
    Hover  ${ORDERS}
    Click  ${inquiry}
    ${label}=   Get Text    (//a[@id='undefined_label'])[1]
    Log  ${label}
    Search_Items    undefined_Label_search   Search Label   1  2   ${label}









*** Keywords ***