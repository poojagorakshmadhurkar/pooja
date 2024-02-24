*** Settings ***
Library  SeleniumLibrary
Resource  ./variables.robot

*** Keywords ***
click
    [Arguments]  ${xpath}
    wait until element is visible  ${xpath}  10
    click element  ${xpath}

input
    [Arguments]  ${xpath}  ${text}
    wait until element is visible  ${xpath}  10
    input text  ${xpath}  ${text}

login
    open browser  ${url}  chrome
    maximize browser window
    input  ${email}  admin@smart.com
    input  ${password}  271828
    click  ${signIn}
    wait until page contains  OEE Dashboard  30

login to production
    open browser  ${urltoproduction}  chrome
    maximize browser window
    input  ${email}  admin@smart.com
    input  ${password}  Manufapp2023
    click  ${signIn}
    wait until page contains  OEE Dashboard  30

select site
    [Arguments]  ${site}
    click  ${siteSelector}
    Wait Until Page Contains Element  //a[@id = "${site}"]  10
    click  //a[@id = "${site}"]

select site of production
    [Arguments]  ${site}
    click  ${siteSelector}
    Wait Until Page Contains Element  //a[@id = "${site}"]  10
    click  //a[@id = "${site}"]


select option from dropdown using list
    [Arguments]  ${dropdownXpath}  ${option}
    click  ${dropdownXpath}
    wait until page contains element  //li[text() = "${option}"]
    Run Keyword And Ignore Error  scroll element into view  //li[text() = "${option}"]
    click  //li[text() = "${option}"]
#
#select warehouse name from dropdown
#    [Arguments]  ${dropdownXpath}  ${option}
#    click  ${dropdownXpath}
#    sleep  1
#    Run Keyword And Ignore Error  scroll element into view  (//ul[@id = "menu-list-grow"]/a)[${option}]
#    click  (//ul[@id = "menu-list-grow"]/a)[${option}]

select option from dropdown using span
    [Arguments]  ${dropdownXpath}  ${option}
    click  ${dropdownXpath}
    Run Keyword And Ignore Error  scroll element into view   //span[text() = "${option}"]
    click  //span[text() = "${option}"]

select option from dropdown using div
    [Arguments]  ${dropdownXpath}  ${option}
    click  ${dropdownXpath}
    scroll element into view  //span[text() = "${option}"]
    click  //span[text() = "${option}"]

select option from dropdown by inputting
    [Arguments]  ${dropdownXpath}  ${option}
    input  ${dropdownXpath}  ${option}
    wait until element is visible  //span[text() = "${option}"]  10
    click  //span[text() = "${option}"]/..

#select randomly from dropdown
#    [Arguments]  ${dropdownXpath}
#    click  ${dropdownXpath}
#    ${count}=  get element count  //li
#    ${random}=  evaluate  random.sample(range(${count}), 1)  random
#    Run Keyword And Ignore Error  scroll element into view  (//li)${random}
#    click  (//li)${random}

select randomly from dropdown
    [Arguments]  ${dropdownXpath}  ${id}  ${UL}
    click  ${dropdownXpath}
    ${random}=  evaluate  random.randint(1, ${UL})
    press keys  ${dropdownXpath}  ARROW_DOWN  ARROW_DOWN  ARROW_DOWN
    sleep  1
#    FOR  ${i}  IN RANGE  15
#        press keys  ${dropdownXpath}  ARROW_DOWN
#    END
#    Release key  ${dropdownXpath}  40
#    Run Keyword And Ignore Error  scroll element into view  (//li)${random}
    scroll element into view  //div[@id = "${id}"]/../div[2]/div/div/div/div[${random}]/div/span/span/span/span/span/span/span
    click  //div[@id = "${id}"]/../div[2]/div/div/div/div[${random}]/div/span/span/span/span/span/span/span


Get Random Value
    [Arguments]    ${element_list}
    ${list_length}    Get Length    ${element_list}
    ${random_index}    Evaluate    random.randint(0, ${list_length}-1)
    ${random_value}    Get From List    ${element_list}    ${random_index}
    [Return]    ${random_value}



select attribute value from dropdown
    [Arguments]  ${dropdownXpath}  ${option}
    click  ${dropdownXpath}
    wait until page contains element  //span/span/span[text() = "${option}"]
    Run Keyword And Ignore Error  scroll element into view  //span/span/span[text() = "${option}"]
    click  //span/span/span[text() = "${option}"]

make new attribute tag
     [Arguments]  ${dropdownXpath}  ${option}
#     click  ${dropdownXpath}
     input  ${dropdownXpath}  ${option}
     press keys  ${dropdownXpath}  ENTER
     sleep  2
     click  ${createNewTag}

create new tag
    [Arguments]  ${tagName}
    click  //h2[text() = "Create new tag: ${tagName}"]/../div/button[text() = "Create new tag"]


i should see text on page
    [Arguments]  ${text}
    wait until page contains  ${text}  10

i should not see text on page
    [Arguments]  ${text}
    wait until page does not contains  ${text}  10

#random single number
#    ${digits}=    Create List    1    2    3    4    5    6    7    8    9
#    ${random_digit}=    Get Random From List    ${digits}
#    Return From Keyword    ${random_digit}


