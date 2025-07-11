*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library    Browser

*** Variables ***
#@{itemGroupData}  ItemGroupp15
#@{edititemGroupData}  editItemGroupp15  Raw Material  gram

${DROPDOWN_OPTION}  xpath=(//div[contains(@class, 'ant-select-item')])[${INDEX}]
${INDEX}            2

*** Test Cases ***
itemGroup creation
    login devsite
    open item page
    click  //span[text() = "This is a testing Site"]
    click  ${itemGroupHeader}
    sleep  1
    click  ${newIcon}
    ${randomitemGroupname}=  generate random string  5-10  [LETTERS]
    Fill Text    ${itemGroupname}  ${randomitemGroupname}
    select option from dropdown using list  ${itemType}  RM
    select option from dropdown using list  ${units}  gram
#    select option from dropdown using span  ${sites}  Haridwar Unit
    click  ${addAttribute}
    fill attribute  0  Length  Itemgroup1
    click  ${addAttribute}
#    fill attribute with new att value tag  1  Breadth  POIUYTT
#    click  ${addAttribute}
    fill attribute  1  Heigth  FGGROUP4
    click  ${setSelfTag}
    click  ${setNomenclature}
    input  ${codePrefix}  A
    input  ${namePrefix}  B
    select option from dropdown by inputting    //input[@id='name_seprator']    (/) Slash
    input  ${namesequence}  Length
    browser.press keys   ${namesequence}  Enter
    click  ${Submit}
    i should see text on page  Item Group added
    click  ${back}
    Reload
    sleep  2
    itemGroup should be added  ${randomitemGroupname}
    edit itemGroup  ${randomitemGroupname}































