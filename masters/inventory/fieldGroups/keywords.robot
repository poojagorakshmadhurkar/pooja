*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
#Resource  ./variables.robot
Library  Browser
Library    String

*** Keywords ***

open fieldGroup page
    click  ${mastersDropdown}
    Wait For Elements State    ${mastersFieldGroups}   visible  timeout=60s
    click  ${mastersFieldGroups}
    sleep  1
    Reload

fieldGroup should be added
    [Arguments]  ${eventName}
    click  //button[@id='fieldGroups__filterBtn']
    press keys  //input[@id = "event"]  CTRL+A  BACKSPACE
    input  //input[@id = "event"]  ${eventName}
    Wait For Elements State  ${eventName}

selecting from dropdown
    [Arguments]  ${dropdownXpath}  ${option}
    input  ${dropdownXpath}  ${option}
    Run Keyword and Ignore Error  scroll element into view   //span[text() = "${option}"]
    press keys  ${dropdownXpath}  ARROW_DOWN  ENTER

setting fields
    [Arguments]  ${i}  ${fieldType}
    ${randomFieldName}=  Generate Random String  5-10  [LETTERS]
    input  //input[@id = "fieldGroup__fieldNames_${i}"]  ${randomFieldName}
    selecting from dropdown  //input[@id = "fieldGroup__fieldNames_${i}"]/../../div[2]/div/div/span/input[@id = "fieldGroup__fieldType_${i}"]  ${fieldType}
    click  //input[@id = "fieldGroup__showInFormCheckbox_${i}"]/../..
    click  //input[@id = "fieldGroup__mandatoryCheckbox_${i}"]/../..
    click  //input[@id = "fieldGroup__shownInTableCheckbox_${i}"]/../..


edit fields
   [Arguments]  ${Event}
   click  //a[text() = "${Event}"]
   click  //button[@id='__edit']
   click  //input[@id = "fieldGroup__showInFormCheckbox_0"]/../..
   click  //input[@id = "fieldGroup__mandatoryCheckbox_0"]/../..
   click  //button[@id='__submit']
#   Wait For Elements State   Custom Field edited
   open fieldGroup page
   Reload
   Wait For Elements State  //a[text() = "${Event}"]