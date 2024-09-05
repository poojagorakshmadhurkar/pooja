
*** Settings ***
Library     SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Resource    ../../planning/PurchaseOrder/keyword.robot
Resource    ../../planning/PurchaseOrder/variable.robot
Resource    ../../keywords.robot
Resource    ../../variables.robot

*** Keywords ***
Create_SO
    [Arguments]    ${customername}    ${itemData1}
    mouse over   ${ORDERS}
    click   ${SALES_ORDERS}
    click  ${newSO}
    sleep    1s
    wait until element is visible    ${NEW}  30s
    select customer  ${customername}[0]
    ${randomrefNumber}=  generate random string  5-10  [NUMBERS]
    input  ${refNumber}  ${randomrefNumber}
    delivery date entry
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    set ith item in so  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    sleep  0.5s
    ${order_info}    Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click  ${createNewOrder}
    wait until element is visible    ${backbutton}  30s
    click  ${backbutton}
    RETURN    ${order_number}
Click on Detail View
    [Arguments]  ${ItemData1}  ${machine}  ${reason}
    click    ${DETAILS_VIEW}
    sleep    2s
    wait until page contains element    ${ITEM_DETAILS_SEARCHBOX}
#    Search item
    Search Item in Item Details SearchBox   ${ItemData1}[1]  2   1   3
    click   ${CLICK_PARTNER_SEARCH_ICON1}
    click   ${CLICK_PARTNER_INPUT_BOX}
    select partner1   ${Vendor}[0]
    click   ${CLICK_PARTNER_SEARCH_ICON2}
    click  //button[text()="Detailed View"]
#    search rejectedquantity in warehouse summary view  ${itemName}
    ${quantityS}  Get Text  ((//span[text() = "${ItemData1}[1]"]/ancestor::tr/td[5][text()="Production"])/../td[7][text()="${machine}"]/../td[8][text()="${reason}"])[2]/../td[9]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}


Search Item in Item Details
    [Arguments]    ${ItemName}    ${index1}    ${index2}    ${index3}
    set selenium speed    0.5s
    click   (//*[@id="live_inventory_Item Details_search"])[${index1}]
    input text    (//input[@placeholder='Search Item Details'])[${index2}]   ${ItemName}   ${ItemData1}[1]
    click   (//*[@id="live_inventory_Item Details_search"])[${index3}]

Search Note in MRN Issue Searchbox
    [Arguments]    ${index1}
    click   ${SEARCH_IN_MRN_ISSUE_NOTE}
    input text   ${INPUT_INTO_MRN_ISSUE_NOTE}    ${index1}
#    click   (//*[@id="transaction_Material Issue Note_search"])[3]

