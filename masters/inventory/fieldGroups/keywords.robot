*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot

*** Keywords ***
open fieldGroup page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersFieldGroups}

fieldGroup should be added
    [Arguments]  ${eventName}
    click  //button[@id='fieldGroups__filterBtn']
    sleep  1
    press keys  //input[@id = "event"]  CTRL+A  BACKSPACE
    input  //input[@id = "event"]  ${eventName}
    wait until page contains  ${eventName}

selecting from dropdown
    [Arguments]  ${dropdownXpath}  ${option}
    input  ${dropdownXpath}  ${option}
    Run Keyword and Ignore Error  scroll element into view   //span[text() = "${option}"]
    press keys  ${dropdownXpath}  ARROW_DOWN  ENTER

setting fields
    [Arguments]  ${i}  ${fieldType}
    ${randomFieldName}=  generate random string  5-10  [LETTERS]
    input  //input[@id = "fieldGroup__fieldNames_${i}"]  ${randomFieldName}
    sleep  1
    selecting from dropdown  //input[@id = "fieldGroup__fieldNames_${i}"]/../../div[2]/div/div/span/input[@id = "fieldGroup__fieldType_${i}"]  ${fieldType}
    sleep  1
    click  //input[@id = "fieldGroup__showInFormCheckbox_${i}"]/../..
    sleep  1
    click  //input[@id = "fieldGroup__mandatoryCheckbox_${i}"]/../..
    sleep  1
    click  //input[@id = "fieldGroup__shownInTableCheckbox_${i}"]/../..
    sleep  1

edit fields
   [Arguments]  ${Event}
   click  //a[text() = "${Event}"]
   click  ${Edit}
   click  //input[@id = "fieldGroup__showInFormCheckbox_0"]/../..
   sleep  1
   click  //input[@id = "fieldGroup__mandatoryCheckbox_0"]/../..
   sleep  1
   click  //input[@id = "fieldGroup__shownInTableCheckbox_0"]/../..
   sleep  1
   click  //button[@id = "fieldGroup__deleteBtn_1"]
   sleep  1
   click  //input[@id = "fieldGroup__showInFormCheckbox_2"]/../..
   sleep  1
   click  //input[@id = "fieldGroup__mandatoryCheckbox_2"]/../..
   sleep  1
   click  //input[@id = "fieldGroup__showInFormCheckbox_3"]/../..
   sleep  1
   click  ${Submit}
   i should see text on page  Custom Field edited
   sleep  1
   open fieldGroup page
   reload page
   sleep  2
   wait until page contains element  //a[text() = "${Event}"]