*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

#*** Variables ***
#@{MachineData1}  llas01  llasj19       #change name Here
#@{ChildMachineData1}  rtyen1  ksahdj1

*** Test Cases ***
parent machine creation
    login
    select site  smart_factory
    open machine page
    wait until page contains element  ${addNewMachine}  15
    machine creation  ${MachineData1}[0]

edit parent machine created by 1st method
    edit above machine  ${MachineData1}[0]

child machine creation by creating a machine and re-parenting it
    machine creation  ${ChildMachineData1}[0]

edit child machine created by 1st method
    edit above machine  ${ChildMachineData1}[0]
    reload page
    sleep  3
    machine re-parenting  ${ChildMachineData1}[0]

delete machine created by 1st method
    delete parent machine along with child  ${MachineData1}[0]

Creating Parent then child of that machine
    parent machine creation
    edit above machine  ${MachineData1}[1]
    child machine creation
    click  //a[text() = "${MachineData1}[1]"]/../../../../../../../../span[2]
    sleep  2
editing above child machine
    edit above machine  ${ChildMachineData1}[1]
delete machine created by second method
    reload page
    sleep  3
    delete parent machine along with child  ${MachineData1}[1]
