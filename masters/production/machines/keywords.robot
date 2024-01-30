*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot

*** Keywords ***
open machine page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersMachines}

machine creation
    [Arguments]  ${machineData}
    click  ${addNewMachine}
    input  ${machineName}  ${machineData}
    sleep  1
    click  ${inputScrapData}
    click  ${inputEnergyData}
#    click  ${woInProductionFalseCheck}
    click  ${Submit}
    sleep  1
    i should see text on page  Machine added
    open machine page
    reload page
    sleep  3
#    Execute JavaScript  window.scrollTo(0,2500)
#    sleep  2
    wait until element is visible  //a[text() = "${machineData}"]

edit above machine
    [Arguments]  ${machineData}
    click  //a[text() = "${machineData}"]
    sleep  2
    click  ${Edit}
    click  ${itemGtags}
    press keys  ${itemGtags}  ARROW_DOWN  ARROW_DOWN  ENTER   ESC
    sleep  2
    click  ${inputScrapData}
    click  ${inputEnergyData}
    click  ${Submit}
    Run Keyword And Ignore Error  wait until page contains  Machine edited  15
    open machine page
    reload page
    sleep  3
    wait until element is visible  //a[text() = "${machineData}"]

machine re-parenting
    [Arguments]  ${childName}
    click  //a[text() = "${childName}"]/../../../../../../../../../../div[4]/td/div/button[1]
    sleep  3
#    click  ${newParent}/../../span[2]
    press keys  ${newParent}  ${MachineData1}[0]
    sleep  2
    wait until page contains element  //span[contains(text(),'${MachineData1}[0]')]  10
    click  //span[contains(text(),'${MachineData1}[0]')]
    click  ${reParentButton}
    i should see text on page  Machine Re-parented Successfully
    reload page
    sleep  3
#    Execute JavaScript  window.scrollBy(0,2500)
#    sleep  2
#    click  //a[text() = "${MachineData1}[0]"]/../../../../../../../../span[2]/input[@type = "checkbox"]
#    wait until element is visible  //a[text() = "${childName}"]  timeout=15s

parent machine creation
    click  ${addNewMachine}
    input  ${machineName}  ${MachineData1}[1]
    sleep  1
    click  ${inputScrapData}
    click  ${inputEnergyData}
#    click  ${woInProductionFalseCheck}
    click  ${Submit}
    sleep  1
    i should see text on page  Machine added
    open machine page
    reload page
    sleep  3
#    Execute JavaScript  window.scrollTo(0,2500)
#    sleep  2
    wait until element is visible  //a[text() = "${MachineData1}[1]"]  timeout=15s

child machine creation
    click  ${addNewMachine}
    input  ${machineName}  ${ChildMachineData1}[1]
    sleep  3
#    click  ${parent}/../../span[2]----use this when you dont get the parent name
#    input  ${parent}  ${MachineData1}[1]
    press keys  ${parent}  ${MachineData1}[1]
#    click  //span[@class='ant-select-tree-switcher ant-select-tree-switcher_open']  #this icon is to press when we dont get the list of all the machine in site
    wait until page contains element  //span[contains(text(),'${MachineData1}[1]')]  15
    click  //span[contains(text(),'${MachineData1}[1]')]
    click  ${Submit}
    sleep  1
    i should see text on page  Machine added
    open machine page
    reload page
    sleep  3
#    Execute JavaScript  window.scrollTo(0,2500)
#    sleep  2
#    click  //a[text() = "${MachineData1}[1]"]/../../../../../../../../span[2]/input[@type = "checkbox"]
#    wait until element is visible  //a[text() = "${ChildMachineData1}[1]"]  timeout=15s

delete parent machine along with child
    [Arguments]  ${parentName}
    click  //a[text() = "${parentName}"]/../../../../../../../../../../div[4]/td/div/button[@id = "machine__Deactivate_btn"]
    click  ${deactivate_machine}
    i should see text on page  Machine Deactivated Successfully
    reload page
    sleep  3
