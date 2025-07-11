*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library    Browser
Library  String

*** Keywords ***
open machine page
    click  ${mastersDropdown}
    Wait For Elements State    ${mastersMachines}
    click  ${mastersMachines}
    Wait For Elements State    //h5[normalize-space()='machines']

Add Parent machine 
    [Arguments]  ${i}
    ${randomnewmachine}=  generate random string  5-10  [LETTERS]
    Wait For Elements State    (//input[@type='text'])[${i}]
    Fill Text    (//input[@type='text'])[${i}]  ${randomnewmachine}
    RETURN  ${randomnewmachine}


Add child machine
    [Arguments]  ${i}   ${j}
    click  (//button[text()="+ Add Child"])[${j}]
    Wait For Elements State    (//input[@type='text'])[${i}]
    ${randomnewmachine}=  generate random string  5-10  [LETTERS]
    Fill Text    (//input[@type='text'])[${i}]  ${randomnewmachine}

Delete machine
    [Arguments]  ${machinename}
    click  //a[text()="${machinename}"]/../../../../../../../../../td[6]//div[2]
    click  (//button[normalize-space()='Deactivate'])[1]
    I Should Not See Text On Page    Machine deactivated successfully