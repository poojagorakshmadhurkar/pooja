*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime
*** Variables ***
@{itemData1}  Alphox  20
@{itemData2}  RM1  30
@{itemData3}  game_item_3  21
@{itemData4}  game_item_3  12
@{itemData5}  C00001  13
@{itemData6}  Compound4  50
@{edititemData1}  RMItem-7  11
@{edititemData2}  RMItem-2  32
@{edititemData3}
@{edititemData4}
@{edititemData5}  Aerilic Sheet  6
@{edititemData6}  Compound5  31

*** Test Cases ***
Outward to customer
    login
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Cust-003
    date entry
    set ith item in outward  0  ${itemData1}[0]  ${itemData1}[1]
    set ith item in outward  1  ${itemData2}[0]  ${itemData2}[1]
    click  ${submit}
    click  ${newRequest}
    open trasactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Pending  1
    click  //div[@id = "item__tabs-panel-debit"]/div/div/div/div/div/div/div/div[2]/table/tbody/tr[2]/td[1]/div/span/a
    click  ${edit}
    edit ith item in outward  0  ${edititemData1}[0]  ${edititemData1}[1]
    edit ith item in outward  1  ${edititemData2}[0]  ${edititemData2}[1]
    click  ${submit}
    i should see text on page  Transaction Edited SuccesFully
    approve outward

outward to JW Vendor
    login
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Jobwork Vendor
    select jobwork vendor  Vendor15
    date entry
    set ith item in outward  0  ${itemData3}[0]  ${itemData3}[1]
    click  ${submit}
    click  ${newRequest}
    approve outward
#    click  //div[@id = "item__tabs-panel-debit"]/div/div/div/div/div/div/div/div[2]/table/tbody/tr[2]/td[1]/div/span/a
#    click  ${edit}
#    edit ith item in outward  1  ${edititemData2}[0]  ${edititemData2}[1]
#    click  ${submit}
#    i should see text on page  Transaction Edited SuccesFully

outward to JW Customer
    login
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Jobwork Customer
    select jobwork customer  Customer0604
    date entry
    set ith item in outward  0  ${itemData4}[0]  ${itemData4}[1]
    click  ${submit}
    click  ${newRequest}
    approve outward

outward to prod
    login
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Production
    select machine  WIP Section
    date entry
    set ith item in outward  0  ${itemData5}[0]  ${itemData5}[1]
    click  ${submit}
    click  ${newRequest}
    open trasactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Pending  1
    click  //div[@id = "item__tabs-panel-debit"]/div/div/div/div/div/div/div/div[2]/table/tbody/tr[2]/td[1]/div/span/a
    click  ${edit}
    edit ith item in outward  0  ${edititemData5}[0]  ${edititemData5}[1]
    click  ${submit}
    i should see text on page  Transaction Edited SuccesFully
    approve outward

W2W transfer
    login
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Other Warehouse
    select recipient warehouse  HARIDWAR-UNIT
    date entry
    set ith item in outward  0  ${itemData6}[0]  ${itemData6}[1]
    click  ${submit}
    click  ${newRequest}
    open trasactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Pending  1
    click  //div[@id = "item__tabs-panel-debit"]/div/div/div/div/div/div/div/div[2]/table/tbody/tr[2]/td[1]/div/span/a
    click  ${edit}
    edit ith item in outward  0  ${edititemData6}[0]  ${edititemData6}[1]
    click  ${submit}
    i should see text on page  Transaction Edited SuccesFully
    approve outward
    #approve w2w transaction  HARIDWAR-UNIT
    select site  haridwar_unit
    click  ${inwardTab}
    sleep  2
    inward tr status no method 2  Pending  1
    #wait until element is visible  //span[text() = "Item View"]
    inward approve number  1
    select inspector while TIN  Employee 2
    click  ${approveButton}
    i should see text on page  IQC approved SuccesFully
    sleep  2
    inward tr status no method 2  Approved  1

