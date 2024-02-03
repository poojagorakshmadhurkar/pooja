*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Library  DateTime

*** Keywords ***
open transactions page
#    login
    click  ${inventoryDropdown}
    sleep  1
    click  ${inventoryTransactions}
    sleep  1

select warehouse
    [Arguments]  ${warehouseName}
    click  ${selectWarehouseDropdown}
    click  //span/span/span/span/span/span[text() = "${warehouseName}"]

select item type
    [Arguments]  ${itemType}
    click  ${itemTypeDropdown}
    click  //span/span/span/span/span/span[text() = "${itemType}"]

select inspector
    [Arguments]  ${inspector}
    click  ${inspectedByDropdown}
    click  //div[@title = "${inspector}"]/div[text() = "${inspector}"]

select inspector while TIN
    [Arguments]  ${inspector}
    click  ${inspectedByDropdownTIN}
    click  //div[@title = "${inspector}"]/div[text() = "${inspector}"]

select partner
    [Arguments]  ${partner}
    input  ${partnerDropdown}  ${partner}
    click  //div[text() = "${partner}"]

set ith item in inward
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    click  //input[@id = "credit__details__${i}__sku"]/../../span[2]
    input  //input[@id = "credit__details__${i}__sku"]  ${recievedName}
    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  10
    click  //*[text() = "${recievedName}"]
    sleep  1
    input  (//input[@id = "credit__details__${i}__quantity"])  ${recievedQuantity}
    press keys  (//input[@id = "credit__details__${i}__quantity"])  TAB
    sleep  1

edit inward entry
    [Arguments]  ${i}  ${newItemName}  ${newItemQuantity}
    press keys  //input[@id = "credit__details__${i}__sku"]  CTRL+A  BACKSPACE  ${newItemName}
    sleep  1
    press keys  //input[@id = "credit__details__${i}__sku"]  ENTER
    sleep  1
    press keys  (//input[@id = "credit__details__${i}__quantity"])  CTRL+A  BACKSPACE  ${newItemQuantity}
    sleep  1

set ith item in outward
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    click  //input[@id = "debit__details__${i}__sku"]/../../span[2]
    input  //input[@id = "debit__details__${i}__sku"]  ${recievedName}
    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  10
    click  //*[text() = "${recievedName}"]
    sleep  1
    click  (//input[@id = "debit__details__${i}__quantity"])/..
    press keys  (//input[@id = "debit__details__${i}__quantity"])  ${recievedQuantity}
    sleep  1
    press keys  (//input[@id = "debit__details__${i}__quantity"])  TAB

edit ith item in outward
    [Arguments]  ${i}  ${newItemName}  ${newItemQuantity}
    press keys  //input[@id = "debit__details__${i}__sku"]  CTRL+A  BACKSPACE  ${newItemName}
    sleep  1
    press keys  //input[@id = "debit__details__${i}__sku"]  ENTER
    sleep  1
    press keys  (//input[@id = "debit__details__${i}__quantity"])  CTRL+A  BACKSPACE  ${newItemQuantity}
    sleep  1
set ith item in Lot case
    [Arguments]  ${i}  ${itemData}
    #click  (//button[@aria-label = "Open"]/../../input)[${i}]
    input  //input[@id = "credit__details__${i}__sku"]  ${itemData}[0]
    press keys  //input[@id = "credit__details__${i}__sku"]  ENTER
    sleep  1
    input  (//input[@id = "credit__details__0__${i}__sku"])  ${itemData}[1]
    #input  (//input[@type = "number"])[${i}]  ${itemData}[2]---lot slot id

set ith item in costing
    [Arguments]  ${i}  ${itemData}
    input  //input[@id = "credit__details__${i}__sku"]  ${itemData}[0]
    press keys  //input[@id = "credit__details__${i}__sku"]  ENTER
    sleep  1
    input  //input[@id = "credit__details__${i}__quantity"]  ${itemData}[1]
    input  //input[@id = "credit__details__${i}__cost"]  ${itemData}[2]

packSize outward
    [Arguments]  ${i}  ${itemmData}  ${packkSize}
    #click  (//button[@aria-label = "Open"]/../../input)[${i}]
    input  (//button[@aria-label = "Open"]/../../input)[${i}]  ${itemmData}[0]
    press keys  (//button[@aria-label = "Open"]/../../input)[${i}]  ENTER
    sleep  1
    wait until page contains  Available in packs of ${packkSize} kg
    #element should be visible  //input[@value = "${itemData}[0]"]
    #element should be enabled  (//input[@type = "number"])[${i}]
    #click  (//input[@type = "number"])[${i}]
    input  (//input[@type = "number"])[${i}]  ${itemmData}[1]

min packSize outward
    [Arguments]  ${i}  ${itemmmData}  ${packkSize}
    #click  (//button[@aria-label = "Open"]/../../input)[${i}]
    input  (//button[@aria-label = "Open"]/../../input)[${i}]  ${itemmmData}[0]
    press keys  (//button[@aria-label = "Open"]/../../input)[${i}]  ENTER
    sleep  1
    wait until page contains  Available in packs of ${packkSize} kg
    #element should be visible  //input[@value = "${itemData}[0]"]
    #element should be enabled  (//input[@type = "number"])[${i}]
    #click  (//input[@type = "number"])[${i}]

add new lot
    [Arguments]  ${i}
    click  (//button[@aria-label = "new reason"])[${i}]

set ith item in multiple Lot case
    [Arguments]  ${i}  ${firstIteratedI}  ${itemData}
    #click  (//button[@aria-label = "Open"]/../../input)[${i}]
    input  //input[@id = "credit__details__${i}__sku"]  ${itemData}[0]
    press keys  //input[@id = "credit__details__${i}__sku"]  ENTER
    sleep  1
    #element should be visible  //input[@value = "${itemData}[0]"]
    #element should be enabled  (//input[@type = "number"])[${i}]
    #click  (//input[@type = "number"])[${i}]
    input  (//input[@id = "credit__details__0__${i}__sku"])  ${itemData}[1]
    add new lot  1
    input  (//input[@id = "credit__details__0__${firstIteratedI}__sku"])  ${itemData}[2]
    #input  (//input[@type = "number"])[${i}]  ${itemData}[2]---lot slot id

rejection reason
    [Arguments]  ${rejReason}  ${itemname}  ${rejQuantity}
    input  //div[contains(@id, 'rejection')and(@role="tabpanel")]//span[text()="${itemname}"]/../../../../div[3]//input[contains(@id, 'reason')and(@type="search")]  ${rejReason}
    #input  //input[@id = "credit__rejections__0__${i}__reason"]  ${rejReason}
    press keys  //div[contains(@id, 'rejection')and(@role="tabpanel")]//span[text()="${itemname}"]/../../../../div[3]//input[contains(@id, 'reason')and(@type="search")]  ARROW_DOWN  ENTER
    sleep  2
    input  //div[contains(@id, 'rejection')and(@role="tabpanel")]//span[text()="${itemname}"]/../../../../div[3]//input[contains(@id, 'quantity')and(@role="spinbutton")]  ${rejQuantity}
#    press keys  //input[@id = "credit__rejections__0__${i}__quantity"]  ENTER

select outward to
    [Arguments]  ${outwardTo}
    click  ${outwardToDropdown}
    click  //span/span/span/span/span/span[text() = "${outwardTo}"]

select outward customer to
    [Arguments]  ${outwardCustomerTo}
    click  ${outwardCustomerToDropdown}
    click  //div[text() = "${outwardCustomerTo}"]

select recipient warehouse
    [Arguments]  ${toutWarehouse}
    #click  ${reciepientWarehouseDropdown}
    press keys  ${reciepientWarehouseDropdown}  ${toutWarehouse}
    #scroll element into view  //span/span/span/span/span/span/span/span[text() = "${toutWarehouse}"]
    click  //span/span/span/span/span/span/span/span[text() = "${toutWarehouse}"]

site should be added
    [Arguments]  ${siteName}
    wait until element is visible  //table/tbody/tr/th/span[text() = "${siteName}"]
    element should be visible  //table/tbody/tr/th/span[text() = "${siteName}"]

inward approve number
    [Arguments]  ${i}
    click  (//div[@id='item__tabs-panel-credit']//button[@aria-label= "Approve"][1])[${i}]
    sleep  1

outward approve number
    [Arguments]  ${i}
    click  (//div[@id='item__tabs-panel-debit']//button[@aria-label= "Approve"][1])[${i}]
    sleep  1

open outward tr note
    [Arguments]  ${i}
    click  //div[@id='item__tabs-panel-debit']//tr[${i}+1]//td[2]
    sleep  1

open inward tr note
    [Arguments]  ${i}
    click  //div[@id='item__tabs-panel-credit']//tr[${i}+1]//td[2]
    sleep  1

inward transaction search through GRN
    [Arguments]  ${GRN}
    click  (//div[@id = "item__tabs-panel-credit"]//span[@role='button'])[1]
    input  //input[@placeholder='Search GRN']  ${GRN}
    press keys  //input[@placeholder='Search GRN']  ENTER
    sleep  1

outward transaction search through GRN
    [Arguments]  ${MIN}
    click  (//div[@id = "item__tabs-panel-debit"]//span[@role='button'])[1]
#    Wait Until Element Is Visible  (//input[@placeholder='Search Material Issue Note'])[1]
    input  //input[@placeholder='Search Material Issue Note']  ${MIN}
    press keys  //input[@placeholder='Search Material Issue Note']  ENTER
    sleep  1

approve outward
    open trasactions page
    sleep  2
    click  ${outwardTab}
    outward tr status no method 2  Pending  1
    outward approve number  1
    i should see text on page  MRN approved SuccesFully
    sleep  2
    outward tr status no method 2  Approved  1

approve outward rack case
    open trasactions page
    sleep  2
    click  ${outwardTab}
    outward tr status no method 2  Pending  1
    outward approve number  1
    click  ${approveRequest}
    i should see text on page  MRN approved SuccesFully
    sleep  2
    outward tr status no method 2  Approved  1

approve w2w transaction
    [Arguments]  ${warehouseName}
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
    click  ${outwardTab}
    click  ${1stapprove}
    #click  $((//td[text() = "${warehouseName}"]/../td)[6]/div/button)[2]

select jobwork vendor
    [Arguments]  ${jobworkVendorName}
    press keys  ${jobworkVendorDropdown}  ${jobworkVendorName}
    #click  //span/span/span/span/span/span[text() = "${jobworkVendorName}"]
    click  //div[text() = "${jobworkVendorName}"]/..

select jobwork customer
    [Arguments]  ${jobworkCustomerName}
    press keys  ${jobworkCustomerDropdown}  ${jobworkCustomerName}
    click  //div[text() = "${jobworkCustomerName}"]/..

#aprrove outward to JW
#    [Arguments]  ${jobworkVendorName}
#    click  ${inventoryDropdown}
#    click  ${inventoryTransactions}
#    click  ${outwardTab}
#    wait until page contains  Partner  10
#    #click  $((//td[text() = "${jobworkVendorName}"]/../td)[6]/div/button)[2]
#    click  //td[text() = "Darshan Service Provider"]
#    sleep  3
#    click  //h5[text() = "Transactions"]
#    sleep  2
#    click  ${1stapprove}
#    i should text on page  MRN approved SuccesFully

select machine
    [Arguments]  ${machineName}
    press keys  ${machineDropdown}  ${machineName}
    click  //span[text() = "${machineName}"]
#
#aprrove outward to prod
#    [Arguments]  ${machineName}
#    click  ${inventoryDropdown}
#    click  ${inventoryTransactions}
#    reload page
#    click  ${outwardTab}
#    click  $((//td[text() = "${machineName}"]/../td)[6]/div/button)[2]


TIN approve
    click  ${approveButton}
    i should see text on page  IQC approved SuccesFully

aprrove request
    [Arguments]  ${i}
    click  (//button[@id = "Transactions__Approve"])[${i}]

#return request
#    [Arguments]  ${i}
#    click  //tbody/tr[1]/td[8]/div/button[@id = "Transactions__Return"]
racking
    [Arguments]  ${i}
    ${number_text}=    Get Text    //span[text() = "Item Code"]/../../../../div[2]/div[${i}]/div/div/div/span[2]
    ${number}=    Evaluate    int(''.join(filter(str.isdigit, "${number_text}")))
    Return From Keyword    ${number}

racking approval
    [Arguments]  ${r}  ${rackQuantity}
    press keys  //input[@id = "credit__racking__${r}__0__rack"]  ARROW_DOWN  ENTER

    input  //input[@id = "credit__racking__${r}__0__quantity"]  ${rackQuantity}

open warehouse
    click  ${inventoryDropdown}
    click  ${inventoryWarehouses}
    wait until page contains  Live Inventory

open trasactions page
    click  ${inventoryDropdown}
    click  //a[text()="Transactions"]


item onhand stock
    [Arguments]  ${itemName}
    search name in warehouse  ${itemName}
    scroll element into view  //span[text() = "${itemName}"]
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[6]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    [Return]  ${integer_value}

item current stock
    [Arguments]  ${itemName}
    search name in warehouse  ${itemName}
    scroll element into view  //span[text() = "${itemName}"]
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[3]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    [Return]  ${integer_value}

item current stock for Rackcase
    [Arguments]  ${itemName}
    search name in warehouse  ${itemName}
    scroll element into view  //span[text() = "${itemName}"]
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[4]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    [Return]  ${integer_value}

search name in warehouse
    [Arguments]  ${itemName}
    click  ${RMItemFilter}
    click  ${RMitemName}
    press keys  ${RMitemName}  CTRL+A  BACKSPACE
    input  ${RMitemName}  ${itemName}
    press keys  ${RMitemName}  ENTER
    wait until page contains element  //span[text() = "${itemName}"]  10

No live inventory check
    [Arguments]  ${itemName}
    click  ${inventoryDropdown}
    click  ${inventoryWarehouses}
    wait until page contains  Live Inventory
    search name in warehouse  ${itemName}
    ${noStock}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[6]
    Run Keyword If  '${noStock}'  ==  ''

item current stock for scraps
    [Arguments]  ${itemName}
    scroll element into view  //span[text() = "${itemName}"]
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/../../../../../../../../../../td[2]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    [Return]  ${Quantity_number}


item new stock
    [Arguments]  ${itemName}
    ${newQuantity_S}  Get Text  (//span[text() = "${itemName}"]/../../../../../../../../../../td)
    ${newQuantity}  Evaluate  ''.join(c for c in "${newQuantity_S}" if c.isdigit())
    [Return]  ${newQuantity}

item new stock for scraps
    [Arguments]  ${itemName}
    ${newQuantity_S}  Get Text  (//span[text() = "${itemName}"]/../../../../../../../../../../td)
    ${newQuantity}  Evaluate  ''.join(c for c in "${newQuantity_S}" if c.isdigit())
    [Return]  ${newQuantity}

open item page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersItems}

outward entry for shortage
    [Arguments]  ${i}  ${itemName}  ${itemstockValue}
    input  (//button[@aria-label = "Open"]/../../input)[${i}]  ${itemName}[0]
    press keys  (//button[@aria-label = "Open"]/../../input)[${i}]  ENTER
    sleep  1
    input  (//input[@type = "number"])[${i}]  ${save} +1


Conversion return
    [Arguments]  ${i}  ${ItemName}  ${ItemQuantity}
    select option from dropdown using span  //th[text() = "Total Quantity"]/../../../tbody/tr[${i}]/td/div/div/span[2]  ${ItemName}
    input  (//th[text() = "Total Quantity"]/../../../tbody/tr[${i}]/td)[2]/span/span/input  ${ItemQuantity}

#Defining Auto rack
#    [Arguments]  ${itemName}
#    scroll element into view  //a[text() = "${itemName}"]
#    click  //a[text() = "${itemName}"]/..
#    click  ${edit}
#    click  //div[text() ="Racks"]/../..
#    ${quantityS}  Get Text  //span[text() = "${itemName}"]/../../../../../../../../../../td[2]
#    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
#    [Return]  ${Quantity_number}
date entry
    sleep  1
    ${today1}    Get Current Date  result_format=%d-%m-%Y
#    ${today1}=    Evaluate    datetime.datetime.now().strftime('%d-%m-%Y')
#    Log To Console    Current Date: ${today1}
#    BuiltIn.Sleep    1
    click  ${dateOutward}
    input  ${dateOutward}  ${today1}
    sleep  1
    press keys  ${dateOutward}  ENTER
    sleep  1

Defining Auto rack
    [Arguments]  ${i}  ${rackName}
    click  //input[@id = "item__rack_${i}"]/../..
#    select option from dropdown might be used
#    scroll element into view  //span[text() = "${rackName}"]
    click  //span[text() = "RAC/1"]/..
#
#edit inward entry
#    select inspector  Adam Baur1
#    press keys  ${invoiceNumber}  CTRL+BACKSPACE
#    edit ith item  0  ${edititemData1}[0]  ${edititemData1}[1]
#    edit ith item  1  ${edititemData2}[0]  ${edititemData2}[1]
#    edit ith item  2  ${edititemData3}[0]  ${edititemData3}[1]
#inward data entry
#    select inspector  Abhinav Kaul
##    ${randomGrn}=  generate random string  5-10  [NUMBERS]
##    press keys  ${grnNumber}  CTRL+BACKSPACE
##    input  ${grnNumber}  ${randomGrn}
#    select partner  Newvendor_10
#    select partner  Dixit
#    input  ${invoiceNumber}  inv1001
#    set ith item  0  ${itemData1}[0]  ${itemData1}[1]
#    set ith item  1  ${itemData2}[0]  ${itemData2}[1]
#    set ith item  2  ${itemData3}[0]  ${itemData3}[1]

#outward tr status no
#    [Arguments]  ${status}  ${i}
##    ${fetch_status}=  Get Text  //tbody/tr[2]/td[9]/span
#    ${fetch_status}=  Get Text  //div[@id = "item__tabs-panel-debit"]/div/div/div/div/div/div/div/div[2]/table/tbody/tr[${i}+1]/td[7]/span
##    open outward tr note  ${i}
##    ${fetch_status}=  Get Text  //span[text() = "Shipment"]/../../../../../../../div/div/p/span
#    Should Be Equal As Strings    ${fetch_status}    ${status}
#    sleep  1
#
#inward tr status no
#    [Arguments]  ${status}  ${i}
##    ${fetch_status}=  Get Text  //tbody/tr[2]/td[9]/span
#    ${fetch_status}=  Get Text  //div[@id = "item__tabs-panel-credit"]/div/div/div/div/div/div/div/div[2]/table/tbody/tr[${i}+1]/td[7]/span
##    open inward tr note  ${i}
##    ${fetch_status}=  Get Text  //span[text() = "Inward Request"]/../../../../../../../div/div/p/span
#    Should Be Equal As Strings    ${fetch_status}    ${status}
#    sleep  1

inward tr status no method 2
    [Arguments]  ${status}  ${i}
    Wait Until Page Contains Element  //div[@id = "item__tabs-panel-credit"]//tr[${i}+1]//span[text() = "${status}"]  10

outward tr status no method 2
    [Arguments]  ${status}  ${i}
    Wait Until Page Contains Element  //div[@id = "item__tabs-panel-debit"]//tr[${i}+1]//span[text() = "${status}"]  10

Return request
    [Arguments]  ${i}
    ${totalQuantity}  Get Text  //span[text() = "Item"]/../../../../tbody/tr[${i}]/td[2]/span/span/input

return confirmation
    [Arguments]  ${againstGrn}
    ${expectedGrn}  Get Text  //span[text() = "Against"]/../span[2]
    Should Be Equal As Strings  ${againstGrn}  ${expectedGrn}
    ${RCR}  Get Text  //*[@data-testid = "PrintOutlinedIcon"]/../../../div[1]/a[1]
    [Return]  ${RCR}

#Gain in quantity
    #${increment1}  Set Variable  ${itemData1}[1]-${itemData1}[2]
    #${increment_main1}  Evaluate  eval("${increment1}")
    #[RETURN}  ${increment_main1}

#Loss in quantity
   # [Arguments]  ${value1}  ${value2}
   # ${increment1}  Set Variable  ${itemData1}[1]-${itemData1}[2]
   # ${increment_main1}  Evaluate  eval("${increment1}")
   # [RETURN}  ${increment_main1}