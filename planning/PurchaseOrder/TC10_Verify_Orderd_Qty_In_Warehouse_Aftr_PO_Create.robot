*** Settings ***
Library    SeleniumLibrary
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
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  10   10

#@{Item_Type}  Raw Material  FG
#@{Vendor}  Gupta Store  #Nandu   Unnati  Newvendortest02
#@{ItemData}  0  HR00004   50  25        #CR00004
#@{ItemData1}  1  HR00003  20  5         #CR00003
#@{ItemData2}  2  HR00002  30  7         #CR00002
#@{ItemData3}  3  HR00001  40  10        #CR00001
${expected_text}   Issued
@{inspected_By}   Testingname   #Afzal   Cindy   Demo Employee
#@{Deliverd_qnt}   5  10  15   20

*** Test Cases ***
Verify Orderd Quantity
    Open Browser Site
    Login To ManufApp Site
    select site   testingsiteautomation  #Smart Factory
    Landing On Purchase Order Page
    ${Actual_Orderd_Qnt.}=  Click_On_Warehouse
    set selenium speed    1s
    Landing On Purchase Order Page
#    Create Purchase order
    ${PO_No}=     create_po    ${ItemData}  ${vendor}   ${date}
    ${Expected_Ordered_Qt.}=     Click_On_Warehouse
#    Verify Ordered quantity
    ${Total_orders_qnt.}    Evaluate    ${Actual_Orderd_Qnt.} + ${ItemData}[2]
    Should Be Equal As Integers    ${Total_orders_qnt.}    ${Expected_Ordered_Qt.}
    #data validation
    click    ${LIVE_INVENTORY_ORDERED}
    wait until page contains element    (//div[@class='ant-table-container'])[2]    10s
    log    ${vendor}[0] - ${Expected_Ordered_Qt.} - ${date} - ${ItemData}[2] - ${ItemData}[1] - ${PO_No}
    wait until page contains element    //span[text()='${ItemData}[1] / ${ItemData}[1]']
#    wait until page contains element    //span[text()='${ItemData}[1] / ${ItemData}[1]']/../../../../../../div[2]//div[4]//div[text()='${Orderd_Qt} kg']/../../../../../div[1]  20s
    wait until page contains element  //a[text()="${PO_No}"]/../../../../../../../../../../td[2][text()="${vendor}[0]"]/../td[4][text()="${ItemData}[2] kg"]
#    click on details
    click    (//*[@data-testid="InfoOutlinedIcon"])[6]
    wait until page contains element  //a[text()="${PO_No}"]/../../../../../../div[2]//td[3]//span[text()="${vendor}[0]"]/../../../../../../../../../div[2]//tr[2]//td[1]//span[text()="${ItemData}[1]"]/../../../../../../../../../td[2][text()="${ItemData}[2] kg"]
    click    ${BACK3}    #click details
    Inward from Inventory   (//*[@data-testid="AssignmentReturnOutlinedIcon"])[1]   ${PO_No}    #click inward




