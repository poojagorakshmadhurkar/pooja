*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    Browser
#Resource  ../../keywords.robot

*** Variables ***
@{i}  1  2  3  4     #change name here
#@{EditProductionFormData}  EditproductionForm14     #change name here

*** Test Cases ***
productionform creation
    login devsite
    open productionForm page
    sleep  1
    click  ${addNewproductionForm}
    ${randomproductiondata}=  generate random string  5-8  [LETTERS]
    input  ${title}  ${randomproductiondata}
    select option from dropdown using span  ${groupBy}  Item
    add labels  0
    click  ${addMoreLabel}
    select option from dropdown by inputting  //input[@id="rc_select_${i}[0]"]  Text
    add labels  1
    click  ${addMoreLabel}
    select option from dropdown by inputting  //input[@id="rc_select_${i}[1]"]  Number
    add labels  2
    select option from dropdown by inputting  //input[@id="rc_select_${i}[2]"]  Date
    click  ${Submit}
    i should see text on page  Custom Form added
    open productionForm page
    Reload
    productionForm should be added  ${randomproductiondata}
    edit productionForm  ${randomproductiondata}
