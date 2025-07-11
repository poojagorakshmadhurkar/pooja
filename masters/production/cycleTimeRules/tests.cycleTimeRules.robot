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
@{cycleTimeRulesData1}  WIP MACHINE  Bottle(FG)  WIRING  13
@{editCTR}  30
#Format MAchinegroup --item group tag-- process---time--edited time

*** Test Cases ***
open cycleTimeRules page
    login devsite
    open cycleTimeRules page
    sleep  1
    click  ${addNewRule}
#    select site  testingsiteautomation
#    select option from dropdown by inputting  ${machineGroup}/span[2]  ${cycleTimeRulesData1}[0]
    click  (//input[@type="search"])[2]/../../span[2]
    input  (//input[@type="search"])[2]  ${cycleTimeRulesData1}[0]
    browser.Press Keys     (//input[@type="search"])[2]  Enter
#    wait until element is visible  //span[text() = "${cycleTimeRulesData1}[0]"]  30
    click  //span[text() = "${cycleTimeRulesData1}[0]"]/..
    click  ${itemGrouptags}/span[1]
    input  ${itemGrouptags}/span[1]/input  ${cycleTimeRulesData1}[1]
    browser.Press Keys     ${itemGrouptags}/span[1]/input  Enter
#    wait until element is visible  //span[text() = "${cycleTimeRulesData1}[1]"]  15
    click  //span[text() = "${cycleTimeRulesData1}[1]"]/..
#    select option from dropdown by inputting  ${itemGrouptags}/span[2]  ${cycleTimeRulesData1}[1]
#    select option from dropdown using div  ${process}  ${cycleTimeRulesData1}[2]
    input  ${process}  ${cycleTimeRulesData1}[2]
    browser.Press Keys     ${process}  Enter
    click  ${Seconds}
    input  ${Seconds}  ${cycleTimeRulesData1}[3]
    browser.Press Keys     ${Seconds}  Enter
    click  ${Submit}
#    i should see text on page  Cycle Time Rule added
#    open cycleTimeRules page
#    reload page
#    cycleTimeRules should be added  ${cycleTimeRulesData1}[0]  ${cycleTimeRulesData1}[1]  ${cycleTimeRulesData1}[2]  ${cycleTimeRulesData1}[3]
     #    sleep  2
#    WHILE   wait until element is visible  //span[contains(text(), "${cycleTimeRulesData1}[0]")]/../../td[contains(text(), "${cycleTimeRulesData1}[1]")]/../td[contains(text(), "${cycleTimeRulesData1}")]  limit=100
#      press keys  //tbody/../..  ARROW_DOWN
#    END
#    Execute JavaScript  window.scrollTo(0,2500)
#    sleep  3
#    cycleTimeRules should be added  ${cycleTimeRulesData1}[0]
#    sleep  3

#cycleTimeRules edition
#    edit cycleTimeRules  ${cycleTimeRulesData1}[0]  ${cycleTimeRulesData1}[4]
#    i should see text on page  Cycle Time Rule edited
#    click  ${back}
#    reload page
#    sleep  3
#    cycleTimeRules should be added  ${cycleTimeRulesData1}[0]  ${cycleTimeRulesData1}[1]  ${cycleTimeRulesData1}[2]  ${editCTR}[0]
#    sleep  2
#
##cycleTimeRules using filter
##    click  ${filterButton}
##    input  ${machineFilter}  ${cycleTimeRulesData1}[0]
##    input  ${itemFilter}  ${cycleTimeRulesData1}[1]
##    input  ${processFilter}  ${cycleTimeRulesData1}[2]
##    input  ${valueFilter}  ${cycleTimeRulesData1}[3]
##    input  ${dailyTarget}  ${cycleTimeRulesData1}[5]
##    sleep  10
##    i should see row in table  ${cycleTimeRulesData1}[0]  ${cycleTimeRulesData1}[1]  ${cycleTimeRulesData1}[2]  ${cycleTimeRulesData1}[3]  ${cycleTimeRulesData1}[5]
#
#delete cycleTimeRules
#    delete cycleTimeRules  ${cycleTimeRulesData1}[0]
#    i should see text on page  Cycle Time Rule deactivated successfully
#    #cycleTimeRules deletion check
