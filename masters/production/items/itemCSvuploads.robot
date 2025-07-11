*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library    CsvKeywords.py
Library    Browser

*** Variables ***
#@{itemGroupData}  ItemGroupp15
#@{edititemGroupData}  editItemGroupp15  Raw Material  gram

${DROPDOWN_OPTION}  xpath=(//div[contains(@class, 'ant-select-item')])[${INDEX}]
${INDEX}            2
${DOWNLOAD_PATH}    C:/Users/user/Downloads
${NUM ROWS}         1

*** Test Cases ***
itemGroup creation
    login devsite
    open item page
    click  //span[text() = "This is a testing Site"]
    click  ${itemGroupHeader}
    itemGroup should be added  Testing CSV upload Group
    click  ${itemuploadcsvbutton}
    click  ${itemdownlaodcsvbutton}
    ${CSV_FILE_NAME} =   Get Latest Downloaded CSV File   ${DOWNLOAD_PATH}
    ${generated_data} =   Read And Generate Random Data For CSV   ${DOWNLOAD_PATH}   ${CSV_FILE_NAME}   ${NUM_ROWS}

    FOR    ${row}    IN    @{generated_data}
        Log    Data: ${row}
        ${item_code} =    Set Variable    ${row}[0]  # Extract item_code from the list
        ${item_name} =    Set Variable    ${row}[1]  # Extract item_name from the list
        Log    Item Code: ${item_code}, Item Name: ${item_name}
    END
    click  ${uploadbuttonforparticulargrp}
    Upload File By Selector      //input[@type='file']    ${CSV_FILE_NAME}
    click  ${csvsubmitbutton}
    #wait until page contains  "Please wait as the items are getting uploaded. The items will be uploaded in a while"   timeout=30
    click  ${csvclosebutton}
    Reload
    sleep  2
    item should be added  ${item_name}
    sleep  1
    click  //span[text()="${item_name}"]/../../../../../../../td[8]//button
    click  //button[@id="item__deactivate_btn"]
    i should see text on page  Item deactivated successfully