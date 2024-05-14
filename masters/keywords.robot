*** Settings ***
Library  SeleniumLibrary
Resource  ./././keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections


*** Variables ***
#Reports
@{reportsData}  report39  test39@gmail.com       #change data Here
@{editReportsData}  edit_reports47  Daily  edit_test47@gmail.com

#tagmanagement
@{tagsMangementData}  tagsMangement_test14

#Warehouse
@{warehouseNameData}  mainSite28      #change name here
@{linkedPartnersData}  Dixit
@{EditWarehouseData}  EditedMainSite17  Bajaj  Inward  Vendors  Validation of items

#fieldgroup
@{actionData}  Production Reports
@{fieldData}  Text Field  Document Field  Date  System Entity  List Field
@{editFieldGroupsData}

#customer    planning
@{CustomerData1}  Pooja197
@{CustomerData2}  Newpooj3635

#vendor    planning
@{VendorData2}  Newvendor209
@{VendorData1}  Vendor210  test25@gmail.com  test63address

#Site Sites
@{SiteData1}  poojafactory_47  Test47_addresss  test47@gmail.com   gstnumber5  #change name only
@{newSiteData}  poojafactory_48  edited address  Edited48@gmail.com

#Employee sites
@{EmployeeName}  Employeee_128  Planning  Supervisor  0809782736  poojaemail28@test.com     #for employee name firstletter is capital and other small
@{EditEmployeeName}  Employee_55  Admin  Manager  0809782755  test_email55@test.com

#Shift site
@{shiftData}  shift45  #change data here
@{editShiftData}  edited_shift46  05:00  07:00  15

#production
#Tools
@{labelName}  labelName34  1     #change name here
@{editToolsData}  editLabel35  1  editPart10

#Quality
@{qualityData}  newIssue30  abc  Planning  Medium     #change name here
@{EditQualityData}  editedIssue31  RM Group  Store  Low

#production forms
@{productionFormData}  productionForm23     #change name here
@{EditProductionFormData}  EditproductionForm24

#machine
@{MachineData1}  pencil01  Mixer12       #change name Here
@{ChildMachineData1}  Pen16  rubber21

#Downtime
@{DowntimeData}  Main_powerCut15
@{EditDowntimeData}  Powercut39  Admin  High  Material  Electronic

#Cycle Times Rule
@{cycleTimeRulesData1}  WIP Section  Bottle(FG)  WIRING  32
@{editCTR}  30

#itemcreation
@{itemData}  item-54  pencer54
@{editItemData}  item55  censor55

#item group
@{itemGroupData}  ItemGroupp26
@{edititemGroupData}  editItemGroupp27  Raw Material  gram