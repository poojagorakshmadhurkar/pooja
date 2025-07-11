*** Settings ***
Library  SeleniumLibrary
Resource  ./././keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections


*** Variables ***
#Reports
#@{reportsData}  report55  test55@gmail.com       #change data Here
#@{editReportsData}  edit_reports56  Daily  edit_test56@gmail.com

#tagmanagement
#@{tagsMangementData}  tagsMangement_test20

##Warehouse
#@{warehouseNameData}  mainSite41      #change name here
#@{linkedPartnersData}  Dixit
#@{EditWarehouseData}  EditedMainSite42  Bajaj  Inward  Vendors  Validation of items

##fieldgroup
#@{actionData}  Production Reports
#@{fieldData}  Text Field  Document Field  Date  System Entity  List Field
#@{editFieldGroupsData}

#customer    orders
#@{CustomerData1}  Pooja19019
#@{CustomerData2}  Newpooja0387890

#vendor    orders
#@{VendorData2}  Newvendor02784834
#@{VendorData1}  Vendor27  test28@gmail.com  test82address

##Site Sites
#@{SiteData1}  poojafactory_62  Test58addresss  test62@gmail.com   gstnumber6  #change name only
#@{newSiteData}  poojafactory_63  edited address  Edited63@gmail.com

##Employee sites
#@{EmployeeName}  Employeee_136  Planning  Supervisor  0809781136  poojaemail36@test.com     #for employee name firstletter is capital and other small
#@{EditEmployeeName}  Employee_62  Admin  Manager  0809782662  test_email62@test.com

##Shift site
#@{shiftData}  shift59  #change data here
#@{editShiftData}  edited_shift60  05:00  07:00  15

#production
#Tools
#@{labelName}  labelName49  1     #change name here
#@{editToolsData}  editLabel50  1  editPart17

#Quality
#@{qualityData}  newIssue43  Rawmaterial  Planning  Medium     #change name here
#@{EditQualityData}  editedIssue44  RM Group  Store  Low

#production forms
#@{productionFormData}  productionForm35     #change name here
#@{EditProductionFormData}  EditproductionForm36

#machine
@{MachineData1}  mnsfdjkn01  ljabbem12       #change name Here
@{ChildMachineData1}  loemdnjn16  jnjnwjenk21

##Downtime
#@{DowntimeData}  Main_powerCut21
#@{EditDowntimeData}  Powercut45  Admin  High  Material  Electronic

##Cycle Times Rule
#@{cycleTimeRulesData1}  WIP Section  Bottle(FG)  WIRING  32
#@{editCTR}  30

#itemcreation
#@{itemData}  item-70  poiuiio
#@{editItemData}  item71  bjhbhb

##item group
#@{itemGroupData}  ItemGroupp41
#@{edititemGroupData}  editItemGroupp42  Raw Material  gram