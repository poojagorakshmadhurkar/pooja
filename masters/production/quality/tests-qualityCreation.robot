*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

#*** Variables ***
#@{qualityData}  newIssue18  abc  Planning  Medium     #change name here
#@{EditQualityData}  editedIssue19  RM Group  Store  Low      #change name here

*** Test Cases ***
Quality creation
    Set Selenium Speed    0.1
    login
    select site  smart_factory
    open quality page
    click  ${addNewQuality}
#    ${randomQualityName}=  generate random string  5-10  [LETTERS]
    input  ${qualityName}  ${qualityData}[0]
#    enters quality tags  ${qualityData}[1]
    select option from dropdown using list  ${Department}  ${qualityData}[2]
    select option from dropdown using list  ${Severity}  ${qualityData}[3]
    click  ${Submit}
    sleep  2
    i should see text on page  Issue added
    open quality page
    reload page
    sleep  4
    click  ${allIssues}
    quality should be added  ${qualityData}[0]

editing quality
    quality edit  ${qualityData}[0]


delete edited quality
    delete quality  ${EditQualityData}[0]


























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

