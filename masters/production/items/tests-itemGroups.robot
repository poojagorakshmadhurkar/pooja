*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

*** Variables ***
#@{itemGroupData}  ItemGroupp15
#@{edititemGroupData}  editItemGroupp15  Raw Material  gram

${DROPDOWN_OPTION}  xpath=(//div[contains(@class, 'ant-select-item')])[${INDEX}]
${INDEX}            2

*** Test Cases ***
itemGroup creation
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
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
    sleep  10
    fill attribute  0  Length  Itemgroup1
    click  ${addAttribute}
#    fill attribute with new att value tag  1  Breadth  POIUYTT
#    click  ${addAttribute}
    fill attribute  1  Heigth  FGGROUP4
    click  ${setSelfTag}
    click  ${setNomenclature}
    input  ${codePrefix}  A
    input  ${namePrefix}  B
    Select Value From Dropdown By Index    ${nameSeparator}    ${DROPDOWN_OPTION}
    input  ${namesequence}  Length
    press keys   ${namesequence}  ENTER
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






























