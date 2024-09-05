*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

#*** Variables ***
#@{itemData}  item-11  pencer10
#@{editItemData}  item11  censor11
*** Variables ***
${DROPDOWN_XPATH}    //span[text()="size "]/../../../div[2]//input

*** Test Cases ***
open item page
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open item page
    click  ${newIcon}
    sleep  2
    ${randomItemCode}=  generate random string  5-8  [LETTERS]
    input  ${itemCode}  ${randomItemCode}
    ${randomItemName}=  generate random string  5-8  [LETTERS]
    input  ${itemName}  ${randomItemName}
    select option from dropdown using span  ${itemgroup}  AI_AI_A
    click  //span[text()="size "]/../../../div[2]//input
    ${random_number}=  Generate Random 3-Digit Number
    input  ${DROPDOWN_XPATH}  ${random_number}
    click  ${addattributebutton}
    click  (//button[@id="undefined__deactivate_btn"])[6]
    i should see text on page    Tag Created Successfully
    wait until element is visible    //span[text()="size "]/../../../div[2]//input/../../span[2][@title="${random_number}"]
    sleep  2
    click  ${Submit}
    i should see text on page  Item added
    click  ${backButton}
    reload page
    sleep  2
    item should be added  ${randomItemName}
    sleep  3
    edit item  ${randomItemCode}


