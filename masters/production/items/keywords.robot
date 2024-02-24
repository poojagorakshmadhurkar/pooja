*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot

#*** Variables ***
#${max_attempts}    10
#${timeout}         30s

*** Keywords ***
open item page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersItems}

itemGroup should be added
    [Arguments]  ${labelName}
    click  //button[@id='itemGroup__filterBtn']//*[name()='svg']
    input  //input[@id='title']  ${labelName}
    wait until page contains  ${labelName}  timeout=10

item should be added
    [Arguments]  ${itemCodeName}
    wait until page contains element  //span[text() = "Item Details"]/../../../span[2]  timeout=15s
    click  //span[text() = "Item Details"]/../../../span[2]
    input  ${searchItem}  ${itemCodeName}
    click  ${searchItem}/../button[1]
    wait until page contains  ${itemCodeName}  timeout=10s

#this still pending as a while loop
#    [Arguments]  ${itemGroupname}
#    click  //span[text() = "10 / page"]
#    click  ${getLastPage}
#    ${attempts}=    Set Variable    0
#    ${text_found}=    Run Keyword And Return Status    Search For Text    ${itemGroupname}
#    WHILE    ${text_found} == ${False} AND ${attempts} < ${max_attempts}
#    ${text_found}=    Run Keyword And Return Status    Search For Text    ${itemGroupname}
#    ${attempts}=    Evaluate    ${attempts} + 1
#    Run Keyword If    ${text_found} == ${False}    click  //*[name()='path' and contains(@d,'M765.7 486')]    # Replace with the appropriate keyword to navigate to the next page
#    Sleep    4s  # Add a short delay to avoid overwhelming the server
#    END
#
#    # If the loop completes without finding the text, the test will fail
#    Fail Unless    ${text_found}    Text not found within ${max_attempts} attempts
#
##* Keywords *
##Search For Text
##    [Documentation]    Search for the expected text on the current page
##    [Return]           ${text_found}
##    ${text_found}=    Run Keyword And Return Status    Wait Until Page Contains    Your Expected Text    timeout=${timeout}
##    [Return]           ${text_found}
#
#
#
#
#
#    Wait Until Page Contains  ${itemGroupname}  timeout=5s


create bom
    [Arguments]  ${fgName}
    click  ((//span[text() = "${fgName}"]/../../../../../../../../../../td)[6]/div/button)[1]
    click  ${addBom}
    sleep  1
    #clear element text  ${bomQuantity}
    press keys  ${bomQuantity}  CTRL+A  BACKSPACE  1.5
    #input  ${bomQuantity}  1.5



add item to BOM
    [Arguments]  ${rowNumber}  ${inBomName}  ${inBomNameQuantity}
    #log to console  ${inputItemBom}[${rowNumber}]
    input  ${inputItemBom}[${rowNumber}]  ${inBomName}
    press keys  ${inputItemBom}[${rowNumber}]  RETURN
    input  ${inBomNameQuantity}[${rowNumber}]  ${inBomNameQuantity}

fill attribute
    [Arguments]  ${i}  ${attName}  ${attValue}
    input  //input[@id = "itemGroup__attributes_${i}"]  ${attName}
    select attribute value from dropdown  //input[@id = "itemGroup__attributeValues_${i}"]  ${attValue}
    click  //input[@id = "itemGroup__attributeValues_${i}"]

fill attribute with new att value tag
    [Arguments]  ${i}  ${attName}  ${attValue}
    input  //input[@id = "itemGroup__attributes_${i}"]  ${attName}
    make new attribute tag  //input[@id = "itemGroup__attributeValues_${i}"]  ${attValue}
    sleep  2
    select attribute value from dropdown  //input[@id = "itemGroup__attributeValues_${i}"]  ${attValue}
    click  //input[@id = "itemGroup__attributeValues_${i}"]

edit item
    [Arguments]  ${itemCodeName}
    click  //a[text() = "${itemCodeName}"]
    sleep  2
    click  ${Edit}
    press keys  ${itemCode}  CTRL+A  BACKSPACE  ${editItemData}[0]
    press keys  ${itemName}  CTRL+A  BACKSPACE  ${editItemData}[1]
#    select randomly from dropdown  ${itemgroup}  item__itemGroup_list  8
    click  ${Submit}
    i should see text on page  Item edited
    open item page
    reload page
    sleep  3
    item should be added  ${editItemData}[0]

delete item
    [Arguments]  ${itemCodeName}
#    click  //a[text() = "${itemCodeName}"]/../../../../../../../../../../td[7]
    sleep  1
    click  //*[name()='path' and contains(@d,'M12 8c1.1 ')]
    click  //div[normalize-space()='Deactivated items']
    sleep  3
    click  (//span[@role='button'])[1]
    input  //input[@placeholder='Search Item Details']  ${itemCodeName}
    click  //input[@type="text"]/../..//button[1]
    i should see text on page  Item deactivated successfully  ${itemCodeName}

edit itemGroup
    [Arguments]  ${labelName}
    click  //a[text() = "${labelName}"]
    sleep  2
    click  ${Edit}
    press keys  ${itemGroupname}  CTRL+A  BACKSPACE
    input  ${itemGroupname}  ${edititemGroupData}[0]
    select option from dropdown using list  ${itemType}  ${edititemGroupData}[1]
    select option from dropdown using list  ${units}  ${edititemGroupData}[2]
    click  //button[@id = "itemGroup__deleteRowBtn_1"]
    sleep  1
    click  //button[@id = "itemGroup__deleteRowBtn_0"]
    sleep  1
#    click  ${addAttribute}
#    fill attribute  0  Length_edit  AI_AI_A
#    press keys  ${codePrefix}  CTRL+A  BACKSPACE  A_edit
#    press keys  ${namePrefix}  CTRL+A  BACKSPACE  B_edit
#    press keys  ${nameSeparator}  CTRL+A  BACKSPACE  *
    click  ${Submit}
    i should see text on page  Item Group edited
    open item page
    reload page
    sleep  3
    click  ${itemGroupHeader}
    sleep  2
#    click  (//button[contains(text(),'All Groups')])[1]
    sleep  2
    itemGroup should be added  ${edititemGroupData}[0]

delete itemGroup
    [Arguments]  ${itemCodeName}
    click  //a[text()='${itemCodeName}']/../../../../../../../../../../td[5]/div/button[3][@id = "itemGroup__Deactivate"]
    click  ${deactivate_itemGroup}
    i should see text on page  Item Group deactivated successfully
