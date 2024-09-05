*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot

Library    String
Library   ../../customkeyword1capitalletter.py

*** Keywords ***
open tagsMangement page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersTagManagement}

tagsMangement should be added
    [Arguments]  ${tagName}
    click  ${filterButton}
    press keys  //input[@id='label']  CTRL+A  BACKSPACE
    input  //input[@id='label']  ${tagName}
    sleep  5
    wait until page contains element  //span[text() = "${tagName}"]  timeout=10s

Generate Random Tagnmanagement Name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    [Return]  ${random_customer_name}

