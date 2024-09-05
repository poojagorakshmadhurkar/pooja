*** Settings ***
Library  SeleniumLibrary
Library  String
Library  Collections
Library  DateTime
Resource  ../keywords.robot
Resource  ../planning/Salesorder/variables.robot
Resource  ../variables.robot
Resource  ../planning/Salesorder/keywords.robot
Resource   ./variables.robot
Library    Regexp





*** Keywords ***


open dispatch order page
    click  ${dispatchorder}
    sleep  2
    click  ${dispatchschedulepage}
    sleep  2






Create salesorder
    [Arguments]  ${customername}  ${itemData1}
    Open Order Tracker Page
    click  ${newSO}
    Wait Until Page Contains Element    //span[text()="Add New SO"]    timeout=10s
    Select Customer    ${customername}[0]
    ${randomrefNumber}=    Generate Random String    5-10    [NUMBERS]
    Input    ${refNumber}    ${randomrefNumber}
    Delivery Date Entry
    set ith item in so  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    sleep  2
    ${order_info}    Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    RETURN  ${order_number}


set ith item in Dispatch
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    press keys  //input[@id="debit__details__${i}__sku"]/../../span[2]  CTRL+A  BACKSPACE  ${recievedName}
    Sleep  1
    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  20
    press keys  //input[@id="debit__details__0__sku"]  ENTER
    sleep  1
    press keys    //input[@id="${i}__quantity"]  CTRL+A  BACKSPACE  ${recievedQuantity}
    sleep  1

set ith item in Dispatch only quantity
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
#    press keys  //input[@id="debit__details__${i}__sku"]/../../span[2]  CTRL+A  BACKSPACE  ${recievedName}
    Sleep  1
    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  20
#    press keys  //input[@id="debit__details__0__sku"]  ENTER
    sleep  1
    press keys    //input[@id="${i}__quantity"]  CTRL+A  BACKSPACE  ${recievedQuantity}
    sleep  1

delivery date entry in dispatch
    sleep  1
    ${today1}    Get Current Date  result_format=%Y-%m-%d
    click  (//span[text() = "Delivery Date *"]/../../div[2]/div/input)[1]
    click  //td[@title="${today1}"]
    RETURN  ${today1}

Get Dispatch Number
#    [Arguments]    ${message_xpath}
    ${message}=    Get Text    //div[contains(text(), 'Dispatch DO-') and contains(text(), 'has been created')]
    ${start}=    Evaluate    "${message}".find("Dispatch DO-") + len("Dispatch ")
    ${end}=    Evaluate    "${message}".find(" has been created!", ${start})
    ${dispatch_number}=    Evaluate    "${message}"[${start}:${end}]
    RETURN  ${dispatch_number}


Open Event monthwise Drawer
    [Arguments]    ${dispatchordernumber}  ${customername}  ${Sonumber}
    Using search filters of SO  ${Sonumber}
    sleep  1
    Click Element    //p[contains(text(),'${customername}[0]')]/ancestor::div[@id='${dispatchordernumber}']

Open Event Daywise Drawer
    [Arguments]   ${customername}   ${dispatchordernumber}
#    Execute JavaScript    arguments[0].scrollIntoView(true);
#    Execute JavaScript    window.scrollBy(0, 500)
#    Scroll Element Into View    //p[contains(text(),'${customername}')]//ancestor::div[@id='${dispatchordernumber}']
    Sleep    2s
    Click Element    //p[contains(text(),'${customername}[0]')]/ancestor::div[@id='${dispatchordernumber}']


set ith item only quantity for outward
    [Arguments]   ${i}  ${newItemName}  ${newItemQuantity}
#    press keys  //input[@id = "debit__details__${i}__sku"]  CTRL+A  BACKSPACE  ${newItemName}
#    sleep  1
#    press keys  //input[@id = "debit__details__${i}__sku"]  ENTER
    sleep  1
    press keys  (//input[@id = "debit__details__${i}__quantity"])  CTRL+A  BACKSPACE  ${newItemQuantity}
    sleep  1


Select Day Option from dropdown
    reload page
    sleep  2
    click   //div[@class="sx__view-selection"]
    sleep  1
    click   //div[@class="sx__view-selection"]//ul//li[text()="Day"]

Using search filters of SO
    [Arguments]   ${ordernumber}
    sleep  1
    click   //div[text()="Show Filters"]
    press keys  //input[@id="debit__form__sales_order"]  CTRL+A  BACKSPACE  ${ordernumber}
    press keys  //input[@id="debit__form__sales_order"]  ENTER
    sleep  1
    click  //span[text()="Dispatch Schedule"]

Select Option from FrequencyDropdown
    [Arguments]   ${frequencytype}
    click  //span[text()="Frequency *"]/../../div[2]
    sleep  1
    click  //div[text()="${frequencytype}"]



Delivery Date Entry with 7 days gap
    Sleep  1
    ${start_date}=    Get Current Date    result_format=%Y-%m-%d
    ${end_date}=      Get Current Date    result_format=%Y-%m-%d    increment=3d
    # Select Start Date
    Click  (//span[text() = "Delivery Date *"]/../../div[2]/div/input)[1]
    Click  //td[@title="${start_date}"]
    # Select End Date
    Click  (//input[@placeholder="End date"])[1]
    Click  //td[@title="${end_date}"]
    # Return Start Date, Dates Between, and End Date
    [Return]    ${start_date}   ${end_date}


Add Days To Date
    [Arguments]    ${date}    ${days}    ${result_format}=%Y-%m-%d
    ${new_date}=    Add Time To Date    ${date}    ${days}
    ${formatted_date}=    Convert Date    ${new_date}    ${result_format}
    [Return]    ${formatted_date}


Delivery Date Entry mothly basis
    Sleep  1
    ${start_date}=    Get Current Date    result_format=%Y-%m-%d
    ${end_date}=      Add Time    ${start_date}    1 month    result_format=%Y-%m-%d

    # Selecting the start date
    Click  (//span[text() = "Delivery Date *"]/../../div[2]/div/input)[1]
    Click  //td[@title="${start_date}"]

    # Selecting the end date
    Click  (//input[@placeholder="End date"])[1]
    Click  //td[@title="${end_date}"]

    Log  Start Date: ${start_date} | End Date: ${end_date}


Calculate And Verify Dispatch textperdispatch
    [Arguments]    ${item_quantity}    ${days_gap}
    # Calculate dispatch per day
    ${dispatch_per_day}=    Evaluate    ${item_quantity} / ${days_gap}
    # Convert dispatch per day to integer
    ${dispatch_per_day_int}=    Evaluate    int(${dispatch_per_day})
    # Format the expected text with integer value
    ${expected_text}=    Evaluate    '{} Per Dispatch'.format(${dispatch_per_day_int})
    # Get the text from the element
    ${dispatch_text}=    Get Text    //div[text()=" Per Dispatch"]
    # Extract the number from the text
    ${dispatch_number}=    Evaluate    int(${dispatch_text.split()[0]})
    # Log both values for debugging
    Log    Expected Text: ${expected_text}
    Log    Dispatch Number: ${dispatch_number}
    # Verify if the extracted number matches the expected value
    Should Be Equal As Numbers    ${dispatch_number}    ${dispatch_per_day_int}


