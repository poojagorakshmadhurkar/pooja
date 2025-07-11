*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    Browser


*** Variables ***
@{l}  2  4  5



*** Keywords ***
open productionForm page
    click  ${mastersDropdown}
    Reload
    Wait For Elements State  ${mastersProductionForms}
    click  ${mastersProductionForms}


productionForm should be added
    [Arguments]  ${productionFormName}
    click  (//*[name()='svg'][@id='undefined_Title_search'])[1]
    Click      //input[@placeholder='Search Title']
    input  //input[@placeholder='Search Title']   ${productionFormName}
    browser.press keys  //input[@placeholder='Search Title']  Enter
    Wait For Elements State      //a[text() = "${productionFormName}"]

add labels
    [Arguments]  ${i}
    click  //input[@id='customForm__keys_${i}']
    ${randomLabels}=  generate random string  5-10  [LETTERS]
    input  //input[@id='customForm__keys_${i}']  ${randomLabels}


#edit added labels
#    [Arguments]  ${i}
#    press keys  //input[@id='customForm__keys_${i}']  CTRL+A  BACKSPACE
#    add labels  0

edit productionForm
    [Arguments]  ${oldProductionForm}
    click  //a[text() = "${oldProductionForm}"]
    click  ${productioneditbuton}
    ${randomproductionnewdata}=  generate random string  5-8  [LETTERS]
    Fill Text      ${title}   ${randomproductionnewdata}
    add labels  0
    select option from dropdown by inputting  //input[@id="rc_select_${l}[0]"]  Number
    add labels  1
    select option from dropdown by inputting  //input[@id="rc_select_${l}[1]"]  Date
    add labels  2
    select option from dropdown by inputting  //input[@id="rc_select_${l}[2]"]  Text
    click  ${Submit}
    i should see text on page  Custom Form edited
    open productionForm page
    Reload
    productionForm should be added  ${randomproductionnewdata}
    click  //a[text() = "${randomproductionnewdata}"]/../../../../../../../../../td[4]//button
    click  ${deactivate_productionForm}
    i should see text on page  Custom Form deactivated successfully

