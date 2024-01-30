*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot



*** Variables ***
@{CustomerData2}  Newpooj8634637      #change name

*** Keywords ***
open customer page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersCustomers}

customer should be added

    [Arguments]  ${customerName}
    click  //*[name()='path' and contains(@d,'M10 18h4v-')]
    sleep  3
    press keys  //input[@id='name']  CTRL+A  BACKSPACE
    input  //input[@id='name']  ${customerName}
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
    [Arguments]  ${oldRandomCustomerName}
    click  //span[text() = "${oldRandomCustomerName}"]/../span/span/span/a
    click  ${Edit}
#    ${randomCustomerName}=  generate random string  5-10  [LETTERS]
    press keys  ${customerName}  CTRL+A  BACKSPACE  ${CustomerData2}[0]
#    select randomly from dropdown  ${typeOfPartner}
    ${randomCustomerEmail}=  generate random string  5-10  [LETTERS]
    press keys  ${customerEmail}  CTRL+A  BACKSPACE  ${randomCustomerEmail}
    ${randomCustomerAddress}=  generate random string  5-15  [LETTERS]
    press keys  ${customerAddress}  CTRL+A  BACKSPACE  ${randomCustomerAddress}
    select option from dropdown using span  ${customerCountry}  India
    select option from dropdown using span  ${customerState}  Assam
    select option from dropdown using span  ${customerCity}  Baksa
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
    wait until page contains element  //button[@id='Add New Customer']  20
    customer should be added  ${CustomerData2}[0]

delete customer
    [Arguments]  ${customerName}
    click  //span[text() = "${customerName}"]/../../../../../../../td[7]/div/button
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


#robot .\Suite\masters\planning\customers\tests-customerCreation.robot