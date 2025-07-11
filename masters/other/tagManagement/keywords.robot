*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library  Browser

Library    String
Library   ../../customkeyword1capitalletter.py

*** Keywords ***
open tagsMangement page
    click  ${mastersDropdown}
    click  //a[@id='tag_management']

tagsMangement should be added
    [Arguments]  ${tagName}
    click  (//*[name()='svg'][@id='undefined_Label_search'])[1]
    click  (//input[@placeholder='Search Label'])[1]
    Fill Text    (//input[@placeholder='Search Label'])[1]  ${tagName}
    click  (//input[@placeholder='Search Label'])[1]
    Wait For Elements State    //span[text() = "${tagName}"]  timeout=10s

Generate Random Tagnmanagement Name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    RETURN  ${random_customer_name}

