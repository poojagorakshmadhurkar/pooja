*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           String
Resource          ../../keywords.robot
Resource          ./keywords.robot
Resource          ../../inventory/transactions/keywords.robot
Resource          ../../variables.robot
Resource          ./variables.robot

*** Variables ***
${SO_Details_Xpath}    //tbody/tr//td[1]
${SO_Details_Sort_Button}  (//span[@class='ant-table-column-title']//div)[1]

*** Test Cases ***
Sorting of So
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open order tracker page
    sleep    5
    click    //h5[text()="sales orders"]
       # Click on the sort button for SO Details column
    ${so_details}    Extract SO ListPage ColumnDetails  ${SO_Details_Xpath}
    wait until element is visible    ${SO_Details_Sort_Button}
    Scroll Element Into View    ${SO_Details_Sort_Button}
    sleep  2
    click element  ${SO_Details_Sort_Button}
    Log Many    ${so_details}
    Verify Sorting Functionality    ${so_details}




