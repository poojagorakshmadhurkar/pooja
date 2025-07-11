
*** Settings ***
#Library     SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Resource    ../../orders/PurchaseOrder/keyword.robot
Resource    ../../orders/PurchaseOrder/variable.robot
Resource    ../../keywords.robot
Resource    ../../variables.robot
Library     Browser

*** Keywords ***
Create_SO
    [Arguments]  ${customername1}  ${itemData11}
    Open Order Tracker Page
    Sleep    3s
    click  ${newSO}
    Sleep    3s
    Wait For Elements State        //span[text()="Add New SO"]    timeout=30s
    Select Customer   ${customername1}
    ${randomrefNumber}=    Generate Random String    5-10    [NUMBERS]
    Fill Text        ${refNumber}    ${randomrefNumber}
    Delivery Date Entry
    set ith item in so  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    ${order_info}    browser.Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click  ${createNewOrder}
    click  ${backbutton}
    #validation for so creation search
    search Sonumber in SoListpage for validation  ${order_number}

#    wait until element is visible   (//*[text()="TRZ MA/2412/094"])[2]/ancestor::tr//td[3]    timeout=30s  #//a[text()="${order_number}"]/../../../../../../../../../../td[2][text()="${randomrefNumber}"]/../td[3][text()="${customername1}[0]"]   timeout=30s
    RETURN    ${order_number}   ${randomrefNumber}

Click on Detail View
    [Arguments]  ${ItemData1}  ${machine}  ${reason}
    click    ${DETAILS_VIEW}

    Wait For Elements State        ${ITEM_DETAILS_SEARCHBOX}
#    Search item
    Search Item in Item Details SearchBox   ${ItemData1}[1]  2   1   3
    click   ${CLICK_PARTNER_SEARCH_ICON1}
    click   ${CLICK_PARTNER_INPUT_BOX}
    select partner1   ${Vendor}[0]
    click   ${CLICK_PARTNER_SEARCH_ICON2}
    click  //button[text()="Detailed View"]
#    search rejectedquantity in warehouse summary view  ${itemName}
    ${quantityS}  browser.Get Text  ((//span[text() = "${ItemData1}[1]"]/ancestor::tr/td[5][text()="Production"])/../td[7][text()="${machine}"]/../td[8][text()="${reason}"])[2]/../td[9]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}


Search Item in Item Details
    [Arguments]    ${ItemName}    ${index1}    ${index2}    ${index3}

    click   (//*[@id="live_inventory_Item Details_search"])[${index1}]
    Fill Text        (//*[@placeholder='Search Item Details'])[${index2}]   ${ItemName}
    click   (//*[@id="live_inventory_Item Details_search"])[${index3}]

Search Note in MRN Issue Searchbox
    [Arguments]    ${index1}
    click   ${SEARCH_IN_MRN_ISSUE_NOTE}
    Fill Text    ${INPUT_INTO_MRN_ISSUE_NOTE}    ${index1}
    click   (//*[@id="transaction_Material Issue Note_search"])[3]

