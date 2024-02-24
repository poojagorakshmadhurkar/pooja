*** Settings ***
Library  SeleniumLibrary
Resource  ./variables.robot
Resource  ./keywords.robot

*** Test Cases ***
Inward Transaction
    login
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
