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
    login
    select site  smart_factory
    open productionForm page
    click  ${addNewproductionForm}
    input  ${title}  ${productionFormData}[0]
    select option from dropdown using list  ${groupBy}  Item
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
    productionForm should be added  ${productionFormData}[0]

editing productionForm
    edit productionForm  ${productionFormData}[0]

delete edited productionForm
    delete productionForm  ${EditProductionFormData}[0]