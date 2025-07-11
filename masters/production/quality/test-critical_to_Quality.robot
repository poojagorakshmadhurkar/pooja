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

@{qualityData}  CheckNUt  kg  100  300     #change name here
@{EditQualityData}  RM Group  Store  Low      #change name here

*** Test Cases ***
Quality creation
    login devsite
    open quality page
    Reload
    click  ${criticaltoquality}
    sleep  1
    click  ${addNewQuality}
    ${randomlabelName}=  generate random string  5-10  [LETTERS]
    input  ${label}  ${randomlabelName}
    select option from dropdown using span  ${rejectionreasondropdown}  ${qualityData}[0]
    input  ${unit}  ${qualityData}[1]
    click  //button[normalize-space()='Edit']
    click  ${selectAll}
    click  ${save}
    input  ${minumumfieldbox}  ${qualityData}[2]
    input  ${maximumfieldbox}  ${qualityData}[3]
    click   ${ctqsubmit}
    I Should See Text On Page    Critical to Quality added
    open quality page
    Reload
    click  ${criticaltoquality}
    Quality Should Be Added In CTQ  ${randomlabelName}
    quality CTQ edit  ${randomlabelName}































