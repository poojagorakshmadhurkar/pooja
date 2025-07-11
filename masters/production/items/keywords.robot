*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Library    Browser

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
    click  (//*[name()='svg'][@id='item_Item Details_search'])[1]
    input  //input[@placeholder='Search Item Details']  ${labelName}
    browser.Press keys  //input[@placeholder='Search Item Details']  Enter
    Wait For Elements State      //a[text()="${labelName}"]

item should be added
    [Arguments]  ${itemCodeName}
    click  (//*[name()='svg'][@id='item_Item Details_search'])[1]
    click  ${searchItem}
    input  ${searchItem}  ${itemCodeName}
    Click    (//*[name()='svg'][@id='item_Item Details_search'])[2]
#    Wait For Elements State      //a[text()="${itemCodeName}"]


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
    click  ${itemcodeedit}
    ${randomitemGroupname}=  generate random string  5-10  [LETTERS]
    Clear Text    ${itemCode}
    input  ${itemCode}  ${randomitemGroupname}
    ${randomitemname}=  generate random string  5-10  [LETTERS]
    Clear Text    ${itemName}
    input  ${itemName}  ${randomitemname}
    click  ${Submit}
    i should see text on page  Item edited
    open item page
    Reload
    Wait For Elements State    (//div[@class='ant-spin-container'])[1]  hidden    timeout=60s
    item should be added  ${randomitemname}
    Reload
    Wait For Elements State    (//div[@class='ant-spin-container'])[1]  hidden    timeout=60s
    click  //a[text()="${randomitemGroupname}"]/../../../../../../../../../../td[8]
    click  //button[@id="item__deactivate_btn"]
    i should see text on page  Item deactivated successfully
    Reload
    Wait For Elements State    (//div[@class='ant-spin-container'])[1]  hidden    timeout=60s
    click  //*[name()='path' and contains(@d,'M12 8c1.1 ')]
    click  ${deactivate_item}
    click  //span[text() = "Item Details"]/../../../span[2]
    input  ${searchItem}  ${randomitemGroupname}
    click  ${searchItem}/../button[1]




edit itemGroup
    [Arguments]  ${labelName}
    click  //a[text() = "${labelName}"]
    click  ${itemcodeedit}
    Clear Text   ${itemGroupname}
    ${randomitemGroupname}=  generate random string  5-10  [LETTERS]
    input  ${itemGroupname}  ${randomitemGroupname}
    select option from dropdown using list  ${itemType}  RM
    select option from dropdown using list  ${units}  gram
#    click  //button[@id = "itemGroup__deleteRowBtn_1"]
#    click  //button[@id = "itemGroup__deleteRowBtn_0"]
#    click  ${addAttribute}
#    fill attribute  0  Length_edit  AI_AI_A
#    press keys  ${codePrefix}  CTRL+A  BACKSPACE  A_edit
#    press keys  ${namePrefix}  CTRL+A  BACKSPACE  B_edit
#    press keys  ${nameSeparator}  CTRL+A  BACKSPACE  *
    click  ${Submit}
    i should see text on page  Item Group edited
    open item page
    Reload
    click  ${itemGroupHeader}
#    click  (//button[contains(text(),'All Groups')])[1]
    itemGroup should be added  ${randomitemGroupname}
    click  //a[text()='${randomitemGroupname}']/../../../../../../../../../td[6]//*[name()='svg'][@class='MuiSvgIcon-root MuiSvgIcon-colorSecondary MuiSvgIcon-fontSizeMedium css-al619y']
    click  ${deactivate_itemGroup}
    i should see text on page  Item Group deactivated successfully


Select Value From Dropdown By Index
    [Arguments]    ${dropdown}    ${dropdownwithindex}
    Click Element    ${dropdown}    # Click to open the dropdown
#    Wait For Elements State     (//div[contains(@class, 'ant-select-item')])[${index}]   # Wait for the option to be visible
    Click Element    ${dropdownwithindex}    # Click to select the option

Generate Random 3-Digit Number
    ${random_number}=  Evaluate  random.randint(100, 999)
    RETURN    ${random_number}