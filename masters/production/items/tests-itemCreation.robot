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
    select option from dropdown by inputting   //input[@id='item__itemGroup']  Itemgroup1
#    select option from dropdown using span  ${itemgroup}  Compounds
    click  ${Submit}
    i should see text on page  Item added
    click  (//button[@aria-label='back-button'])[2]
    Reload
    Wait For Elements State    (//div[@class='ant-spin-container'])[1]  hidden    timeout=60s
    item should be added  ${randomItemName}
    edit item  ${randomItemCode}



