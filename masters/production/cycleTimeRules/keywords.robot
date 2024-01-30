*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot

*** Keywords ***
open cycleTimeRules page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersCycleTimeRules}

cycleTimeRules should be added
    [Arguments]  ${machineGroup}
    wait until element is visible  //table/tbody/tr/th/span[text() = "${machineGroup}"]  5
    element should be visible  //table/tbody/tr/th/span[text() = "${machineGroup}"]

edit cycleTimeRules
    [Arguments]  ${machineGroup}  ${newSeconds}
    click  //span[text() = "${machineGroup}"]/../../td[5]/div/button[@id = "rules__Edit"]
    sleep  1
    click  ${Edit}
    press keys  ${Seconds}  CTRL+A  BACKSPACE  ${newSeconds}
    click  ${Submit}

i should see row in table
    [Arguments]  ${machineName}  ${itemName}  ${processName}  ${valueName}
    wait until element is visible  //span[contains(text(), "${machineName}")]/../../td[contains(text(), "${itemName}")]/../td[contains(text(), "${processName}")]



delete cycleTimeRules
    [Arguments]  ${machineGroup}
    click  //span[text() = "${machineGroup}"]/../../td[5]/div/button[@id = "rules__Deactivate"]
    click  ${Deactivate}

cycleTimeRules deletion check
    [Arguments]  ${machineGrouptags}
    wait until element is not visible  //table/tbody/tr/th/span[text() = "${machineGrouptags}"]
    #element should not be visible  //table/tbody/tr/th/span[text() = "${machineGrouptags}"]