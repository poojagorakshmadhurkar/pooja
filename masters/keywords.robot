*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections


*** Variables ***
#Reports
@{reportsData}  report31  test10@gmail.com       #change data Here
@{editReportsData}  edit_reports40  Daily  edit_test11@gmail.com

#tagmanagement
@{tagsMangementData}  tagsMangement_test10

#Warehouse
@{warehouseNameData}  mainSite24      #change name here
@{linkedPartnersData}  Dixit
@{EditWarehouseData}  EditedMainSite13  Bajaj  Inward  Vendors  Validation of items

#fieldgroup
@{actionData}  Production Reports
@{fieldData}  Text Field  Document Field  Date  System Entity  List Field
@{editFieldGroupsData}

#customer    planning
@{CustomerData1}  Pooja099
@{CustomerData2}  Newpooj337777

#vendor    planning
@{VendorData2}  Newvendor115
@{VendorData1}  Vendor118  test17@gmail.com  test47address

#Site Sites
@{SiteData1}  poojafactory_32  Test32_addresss  test32@gmail.com   gstnumber4  #change name only
@{newSiteData}  poojafactory_34  edited address  Edited34@gmail.com

#Employee sites
@{EmployeeName}  Employeee_124  Planning  Supervisor  0809782124  poojaemail23@test.com     #for employee name firstletter is capital and other small
@{EditEmployeeName}  Employee_51  Admin  Manager  0809782751  test_email51@test.com

#Shift site
@{shiftData}  shift36  #change data here
@{editShiftData}  edited_shift37  05:00  07:00  15

#production
#Tools
@{labelName}  labelName24  1     #change name here
@{editToolsData}  editLabel25  1  editPart5

#Quality
@{qualityData}  newIssue24  abc  Planning  Medium     #change name here
@{EditQualityData}  editedIssue25  RM Group  Store  Low

#production forms
@{productionFormData}  productionForm17     #change name here
@{EditProductionFormData}  EditproductionForm18

#machine
@{MachineData1}  rinder05  kidder10       #change name Here
@{ChildMachineData1}  kidder15  rider20

#Downtime
@{DowntimeData}  Main_powerCut11
@{EditDowntimeData}  Powercut35  Admin  High  Material  Electronic

#Cycle Times Rule
@{cycleTimeRulesData1}  WIP Section  Bottle(FG)  WIRING  32
@{editCTR}  30

#itemcreation
@{itemData}  item-22  pencer22
@{editItemData}  item23  censor23

#item group
@{itemGroupData}  ItemGroupp18
@{edititemGroupData}  editItemGroupp19  Raw Material  gram