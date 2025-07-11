*** Settings ***
Library    Browser
Library    String
Library    Collections
Library    DateTime
Resource   ./../././Access_Control/Keyword.robot
Resource   ./../././Access_Control/Variable.robot
Resource   ./../././orders/PurchaseOrder/keyword.robot
Resource   ./../././orders/PurchaseOrder/variable.robot
Resource   ../Jobwork/Variable.robot
*** Keywords ***
Select TJobwork_Partner
    [Arguments]    ${Partner_name}
    Click   ${PARTNER SEARCH}
    Fill Text    (//input[@class="ant-select-selection-search-input"])[1]  ${Partner_name}
#    Wait For Elements State   (//*[normalize-space(text())='${Partner_name}'])[3]   visible  timeout=60s
    Click    (//*[@id="undefined_Partner_search"])[2]
Select_tItem_from_Dropdown
    [Arguments]    ${xpath}    ${item}
    input  ${xpath}  ${item}
    click   (//*[contains(text(), '${item}')])[2]
Search Data
    [Arguments]    ${data}    ${index1}    ${index2}    ${index3}
    Click   (//*[@id="undefined_Shipment Number_search"])[${index1}]
    Fill Text     (//*[@placeholder='Search Shipment Number'])[${index2}]   ${data}
    Click   (//*[@id="undefined_Shipment Number_search"])[${index3}]
JOW_Creation
    [Arguments]   ${ItemData1}  ${ItemData2}    ${JW_Vendor}
    Wait For Elements State   ${Subcontracting}   visible  timeout=60s
    Hover   ${Subcontracting}
    Sleep    2s
    Click   ${JW_Request}
    Sleep    2s
    Select into Dropdown   ${JOBWORK_VENDOR_INPUTBOX}   ${JW_Vendor}  #Mahindra
    Select Date   ${DELIVERY_DATE}   Today
    Sleep   1s
    Select_tItem_from_Dropdown    ${SELECT_ITEM_CODE}  ${ItemData1}
    ${randomfNum}=   Generate Random number  2
    input  ${ENTER_QTY}    ${randomfNum}
    sleep  1s
    Wait For Elements State  (//input[@aria-valuenow='${randomfNum}'])[2]   visible  timeout=60s
    Wait For Elements State  (//input[@aria-valuenow='${randomfNum}'])[3]   visible  timeout=60s
    Wait For Elements State  //*[contains(text(),'${ItemData2}')]    visible  timeout=60s
    ${selected Item}=   Browser.Get Text   //*[contains(text(),'${ItemData2}')]
    ${getData}=   Browser.Get Text    (//input[@aria-valuenow='${randomfNum}'])[2]
    log  ✅ ${selected Item}
    log  ✅ ${getData}
    Run keyword If  '${selected Item}' == '${item_name}'  Log To Console   'true'
    Run keyword If  '${randomfNum}' == '${getData}'  Log To Console   'true'
    click   ${JBW_SUBMIT}
    Wait For Elements State   ${SUCCESS_MSG}  visible  timeout=60s
    ${text}=   Browser.Get Text    ${SUCCESS_MSG}
    log  ✅ ${text}
    Hover  ${Subcontracting}
    Click  ${TRANSACTIONS}
    Sleep  1s
    ${Fist note}=   Get Text    (//tr[@class="ant-table-row ant-table-row-level-0"])[1]//td[@class="ant-table-cell ant-table-cell-fix-left ant-table-cell-fix-left-last"]
    Log  ✅ ${Fist note}
    Select TJobwork_Partner   ${JW_Vendor}     #Mahindra
    Search MRN No   ${Fist note}    1  1  2
    Click   ${Approve1}
    Wait For Elements State   //div[contains(text(),'MRN approved SuccesFully')]  visible  timeout=60s
    ${MRN Note}=    Browser.Get Text    //div[contains(text(),'MRN approved SuccesFully')]
    log   ✅ ${MRN Note}
    Wait For Elements State    //td[normalize-space(text())='${JW_Vendor}']   visible  timeout=60s
    Wait For Elements State    //td[normalize-space(text())='Jobwork']
    Click    //td[normalize-space(text())='Jobwork']
    Wait For Elements State    //*[normalize-space(text())='Shipment of ${JW_Vendor}']   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='Issued'])[1]   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='${Fist note}'])[2]   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='${ItemData2}'])[1]
    Wait For Elements State    (//*[normalize-space(text())='${randomfNum} kg'])[1]   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='${ItemData1}'])[1]   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='${randomfNum} kg'])[2]   visible  timeout=60s
    Click   ${CANCELICON}
    RETURN    ${Fist note}

Status check
    ${status1}=  Set Variable  Pending
    ${status2}=  Set Variable  Issued
    Run Keyword If    '${status1}' == 'Pending'    Click    //*[@id="purchase_order_approve"]
    ${status}=  Browser.Get Text   //div[@class="MuiAlert-message css-1xsto0d"]
    Run Keyword If    '${status1}' == 'Pending'    Log To Console    ${status}    ELSE    Log To Console    ${status2}

Click Approve Button When Text Available Else Close Popup
    Wait For Elements State    ${Inventory_Status1}   visible  timeout=60s
    ${text_visible}=    Run Keyword And Return Status    Safely Click Element    ${Inventory_Status1}
    Run Keyword If    ${text_visible}   Click Approve Button
    ...    ELSE    Click Button    ${Close_popup_window}

Click Approve Button
    Wait For Elements State    ${Approvee}  visible  timeout=60s
    Wait For Elements State    ${Approvee}  visible  timeout=60s
    Wait For Elements State  ${Approvee}   visible  timeout=60s
    Click  ${Approvee}
    
Click Button
    [Arguments]    ${locator}
    Click    ${locator}

Scroll Element Into View Using XPath
    [Arguments]    ${xpath}
    Scroll To   ${xpath}
#    ${element}=    Execute JavaScript     return document.evaluate("${xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
#    Scroll To Element    arguments[0].scrollIntoView();    ${element}


Scroll Right End
    [Arguments]    ${xpath}
    ${element}=    Get Elements    ${xpath}
    Scroll To     ${element}

Search MRN No
    [Arguments]    ${name}  ${index1}  ${index2}   ${index3}
    Click   //*[@id="undefined_Material Issue Note_search"][${index1}]
    input   (//*[@placeholder="Search Material Issue Note"])[${index2}]   ${name}
    Click   (//*[@id="undefined_Material Issue Note_search"])[${index3}]

JW_Sorting
    [Arguments]   ${col_xpath1}   ${Col_Name}
    Wait For Elements State    ${JOBWORK_}    visible  timeout=60s
    #sorting PO page column
    log to console   ***** ${Col_Name} column Data List (Before Sorting) *****
    ${get_text_colData1}    Get Elements    ${col_xpath1}   #--get the PO column Data list
#    FOR    ${colData_List1}   IN   @{get_text_colData1}
    FOR    ${colData_List1}    IN    @{get_text_colData1}
    Log To Console   ✅ ${colData_List1.text}
    log   ✅ ${colData_List1.text}
    END
    #click on Column
    Wait For Elements State    //*[text()='${Col_Name}']    visible  timeout=60s
    Click   //*[text()='${Col_Name}']    #${SORTING CARET-UP}  #//span[text()='${Col_Name}']
    log to console  ***** ${Col_Name} column Data List (After Sorting) *****
    Wait For Elements State    ${col_xpath1}    visible  timeout=60s
    ${get_text_colData}    Get Elements    ${col_xpath1}
    FOR    ${colData_List}    IN    @{get_text_colData}
    Log To Console   ✅ ${colData_List.text}
    END

Select JW Vendor
    [Arguments]    ${name}
    Wait For Elements State   //*[@id="debit__form__recipient"]   visible  timeout=60s
    input  //*[@id="debit__form__recipient"]   ${name}
    click  //*[text()='${name}']

Select multiple_Item_For_bulk_Inward
    [Arguments]    ${name}
    Wait For Elements State   (//*[@type="search"])[2]   visible  timeout=60s
    Click    (//*[@type="search"])[2]
    input   (//*[@type="search"])[2]   ${name}
    click   (//*[text()="${name}"])[2]

Sort JW_Column
    [Arguments]    ${Column}    ${Label}
    JW_Sorting    ${Column}    ${Label}
    Reload

JBW_Searching
    [Arguments]    ${Col_name}  ${ItemName}   ${index1}   ${index2}   ${index3}
    log to console   ${Col_name} Column Data List
    ${get_text_colData}  Get Elements   ${Col_xpath}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console   ✅ ${Po_no_List.text}
    END
    Search Data in SearchBox    ${ItemName}   ${index1}   ${index2}   ${index3}
    log to console   ${Col_name} Column Data List (After Searching)
    ${get_text_colData}  Get Elements     ${Col_name}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console   ✅ ${Po_no_List.text}
    END

Search Randonmly In Delivery Date
    click    id:purchase_order_Delivery Date_search
    click    (//input[@placeholder='Start date'])[1]
#    click    //li[@class='ant-picker-preset']//span[text()='This Week']
    click    //li[@class='ant-picker-preset']//span[text()='Last Week']
    click    (//button[contains(@class,'ant-btn ant-btn-circle')])[2]
    sleep    1s

Search Data in SearchBox
    [Arguments]    ${ItemName}   ${index1}   ${index2}   ${index3}
    Click   (//*[@id="undefined_Item Details_search"])[${index1}]
    Fill Text    (//*[@class="ant-select-selection-search-input"])[${index2}]   ${ItemName}
    sleep   0.05s
    Click    (//*[@id="undefined_Item Details_search"])[${index3}]

Repair Request
    [Arguments]   ${ItemData1}  ${ItemData2}    ${JW_Vendor}
    Wait For Elements State   ${Subcontracting}   visible  timeout=60s
    Hover   ${Subcontracting}
    Sleep    2s
    Click   ${Repair Request}
    Sleep    2s
    Select into Dropdown   ${JOBWORK_VENDOR_INPUTBOX}   ${JW_Vendor}  #Mahindra
    Select Date   ${DELIVERY_DATE}   Today
    Sleep   1s
    Select_tItem_from_Dropdown    ${SELECT_ITEM_CODE}  ${ItemData1}
    ${randomfNum}=   Generate Random number  2
    input  ${ENTER_QTY}    ${randomfNum}
    sleep  1s
    click   ${JBW_SUBMIT}
    Wait For Elements State   ${SUCCESS_MSG}  visible  timeout=60s
    ${text}=   Browser.Get Text    ${SUCCESS_MSG}
    log  ✅ ${text}
    Hover  ${Subcontracting}
    Click  ${TRANSACTIONS}
    Sleep  1s
    ${Fist note}=   Get Text    (//tr[@class="ant-table-row ant-table-row-level-0"])[1]//td[@class="ant-table-cell ant-table-cell-fix-left ant-table-cell-fix-left-last"]
    Log  ✅ ${Fist note}
    Select TJobwork_Partner   ${JW_Vendor}     #Mahindra
    Search MRN No   ${Fist note}    1  1  2
    Click   ${Approve1}
    Wait For Elements State   //div[contains(text(),'MRN approved SuccesFully')]  visible  timeout=60s
    ${MRN Note}=    Browser.Get Text    //div[contains(text(),'MRN approved SuccesFully')]
    log   ✅ ${MRN Note}
    Wait For Elements State    //td[normalize-space(text())='${JW_Vendor}']   visible  timeout=60s
    Wait For Elements State    //td[normalize-space(text())='Repair']
    Click    //td[normalize-space(text())='Repair']
    Wait For Elements State    //*[normalize-space(text())='Shipment of ${JW_Vendor}']   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='Issued'])[1]   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='${Fist note}'])[2]   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='${ItemData1}'])[1]
    Wait For Elements State    (//*[normalize-space(text())='${randomfNum} kg'])[1]   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='${ItemData1}'])[2]   visible  timeout=60s
    Wait For Elements State    (//*[normalize-space(text())='${randomfNum} kg'])[2]   visible  timeout=60s
    Click   ${CANCELICON}
    RETURN    ${Fist note}

