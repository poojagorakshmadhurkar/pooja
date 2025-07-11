*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library    Browser



*** Test Cases ***
parent machine creation
    login devsite
    select site   testingsite4
    open machine page
    sleep  1
    click  ${addNewMachine}
    ${machine1}=   Add Parent machine  1
    Add child machine   2  1
    Add child machine   3  2
    click  ${addmachinebutton}
    ${machine2} =  Add Parent machine  4
    Add child machine   5  4
    Add child machine   6  5
    click  ${nextmachinebtn}
    click  ${nextmachinebtn}
    click   ${machinesubmitbtn}
    I Should Not See Text On Page    Machine added
    click  ${machinebackbtn}
    Reload
    Wait For Elements State    (//div[@class='ant-spin-container'])[1]  hidden    timeout=60s
    Wait For Elements State    //h5[normalize-space()='machines']
#    Scroll To Element    xpath=//div[@class='ant-table-body']//tr[last()]
    Hover    xpath=//div[@class='ant-table-body']
    Reload
    Mouse Wheel    0    2000
    sleep  1
    Delete Machine   ${machine1}
    Reload
    Hover    xpath=//div[@class='ant-table-body']
    Mouse Wheel    0    2000
    Delete Machine   ${machine2}








