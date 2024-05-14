*** Settings ***
Documentation    Verify Status Of PO
Library    SeleniumLibrary
Library    String
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Test Cases ***
Generate Random number
    ${ran_int}=    Generate Random String    length=4    chars=[NUMBERS]
    ${ran_int}=    Convert To Integer    ${ran_int}
    log to console    This is a random number between 1000 and 9999: ${ran_int}
#    RETURN    ${ran_int}
#    Generate Random string



#Generate Random string
#    ${random_string}=    Generate Random String    length=6    chars=[UPPER][NUMBERS]
#    Log    Random String: ${random_string}
#    log to console    Random String: ${random_string}



