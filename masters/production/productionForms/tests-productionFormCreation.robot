*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

#*** Variables ***
#@{productionFormData}  productionForm13     #change name here
#@{EditProductionFormData}  EditproductionForm14     #change name here

*** Test Cases ***
tools creation
    Set Selenium Speed    0.1
    login
    select site  smart_factory
    open productionForm page
    click  ${addNewproductionForm}
    ${randomproductiondata}=  generate random string  5-8  [LETTERS]
    input  ${title}  ${randomproductiondata}
    select option from dropdown using span  ${groupBy}  Item
    add labels  0
    click  ${addMoreLabel}
    add labels  1
    click  ${addMoreLabel}
    add labels  2
    click  ${addMoreLabel}
    add labels  3
    click  ${addMoreLabel}
    add labels  4
    click  ${Submit}
    i should see text on page  Custom Form added
    open productionForm page
    reload page
    sleep  4
    productionForm should be added  ${randomproductiondata}
    edit productionForm  ${randomproductiondata}
