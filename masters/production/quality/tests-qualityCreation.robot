*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

*** Variables ***

@{qualityData}  Rawmaterial  Planning  Medium     #change name here
@{EditQualityData}  RM Group  Store  Low      #change name here

*** Test Cases ***
Quality creation
    Set Selenium Speed    0.1
    logindevsite
    select site  testingsiteautomation
    open quality page
    click  ${addNewQuality}
    ${randomQualityName}=  generate random string  5-10  [LETTERS]
    input  ${qualityName}  ${randomQualityName}
    enters quality tags  ${qualityData}[0]
    select option from dropdown using list  ${Department}  ${qualityData}[1]
    select option from dropdown using list  ${Severity}  ${qualityData}[2]
    click  ${Submit}
    sleep  2
    i should see text on page  Issue added
    open quality page
    reload page
    sleep  4
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

