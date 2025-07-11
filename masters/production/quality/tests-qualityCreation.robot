*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    Browser
#Resource  ../../keywords.robot

*** Variables ***

@{qualityData}  A  Planning  Medium     #change name here
@{EditQualityData}  RM Group  Store  Low      #change name here

*** Test Cases ***
Quality creation
    login devsite
    select site  testingsiteautomation
    open quality page
    sleep  2
    click  ${addNewQuality}
    ${randomQualityName}=  generate random string  5-10  [LETTERS]
    Fill Text   ${qualityName}  ${randomQualityName}
    enters quality tags  ${qualityData}[0]
    select option from dropdown using div  ${Department}  ${qualityData}[1]
    select option from dropdown using div  ${Severity}  ${qualityData}[2]
    click  ${Submit}
    i should see text on page  Issue added
    open quality page
    Reload
    Wait For Elements State       //h5[text()="Quality issues"]
    click  ${allIssues}
    quality should be added  ${randomQualityName}
    quality edit  ${randomQualityName}



























#*** Settings ***
#Library  SeleniumLibrary
#Library  FakerLibrary
#Library  Collections
#
#*** Test Cases ***
#Generate Random Data
#    ${name}  FakerLibrary.Name
##    ${fake_email}      FakerLibrary.Generate Random Email
##    ${fake_address}    FakerLibrary.Generate Random Address
#
#    Log    Random Name: ${name}
##    Log    Random Email: ${fake_email}
##    Log    Random Address: ${fake_address}

