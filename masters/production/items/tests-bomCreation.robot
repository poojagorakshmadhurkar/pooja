*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Resource  ../../keywords.robot

*** Test Cases ***
manual bom creation
    login
    select site  Smart Factory
    open item page
   # click  ${rowsPerPage}
    create bom  ABC_FG
    add item to BOM  1  ABC_WIP  2
    add item to BOM  2  HARD_PVC  10
    click  ${submitBom}


#  *** Test Cases ***
#manual bom creation
#    login
#    select site  Smart Factory
#    open items page
#    click  (//span[text() = "Test10"]/../../../../../../../../../../td/div/button)[1]
#    click  ${addBom}
#    press keys  //input[@id="bom__quantity"]/..  CTRL+A  BACKSPACE  1.5
#    sleep  1
#    input  //input[@id="rawMaterialBom__selectItem"]  ItemWIP-7
#    press keys  //input[@id="rawMaterialBom__selectItem"]  RETURN
#    sleep  1
#    input  //input[@id="rawMaterial__quantity"]  6
#    press keys  //input[@id="rawMaterial__quantity"]  RETURN
#    sleep  2
#    input  (//input[@id="rawMaterialBom__selectItem"])[2]  New_RM01
#    press keys  (//input[@id="rawMaterialBom__selectItem"])[2]  RETURN
#    sleep  1
#    input  (//input[@id="rawMaterial__quantity"])[2]  3
#    press keys  (//input[@id="rawMaterial__quantity"])[2]  RETURN
#    sleep  2
#    click  ${submitBom}
#    click  //span[text()="ItemWIP-7"]/../../../../../../../../button/text[text() = "BOM"]/..
#    sleep  1
#    press keys  //input[@id="bom__quantity"]/..  CTRL+A  BACKSPACE  1.5
#    sleep  1
#    input  (//input[@id="rawMaterialBom__selectItem"])  123
#    press keys  (//input[@id="rawMaterialBom__selectItem"])  RETURN
#    sleep  2
#    input  //input[@id="rawMaterial__quantity"]  6
#    press keys  //input[@id="rawMaterial__quantity"]  RETURN
#    sleep  1
#    click  ${submitBom}


