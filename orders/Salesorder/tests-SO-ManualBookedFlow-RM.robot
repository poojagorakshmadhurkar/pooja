*** Settings ***
#Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Resource  ../../inventory/transactions/keywords.robot
#Resource  ../../variables.robot
Resource  ./variables.robot
Library  Browser

*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  50




*** Test Cases ***
Creation of SO
    login devsite
#    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible   timeout=30s
    #expand button
    Click  //span[@aria-label="Expand All"]
    #check itemsBom
    click  (//a[text()="${itemData1}[0]"])[1]
    sleep  1
    # Get the handles of all open tabs
    ${handles}    Get Page Ids
    # Switch to the new tab
    Switch Page       ${handles}[0]
    #expand button
    click  //button[@class='ant-switch ant-switch-small'][@role='switch']
    #Get Item Names
    ${item_elements}=    Get Elements        css=span.ant-tree-title
    ${items}=            Create List
     FOR    ${element}    IN    @{item_elements}
    ${text}=    Get Text    ${element}
    ${lines}=    Split String    ${text}    \n
    ${desired_text}=    Set Variable    ${lines}[0]
    Append To List    ${items}    ${desired_text}
    END
    ${item1}=    Get From List    ${items}    0
    ${item2}=    Get From List    ${items}    1
    ${item3}=    Get From List    ${items}    2
    Switch page        ${handles}[1]
    Wait For Elements State      //div[text()="${order_number}"]   visible    timeout=30s
    #manual Booking flow
    sleep   1
    open warehouse
    ${RMbookedQuanityitem1} =  Get current Quantity of Rawmaterail Booked Stock  ${item1}
    ${RMbookedQuanityitem2} =  Get current Quantity of Rawmaterail Booked Stock  ${item2}
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    click  ${bookedinventorybutton}
    click  ${bookrawmaterialtab}
    Wait For Elements State      //span[text()="${item1}"]/../../../../../../../../../../tr[3]//span[text()="${item2}"]   visible  timeout=60s
#    click  ${BookAllbutton}
    #input booking amount manully
#    Book Quantity If OnHand Greater Than Ordered  ${item1}
#    Book Quantity If OnHand Greater Than Ordered  ${item2}
    input  //span[text()="${item1}"]/../../../../../../../../../td[5]//input  ${itemData1}[1]
    input  //span[text()="${item2}"]/../../../../../../../../../td[5]//input  ${itemData1}[1]
    Click  //button[@type='submit']
    sleep  1
    #verifying booked amount in So
    click  ${rawmaterialtabso}
#    wait until element is visible    //a[text()="${item1}"]/../../../../../../../../../td[3][text()="${itemData1}[1] piece"]
#    wait until element is visible    //a[text()="${item2}"]/../../../../../../../../../td[3][text()="${itemData1}[1] piece"]
    open warehouse
    ${RMbookedQuanityitem3} =  Get current Quantity of Rawmaterail Booked Stock  ${item1}
    ${RMbookedQuanityitem4} =  Get current Quantity of Rawmaterail Booked Stock  ${item2}
    ${finalbookcurrentstockRM1}  Evaluate  eval("${RMbookedQuanityitem1}+${itemData1}[1]")
    Should Be Equal As Integers    ${RMbookedQuanityitem3}    ${finalbookcurrentstockRM1}
    ${finalbookcurrentstockRM2}  Evaluate  eval("${RMbookedQuanityitem2}+${itemData1}[1]")
    Should Be Equal As Integers    ${RMbookedQuanityitem4}    ${finalbookcurrentstockRM2}
    click  (//span[text()="${item2}"][1]/../../../../../../../../../td)[4]
    # Wait for the page to contain the order number
    Wait For Elements State    //a[text()="${order_number}"]  visible   timeout=10s
    # Wait for the element to be visible
    Wait For Elements State     //tr[@role="checkbox" and .//th[@scope="row"]/span[contains(text(),"${customername}[0]")] and .//a[contains(text(),"${ORDER_NUMBER}")] and .//td[contains(text(),"${itemData1}[1] piece")]]    visible  timeout=60s
    #Doing unbooked of booked Quantity
    click  //a[text()="${order_number}"]/../../../../../../../../../../../td[5]//button[@id="undefined__Unbook"]      #unbooking button
    I Should See Text On Page       Items unbooked successfully
    # verify in So wherther ist is unbooked
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    sleep  1
#    Wait For Elements State        //a[text()="${item2}"]/../../../../../../../../../td[3][text()="50 piece"]   visible    timeout=30s

 #unbooked flow   2nd raw materail
    open warehouse
    search rawmaterailname in warehouse  ${item1}
    click  (//span[text()="${item1}"][1]/../../../../../../../../../td)[4]
    # Wait for the page to contain the order number
     Wait For Elements State    //a[text()="${order_number}"]  visible   timeout=10s
    # Wait for the element to be visible
    Wait For Elements State      //tr[@role="checkbox" and .//th[@scope="row"]/span[contains(text(),"${customername}[0]")] and .//a[contains(text(),"${ORDER_NUMBER}")] and .//td[contains(text(),"${itemData1}[1] piece")]]    visible   timeout=60s
    #Doing unbooked of booked Quantity

    click   //a[text()="${order_number}"]/../../../../../../../../../../../td[5]//button[@id='undefined__Unbook']  #unbooking button
    I Should See Text On Page       Items unbooked successfully
    # verify in So wherther ist is unbooked

    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]

#    Wait For Elements State       //a[text()="${item1}"]/../../../../../../../../../td[3][text()="50 piece"]    visible  timeout=30s












