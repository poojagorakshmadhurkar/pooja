*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Library    Browser

*** Keywords ***
open cycleTimeRules page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersCycleTimeRules}

cycleTimeRules should be added
    [Arguments]  ${machineName}  ${itemName}  ${processName}  ${seconds}
#    wait until element is visible  //span[contains(text(), "${machineName}")]/../../td[contains(text(), "${itemName}")]/../td[contains(text(), "${processName}")]
    click  ${filterButton}
    input  ${machineFilter}  ${machineName}
    input  ${itemFilter}  ${itemName}
    input  ${processFilter}  ${processName}
    input  ${valueFilter}  ${seconds}

    i should see row in table  ${cycleTimeRulesData1}[0]  ${cycleTimeRulesData1}[1]  ${cycleTimeRulesData1}[2]

edit cycleTimeRules
    [Arguments]  ${machineGroup}  ${newSeconds}
    click  //span[text() = "${machineGroup}"]/../../td[5]/div/button[@id = "rules__Edit"]
    click  ${Edit}
    Fill Text      ${Seconds}   ${newSeconds}
    click  ${Submit}

i should see row in table
    [Arguments]  ${machineName}  ${itemName}  ${processName}
    ${recievedname1}  Set Variable  ${machineName}
    ${uppermachine}  Evaluate  "${recievedname1}".upper()
    ${recievedname2}  Set Variable  ${itemName}
    ${upperitem}  Evaluate  "${recievedname2}".upper()
    ${recievedname3}  Set Variable  ${processName}
    ${upperprcoess}  Evaluate  "${recievedname3}".upper()
#     wait until page contains element  //span[contains(upper-case(text()), "${machineName}")]/../../td[1][contains(upper-case(text()), "${itemName}")]/../td[3][contains(upper-case((text)), "${processName}")]
    wait until page contains element  //span[text() = "${uppermachine}"]/../../td[1][text() = "${upperitem}"]/../td[3][text() = "${upperprcoess}"]


delete cycleTimeRules
    [Arguments]  ${machineGroup}
    click  //span[text() = "${machineGroup}"]/../../td[5]/div/button[@id = "rules__Deactivate"]
    click  ${Deactivate}

cycleTimeRules deletion check
    [Arguments]  ${machineGrouptags}
    wait until element is not visible  //table/tbody/tr/th/span[text() = "${machineGrouptags}"]
    #element should not be visible  //table/tbody/tr/th/span[text() = "${machineGrouptags}"]