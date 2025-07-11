*** Settings ***
Library   Browser
Library   DateTime
Library   String
Library   Collections
Resource   ../orders/PurchaseOrder/keyword.robot
Resource   ../orders/PurchaseOrder/variable.robot
*** Variables ***
${Scheduling_1}  //ul[@id="menu-list-grow"]//a[@id="machine_scheduling"]
${Manuf_Logo}   //img[@class="header_logo__OwsGs"]
${Create_DT_Machine}   //*[text()="Work_Order_Machine"]//following::button[@id="create_downtime_0"]
${Enter_Downtime_Reason}   (//*[@class="ant-select-selection-search-input"])[4]
${No_Plann}   //*[text()="NO-PLAN"]
${Power Cut}   //*[text()="Power Cut"]
${Start_time_Select}   //*[@placeholder="Start Time"]
${Slect_Current_Date}   //*[@class="ant-picker-cell ant-picker-cell-in-view ant-picker-cell-today"]
${Click_OK}   //*[text()="OK"]
${Start_time_input}   //input[@placeholder='Start Time']
${Enter_Date}   //input[@placeholder="Select date"]
${Today}   //*[text()="Today"]
${Submit_DT}   //*[@type="submit"]
${Once}   (//Span[text()="Once"])[1]
${Delete_DT_Msg}    (//div[text()='Event Deleted Successfully']/following-sibling::div)[1]
${DT_Creation_MSG}    //*[text()="Event Created Successfully"]
${Yearly}   //span[text()="Yearly"]
${Weekly}   //span[text()="Weekly"]
${Monthly}   //span[text()="Monthly"]
${Daily}   //span[text()="Daily"]
${DT_Duration_InputBox}   (//input[@class="ant-select-selection-search-input"])[5]
${Total_DT_Value}    //div[@style="width: 100%; padding-top: 4px; font-size: 13px; text-align: right;"]
${Click_DT_For_ALL_Machine}   //button[@id="create_downtime"]
${Select_DT_For_ALL_Machine}   (//*[@class="ant-checkbox-input"])[1]
${Continue_DT}   //*[@class="ant-space-item"]
${Selected_Machine_Count}   //div[text()='Downtime Planning ']/following-sibling::div
${Delete_DTM}  //button[@aria-label='Delete Downtime']









