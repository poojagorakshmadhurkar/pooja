*** Settings ***
Library    Browser
Library  String
Library  Collections
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
Resource  ../../variables.robot
Resource  ../../inventory/transactions/keywords.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Xyzzz   Nandu   Unnati  Vendor55
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  10   10   1122
${expected_text}   Issued
@{inspected_By}   Testingname   #Afzal   Cindy   Demo Employee

*** Test Cases ***
Verify Orderd Quantity
    Login To ManufApp Site
    Select Your Site  11    Smart Factory   #testingsiteautomation  #Smart Factory
    Landing On Purchase Order Page
    ${Actual_Orderd_Qnt.}=  Click_On_Warehouse
    Landing On Purchase Order Page
#    Create Purchase order
    ${PO_No}=     create_po    ${ItemData}  ${vendor}
    ${Expected_Ordered_Qt.}=     Click_On_Warehouse
    # Verify Ordered quantity
    ${Total_orders_qnt.}    Evaluate    ${Actual_Orderd_Qnt.} + ${ItemData}[2]
    Should Be Equal As Integers    ${Total_orders_qnt.}    ${Expected_Ordered_Qt.}
    #data validation
    click    ${LIVE_INVENTORY_ORDERED}
    Wait For Elements State    (//div[@class='ant-table-container'])[2]    visible   timeout=30s
    log    ${vendor}[0] - ${Expected_Ordered_Qt.} - ${date} - ${ItemData}[2] - ${ItemData}[1] - ${PO_No}
    Wait For Elements State    //span[text()='${ItemData}[1] / ${ItemData}[1]']    visible   timeout=30s
    # Wait For Elements State    //span[text()='${ItemData}[1] / ${ItemData}[1]']/../../../../../../div[2]//div[4]//div[text()='${Orderd_Qt} kg']/../../../../../div[1]  20s
    Wait For Elements State   //a[text()="${PO_No}"]/../../../../../../../../../../td[2][text()="${vendor}[0]"]/../td[5][text()="${ItemData}[2] kg"]    visible   timeout=30s
    Wait For Elements State  //a[text()="${PO_No}"]/../../../../../../../../../../td[2][text()="${vendor}[0]"]/../td[5][text()="${ItemData}[2] kg"]    visible   timeout=30s
    # click on details
    click    (//*[@data-testid="InfoOutlinedIcon"])[7]
    sleep   0.5s
    Wait For Elements State   //a[text()="${PO_No}"]//following::div[6]//span[text()="${vendor}[0]"]    #//a[text()="${PO_No}"]//following::div[5]//span[text()="${vendor}[0]"]    visible   timeout=30s
    Wait For Elements State    (//span[text()="${ItemData}[1]"])[1]//following::td[text()="${ItemData}[2] kg"][1]  visible   timeout=30s
    click    ${BACK3}    #click details
    Inward from Inventory   (//*[@data-testid="AssignmentReturnOutlinedIcon"])[1]   ${PO_No}    #click inward
    [Teardown]    Browser.Close Browser



