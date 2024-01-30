*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemGroupData}  ItemGroupp15
@{edititemGroupData}  editItemGroupp15  Raw Material  gram

*** Test Cases ***
itemGroup creation
    login
    select site  smart_factory
    open item page
    click  //span[text() = "This is a testing Site"]
    sleep  1
    click  ${itemGroupHeader}
    sleep  1
    click  ${newIcon}
#    ${randomitemGroupname}=  generate random string  5-10  [LETTERS]
    input  ${itemGroupname}  ${itemGroupData}[0]
    select option from dropdown using list  ${itemType}  Raw Material
    select option from dropdown using list  ${units}  gram
#    select option from dropdown using span  ${sites}  Haridwar Unit
    click  ${addAttribute}
    fill attribute  0  Length  Bagpack
    click  ${addAttribute}
#    fill attribute with new att value tag  1  Breadth  POIUYTT
#    click  ${addAttribute}
    fill attribute  1  Heigth  Compounds
    click  ${setSelfTag}
    click  ${setNomenclature}
    input  ${codePrefix}  A
    input  ${namePrefix}  B
    input  ${nameSeparator}  %
    click  ${Submit}
    i should see text on page  Item Group added
    click  ${back}
    reload page
    sleep  4
    itemGroup should be added  ${itemGroupData}[0]

editing itemGroup
    edit itemGroup  ${itemGroupData}[0]

deleting itemGroup
    delete itemGroup  ${edititemGroupData}[0]
