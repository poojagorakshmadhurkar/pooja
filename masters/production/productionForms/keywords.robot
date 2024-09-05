*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Keywords ***
open productionForm page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersProductionForms}

productionForm should be added
    [Arguments]  ${productionFormName}
    click  //button[@id='customForms__filterBtn']
    sleep  2
    press keys  //input[@id='title']  CTRL+A  BACKSPACE
    sleep  2
    input  //input[@id='title']   ${productionFormName}
    wait until page contains element  //a[text() = "${productionFormName}"]

add labels
    [Arguments]  ${i}
    press keys  //input[@id='customForm__keys_${i}']  CTRL+A  BACKSPACE
    ${randomLabels}=  generate random string  5-10  [LETTERS]
    input  //input[@id='customForm__keys_${i}']  ${randomLabels}
    sleep  2

#edit added labels
#    [Arguments]  ${i}
#    press keys  //input[@id='customForm__keys_${i}']  CTRL+A  BACKSPACE
#    add labels  0

edit productionForm
    [Arguments]  ${oldProductionForm}
    click  //a[text() = "${oldProductionForm}"]
    click  ${Edit}
    sleep  1
    ${randomproductionnewdata}=  generate random string  5-8  [LETTERS]
    Press keys  ${title}  CTRL+A  BACKSPACE  ${randomproductionnewdata}
    add labels  0
    add labels  1
    add labels  2
    add labels  3
    add labels  4
    click  ${Submit}
    i should see text on page  Custom Form edited
    open productionForm page
    reload page
    sleep  3
    productionForm should be added  ${randomproductionnewdata}
    click  //a[text() = "${randomproductionnewdata}"]/../../../../../../../../../../td[3]/div/button[@id = "customForms__Deactivate"]
    click  ${deactivate_productionForm}
    i should see text on page  Custom Form deactivated successfully

