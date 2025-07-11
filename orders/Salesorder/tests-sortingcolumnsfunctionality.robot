*** Settings ***
#Library           SeleniumLibrary
Library           Collections
Library           String
Resource          ../../keywords.robot
Resource          ./keywords.robot
#Resource          ../../inventory/transactions/keywords.robot
#Resource          ../../variables.robot
#Resource          ./variables.robot
Library     Browser

*** Variables ***
${SO_Details_Xpath}    //tbody/tr//td[1]
${SO_Details_Sort_Button}  (//span[@class='ant-table-column-title']//div)[1]

*** Test Cases ***
Sorting of So
    login devsite
    select site  testingsiteautomation
    open order tracker page
    click    //h5[text()="sales orders"]
       # Click on the sort button for SO Details column
    ${so_details}    Extract SO ListPage ColumnDetails  ${SO_Details_Xpath}
    Wait For Elements State        ${SO_Details_Sort_Button}   visible  timeout=60s
    Scroll To Element        ${SO_Details_Sort_Button}
    click   ${SO_Details_Sort_Button}
    Log Many    ${so_details}
    Verify Sorting Functionality    ${so_details}




