*** Settings ***
#Library  SeleniumLibrary
Library  String
Library  Collections
Library  DateTime
Resource  ../keywords.robot
Resource  ../orders/Salesorder/variables.robot
Resource  ../variables.robot
Resource  ../orders/Salesorder/keywords.robot
Resource   ./variables.robot
Library  Browser






*** Keywords ***


open dispatch order page
    click  ${dispatchorder}
    click  ${dispatchschedulepage}







Create salesorder
    [Arguments]  ${customername}  ${itemData1}
    Open Order Tracker Page
    sleep  1
    click  ${newSO}
#    Wait For Elements State        //span[text()="Add New SO"]   visible   timeout=60s
    Select Customer    ${customername}[0]
    ${randomrefNumber}=    Generate Random String    5-10    [NUMBERS]
    Input    ${refNumber}    ${randomrefNumber}
    Delivery Date Entry
    set ith item in so  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    ${order_info}    Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    RETURN  ${order_number}


set ith item in Dispatch
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    press keys  //input[@id="debit__details__${i}__sku"]/../../span[2]  Control+A
    press keys  //input[@id="debit__details__${i}__sku"]/../../span[2]   Backspace
    Wait For Elements State      //*[text() = "${recievedName}"]  visible   timeout=60s
    press keys  //input[@id="debit__details__0__sku"]  Enter
    press keys    //input[@id="${i}__quantity"]  Control+A
    press keys    //input[@id="${i}__quantity"]      Backspace


set ith item in Dispatch only quantity
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
#    press keys  //input[@id="debit__details__${i}__sku"]/../../span[2]  CTRL+A  BACKSPACE  ${recievedName}
    Wait For Elements State      //*[text() = "${recievedName}"]  visible   timeout=60
#    press keys  //input[@id="debit__details__0__sku"]  ENTER
    press keys    //input[@id="${i}__quantity"]  Control+A
    press keys    //input[@id="${i}__quantity"]   Backspace
    Fill Text    //input[@id="${i}__quantity"]     ${recievedQuantity}


delivery date entry in dispatch
    ${today1}    Get Current Date  result_format=%Y-%m-%d
    click  (//span[text() = "Delivery Date *"]/../../div[2]/div/input)[1]
    click  //td[@title="${today1}"]
    RETURN  ${today1}

Get Dispatch Number
#    [Arguments]    ${message_xpath}
    ${message}=    Get Text    //div[contains(text(), 'Dispatch DO') and contains(text(), 'has been created')]

    ${start}=    Evaluate    "${message}".find("Dispatch DO-") + len("Dispatch ")
    ${end}=    Evaluate    "${message}".find(" has been created!", ${start})
    ${dispatch_number}=    Evaluate    "${message}"[${start}:${end}]
    RETURN  ${dispatch_number}


Open Event monthwise Drawer
    [Arguments]    ${dispatchordernumber}  ${customername}  ${Sonumber}
    Using search filters of SO  ${Sonumber}
    Click    //p[text()='${customername}[0]']/ancestor::div[@id='${dispatchordernumber}']

Open Event Daywise Drawer
    [Arguments]   ${customername}   ${dispatchordernumber}
#    Execute JavaScript    arguments[0].scrollIntoView(true);
#    Execute JavaScript    window.scrollBy(0, 500)
#    Scroll Element Into View    //p[contains(text(),'${customername}')]//ancestor::div[@id='${dispatchordernumber}']
     click   //div[@aria-label='Select View']
     click  (//li[@aria-label='Select View Day'])[1]
    Click   //p[text()="${customername}[0]"]/ancestor::div[@id='${dispatchordernumber}']


set ith item only quantity for outward
    [Arguments]   ${i}  ${newItemName}  ${newItemQuantity}
#    press keys  //input[@id = "debit__details__${i}__sku"]  CTRL+A  BACKSPACE  ${newItemName}
#    sleep  1
#    press keys  //input[@id = "debit__details__${i}__sku"]  ENTER
    press keys  (//input[@id = "debit__details__${i}__quantity"])  Control+A
    press keys  (//input[@id = "debit__details__${i}__quantity"])   Backspace
    Fill Text    (//input[@id = "debit__details__${i}__quantity"])  ${newItemQuantity}
    sleep  1



Select Day Option from dropdown
    Reload
    click   //div[@class="sx__view-selection"]
    click   //div[@class="sx__view-selection"]//ul//li[text()="Day"]

Using search filters of SO
    [Arguments]   ${ordernumber}
    click   //div[text()="Show Filters"]
    press keys  //input[@id="debit__form__sales_order"]  Control+A
    press keys  //input[@id="debit__form__sales_order"]   Backspace
    Fill text     //input[@id="debit__form__sales_order"]   ${ordernumber}
    press keys  //input[@id="debit__form__sales_order"]  Enter
    click  //span[text()="Dispatch Schedule"]
    sleep  1

Select Option from FrequencyDropdown
    [Arguments]   ${frequencytype}
    click  //span[text()="Frequency *"]/../../div[2]
    click  //div[text()="${frequencytype}"]



Delivery Date Entry with 7 days gap

    ${start_date}=    Get Current Date    result_format=%Y-%m-%d
    ${end_date}=      Get Current Date    result_format=%Y-%m-%d    increment=3d
    # Select Start Date
    Click  (//span[text() = "Delivery Date *"]/../../div[2]/div/input)[1]
    Click  //td[@title="${start_date}"]
    # Select End Date
    Click  (//input[@placeholder="End date"])[1]
    Click  //td[@title="${end_date}"]
    # Return Start Date, Dates Between, and End Date
    RETURN    ${start_date}   ${end_date}


Add Days To Date
    [Arguments]    ${date}    ${days}    ${result_format}=%Y-%m-%d
    ${new_date}=    Add Time To Date    ${date}    ${days}
    ${formatted_date}=    Convert Date    ${new_date}    ${result_format}
    RETURN    ${formatted_date}


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


