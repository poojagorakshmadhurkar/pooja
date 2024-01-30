*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{actionData}  Production Reports
@{fieldData}  Text Field  Document Field  Date  System Entity  List Field
@{editFieldGroupsData}

*** Test Cases ***
fieldGroups creation
    login
    select site  smart_factory
    open fieldGroup page
    click  ${addNewfieldGroups}
    click  ${fieldGroupsAction}
    sleep  1
    reload page
    select option from dropdown using span  ${fieldGroupsAction}  ${actionData}[0]
    setting fields  0  ${fieldData}[0]
    click  ${addMoreField}
    setting fields  1  ${fieldData}[1]
    click  ${addMoreField}
    setting fields  2  ${fieldData}[2]
    click  ${addMoreField}
    setting fields  3  ${fieldData}[3]
    click  ${addMoreField}
    setting fields  4  ${fieldData}[4]
    click  ${Submit}
    i should see text on page  Custom Field added
    open fieldGroup page
    reload page
    sleep  2
    fieldGroup should be added  ${actionData}[0]

editing fields
    edit fields  ${actionData}[0]
