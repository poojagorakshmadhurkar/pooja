*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot

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
