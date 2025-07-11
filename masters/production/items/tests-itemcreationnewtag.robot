*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library    Browser

#*** Variables ***
#@{itemData}  item-11  pencer10
#@{editItemData}  item11  censor11
*** Variables ***
${DROPDOWN_XPATH}    //span[text()="size "]/../../../div[2]//input

*** Test Cases ***
open item page
    login devsite
    open item page
    sleep  1
    click  ${newIcon}
    ${randomItemCode}=  generate random string  5-8  [LETTERS]
    input  ${itemCode}  ${randomItemCode}
    ${randomItemName}=  generate random string  5-8  [LETTERS]
    input  ${itemName}  ${randomItemName}
    select option from dropdown by inputting   //input[@id='item__itemGroup']  Itemgroup1  # Type in the input field
    #click  //span[text()="size "]/../../../div[2]//input
    ${random_number}=  Generate Random 3-Digit Number
    input  ${DROPDOWN_XPATH}  ${random_number}
    click  ${addattributebutton}
    click  (//button[@id="undefined__deactivate_btn"])[6]
    i should see text on page    Tag Created Successfully
    Wait For Elements State        //span[text()="size "]/../../../div[2]//input/../../span[2][@title="${random_number}"]
    click  ${Submit}
    i should see text on page  Item added
    click    (//button[@aria-label='back-button'])[2]
    Reload
    Wait For Elements State    (//div[@class='ant-spin-container'])[1]  hidden    timeout=60s
    item should be added  ${randomItemName}
    edit item  ${randomItemCode}


