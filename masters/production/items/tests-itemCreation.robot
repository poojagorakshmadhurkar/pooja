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

*** Test Cases ***
open item page
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open item page
    click  ${newIcon}
    sleep  2
#    ${randomItemCode}=  generate random string  5-8  [LETTERS]
    input  ${itemCode}  ${itemData}[0]
    ${randomItemName}=  generate random string  5-8  [LETTERS]
    input  ${itemName}  ${randomItemName}
    select randomly from dropdown  ${itemgroup}  item__itemGroup_list  2
#    select option from dropdown using span  ${itemgroup}  Compounds
    click  ${Submit}
    i should see text on page  Item added
    click  ${backButton}
    reload page
    sleep  2
    item should be added  ${itemData}[0]

editing item
    reload page
    sleep  3
    edit item  ${itemData}[0]

deleting item
    reload page
    sleep  5
    delete item  ${editItemData}[0]
