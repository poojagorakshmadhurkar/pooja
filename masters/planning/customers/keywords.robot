*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Library  BuiltIn
Library  ../customkeyword.py


*** Variables ***
#${CustomerData2}=  Generate Random Customer Name      #change name

*** Keywords ***
open customer page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersCustomers}
    reload page

customer should be added
    [Arguments]  ${customerName}
    click  (//*[name()='svg'][@id='customers_Name_search'])[1]
    sleep  3
    press keys  (//input[@placeholder='Search Name'])[1]  CTRL+A  BACKSPACE
    input  (//input[@placeholder='Search Name'])[1]  ${customerName}
    press keys  (//input[@placeholder='Search Name'])[1]  ENTER
    wait until page contains element  //span[text() = "${customerName}"]  timeout=10s
#
#edit customer
#    [Arguments]  ${oldCustomerName}  ${newCustomerName}  ${newTypeOfPartner}  ${newCustomerEmail}  ${newCustomerAddress}  ${newCustomerCountry}  ${newCustomerState}  ${newCustomerCity}
#    click  ((//th/span[text() = "${oldCustomerName}"]/../../td)/div/button)[1]
#    wait until element is visible  ${customerName}
#    press keys  ${customerName}  CTRL+A  BACKSPACE  ${newCustomerName}
#    select option from dropdown  ${typeOfPartner}  ${newTypeOfPartner}
#    press keys  ${customerEmail}  CTRL+A  BACKSPACE  ${newCustomerEmail}
#    press keys  ${customerAddress}  CTRL+A  BACKSPACE  ${newCustomerAddress}
#    select option from dropdown  ${customerCountry}  ${newCustomerCountry}
#    select option from dropdown  ${customerState}  ${newCustomerState}
#    select option from dropdown  ${customerCity}  ${newCustomerCity}
#    click  ${savePartner}

edit random generated customer
    [Arguments]  ${oldRandomCustomerName}  ${CustomerData2}
    click  //span[text() = "${oldRandomCustomerName}"]/../span/span/span/a
    click  //button[text() = "Edit"][2]
#    ${randomCustomerName}=  generate random string  5-10  [LETTERS]
    press keys  ${customerName}  CTRL+A  BACKSPACE  ${CustomerData2}
#    select randomly from dropdown  ${typeOfPartner}
    ${randomCustomerEmail}=  generate random string  5-10  [LETTERS]
    press keys  ${customerEmail}  CTRL+A  BACKSPACE  ${randomCustomerEmail}
    ${randomCustomerAddress}=  generate random string  5-15  [LETTERS]
    press keys  ${customerAddress}  CTRL+A  BACKSPACE  ${randomCustomerAddress}
    Select Option from Dropdown DIV value  ${customerCountryXpath}  Albania
    select option from dropdown DIV value  ${customerStateXpath}  Berat County
#    select option from dropdown DIV value  ${customerCityXpath}  Baksa
    ${randomGSTN}=  generate random string  10-15  [NUMBERS]
    press keys  ${customerGSTN}  CTRL+A  BACKSPACE  ${randomGSTN}
#    ${stateXpathCount}=  get element count  ${customerState}
#    IF  ${stateXpathCount} == 1
#        select randomly from dropdown  ${customerState}
#    END
#    ${cityXpathCount}=  get element count  ${customerCity}
#    IF  ${cityXpathCount} == 1
#        select randomly from dropdown  ${customerCity}
#    END
    click  ${Submit}
    i should see text on page  Partner edited
    open customer page
    reload page
    wait until page contains element  //button[text() = "NEW"]  20
    customer should be added  ${CustomerData2}

delete customer
    [Arguments]  ${customerName}
    click  //span[text() = "${customerName}"]/../../../../../../td[8]//button
    click  ${deactivate_customer}

customer deletion check
    [Arguments]  ${customerName}
    wait until element is not visible  //table/tbody/tr/th/span[text() = "${customerName}"]
    element should not be visible  //table/tbody/tr/th/span[text() = "${customerName}"]

#edit customer randomly
#    wait until element is visible  //tr
#    ${count}=  get element count  //tr
#    ${row}=  evaluate  random.sample(range(2, ${count}+1), 1)  random
#    click  ((//tr)${row}/td/div/button)[1]
#    wait until element is visible  ${customerName}
#    ${randomCustomerName}=  generate random string  5-10  [NUMBERS]
#    press keys  ${customerName}  CTRL+A  BACKSPACE  ${randomCustomerName}
#    select randomly from dropdown  ${typeOfPartner}
#    ${randomCustomerEmail}=  generate random string  5-10  [LETTERS][NUMBERS]
#    press keys  ${customerEmail}  CTRL+A  BACKSPACE  ${randomCustomerEmail}
#    ${randomCustomerAddress}=  generate random string  5-10  [LETTERS][NUMBERS]
#    press keys  ${customerAddress}  CTRL+A  BACKSPACE  ${randomCustomerAddress}
#    select randomly from dropdown  ${customerCountry}
#    ${stateXpathCount}=  get element count  ${customerState}
#    IF  ${stateXpathCount} == 1
#        select randomly from dropdown  ${customerState}
#    END
#    ${cityXpathCount}=  get element count  ${customerCity}
#    IF  ${cityXpathCount} == 1
#        select randomly from dropdown  ${customerCity}
#    END
#    click  ${savePartner}
#    [Return]  ${randomCustomerName}



delete customer randomly
    wait until element is visible  //tr
    ${count}=  get element count  //tr
    ${row}=  evaluate  random.sample(range(2, ${count}+1), 1)  random
    ${deletedCustomerName}=  get text  (//tr)${row}/th/span
    click  ((//tr)${row}/td/div/button)[2]
    click  ${deactivate_customer}
    [Return]  ${deletedCustomerName}

Select Option from Dropdown DIV value
    [Arguments]  ${dropdownXpath}  ${option}
    Click  ${dropdownXpath}
    Wait Until Element Is Visible  xpath=//div[@class="ant-select-item-option-content" and text()="${option}"]  timeout=10s
    Scroll Element Into View  xpath=//div[@class="ant-select-item-option-content" and text()="${option}"]
    Click  xpath=//div[@class="ant-select-item-option-content" and text()="${option}"]

Generate Random Customer Name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    [Return]  ${random_customer_name}

Extract Customer ID
    [Arguments]  ${text}
    ${pattern}=  Set Variable  CUST[0-9]+
    ${customer_id}=  Get Regexp Matches  ${text}  ${pattern}
    ${customer_id}=  Set Variable  ${customer_id[0]}
    [Return]  ${customer_id}