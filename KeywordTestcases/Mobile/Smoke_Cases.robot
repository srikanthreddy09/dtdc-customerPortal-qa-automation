*** Settings ***
Resource          ../../Config/super.robot

*** Test Cases ***
TC_01 C7271 log in and log out
    [Tags]    android    ios    test_case_id=7271    test_case_id=7271
    Comment    Launch and login to Mobile Application
    Log    Step1: open the app
    Log    Step2: enter the credentials
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    Comment    Validate Navigation Tabs are Displayed
    Log    Step3: wait till the app load and click in the Settings button in right top corner
    Wait For Loader to Disappear
    Validate Navigation Tabs are Displayed
    Log    Successfully Validated Navigation Tabs. They are displayed properly,
    Comment    login_page.Logout From the Application
    Log    Step4: click in Logout option
    Logout From the Application and Validate
    Log    The app close the account credentials and shows up the log in screen

TC_02 C7335 Property filter on Tasks page
    [Tags]    android    ios    test_case_id=7335    test_case_id=7335
    Comment    Launch and login to Mobile Application
    Log    Step1: Launch the latest beta build
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    Comment    Click on Tasks Tab
    Log    Step2: Navigate to Tasks page and click the Filter button
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    ${workflow_data}=    mobile_common.Read TestData From Excel    C7335    Work_Flow
    Select Property in Mobile    ${workflow_data}[Default Property]
    Log    Selected Property - ${workflow_data}[Default Property]
    Click on Apply button
    Log    Read test data for Property
    Comment    Click on Filter icon
    Log    Step3: Change the property and apply the filter
    Click on Filter icon
    Log    Clicked on "Filter" icon
    Comment    Select Property
    mobile_common.Select Property    ${workflow_data}[Default Property]
    Log    Selected Property - ${workflow_data}[Default Property]
    Comment    Click on Apply button
    Log    Step4: Observe the attachment
    Click on Apply button
    Log    Clicked on the "Apply" button
    Comment    Validate Selected Property
    Validate Selected Property    ${workflow_data}[Default Property]
    Log    Property - ${workflow_data}[Default Property] successfully displayed.

TC_03 C7321 Create work order
    [Tags]    android    ios    test_case_id=7321    test_case_id=7321
    Comment    Launch and login to Mobile Application
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${workorder_details}=    mobile_common.Read TestData From Excel    C7321    Work_Order
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${workorder_details}[Default Property]
    Log    Selected Property - ${workorder_details}[Default Property]
    Click on Apply button
    Log    Step2: Click on menu button
    Log    Step3: Go to Work Orders on upper menu
    Select Task Type    Work Orders
    Log    Navigated to Work Orders Tab
    Comment    Click on plus icon
    Log    Step4: Click Plus button - Create new order
    Click on plus icon
    Log    Clicked on the Plus icon toass WorkOrder
    Comment    Enter Workorder details in the mobile
    Log    Step5: Fill in all requiired fields and click Save button
    ${work_order_name}    Enter Workorder details in the mobile    ${workorder_details}
    Log    WorkOrder is created with brief description - ${work_order_details}[Brief_description]
    Validate the Created WorkOrder on Mobile    ${work_order_name}
    Log    ${work_order_name} - workorder is displayed successfully.

TC_04 C7322 Edit work order
    [Tags]    android    ios    test_case_id=7322    test_case_id=7322
    Comment    Launch and login to Mobile Application
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${workorder_details}    mobile_common.Read TestData From Excel    C7322    Work_Order
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${workorder_details}[Default Property]
    Log    Selected Property - ${workorder_details}[Default Property]
    Click on Apply button
    Log    Step2: Click on menu button
    Log    Step3: Go to Work Orders on upper menu
    Select Task Type    Work Orders
    Log    Navigated to Work Orders Tab
    Comment    Click on plus icon
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Comment    Enter Workorder details in the mobile
    ${work_order_name}    Enter Workorder details in the mobile    ${workorder_details}
    Log    WorkOrder is created with brief description - ${work_order_details}[Brief_description]
    Validate the Created WorkOrder on Mobile    ${work_order_name}
    Log    ${work_order_name} - workorder is displayed successfully.
    Log    Edit Work Order in Mobile
    Log    Step4: Swipe left work order and click on Blue icon (edit work order)
    Log    Step5: Edit work order data and click Save button
    Edit Work Order in Mobile    ${work_order_name}
    Log    Edit Status For A Workflow
    ${edit_workorder_details}    mobile_common.Read TestData From Excel    C7322_01    Work_Order
    Log    Edit work order Read test data.
    Select Status For A Workflow    ${edit_workorder_details}[Status]
    Log    Selected Status - ${edit_workorder_details}[Status] from the Status drop down
    Click on Save
    Log    Clicked on Save button
    Validate the Created WorkOrder on Mobile    ${work_order_name}    ${edit_workorder_details}[Status]
    Log    ${work_order_name} - workorder is displayed in ${edit_workorder_details}[Status] - status.

TC_05 C7323 Complete work order task
    [Tags]    android    ios    test_case_id=7323    test_case_id=7323
    Comment    Launch and login to Mobile Application
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${workorder_details}    mobile_common.Read TestData From Excel    C7323    Work_Order
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${workorder_details}[Default Property]
    Log    Selected Property - ${workorder_details}[Default Property]
    Click on Apply button
    Log    Step2: Click on menu button
    Log    Step3: Go to Work Orders on upper menu
    Select Task Type    Work Orders
    Log    Navigated to Work Orders Tab
    Comment    Click on plus icon
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Comment    Enter Workorder details in the mobile
    Log    Step4: Swipe left work order and click on Green icon (complete work order)
    ${work_order_name}    Enter Workorder details in the mobile    ${workorder_details}
    Log    WorkOrder is created with brief description - ${work_order_details}[Brief_description]
    Validate the Created WorkOrder on Mobile    ${work_order_name}
    Log    ${work_order_name} - workorder is displayed successfully.
    Log    Edit Work Order in Mobile
    Log    Step5: Fill all required fields and click complete
    Edit Work Order in Mobile    ${work_order_name}
    Log    Edit Status For A Workflow
    ${edit_workorder_details}    mobile_common.Read TestData From Excel    C7323_01    Work_Order
    Log    Edit work order Read test data.
    Select Status For A Workflow    ${edit_workorder_details}[Status]
    Log    Selected Status - ${edit_workorder_details}[Status] from the Status drop down
    Click on Save
    Log    Clicked on Save button
    Validate the Created WorkOrder on Mobile    ${work_order_name}    ${edit_workorder_details}[Status]
    Log    ${work_order_name} - workorder is displayed in ${edit_workorder_details}[Status] - status.
    Log    ER: When completing WO user can set status (On Call, Scheduled, in Progress, Completed, Cancelled) and it will be shown in accurate tab on mobile

TC_06 C7349 Creating new task with attachment
    [Tags]    android    ios    test_case_id=7349    test_case_id=7349
    Comment    Launch and login to Mobile Application
    Log    Step1: Log in to Leonardo app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7349    Task_Form
    Comment    Click on Tasks Tab
    Log    Step2: Switch to Tasks page
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Comment    Click on plus icon
    Log    Step3: Click + icon to create new task
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    Log    Step4: Fill all required fields
    Log    Step5: Click Attach File icon
    Log    Step6: Attach different file types (.doc, .docx, .txt, .pdf, .jpg, .gif, .png, .xls, .xlsx)
    Log    Step7: Click Submit
    ${task_name}    Enter New Task Details    ${task_details}
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    Validate Created Task on Tasks Page
    Validate Created Task on Tasks Page    ${task_name}
    Log    ${task_name} - The Created Task is displayed successfully.

TC_07 C7267 assign user
    [Tags]    android    ios    test_case_id=7267    test_case_id=7267
    Comment    Launch and login to Mobile Application
    Log    Step1: Login to mobile app
    Log    Step1: log in to leonardo app
    Login to Mobile Application    ${APPROVAL_USER_NAME}    ${APPROVAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7267    Task_Form
    Comment    Click on Tasks Tab
    Log    Step2: Click on menu button
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${task_name}    Enter New Task Details    ${task_details}
    Log    ${task_name} - Task is Created Successfully.
    Open The Task under Status Bar    Daily
    Log    ${task_name} - The Created Task is displayed successfully.
    Log    Step3: Swipe task to right and click Asssign user button (dark blue)
    Swipe On The Task To Perform The Action    ${task_name}    right
    Log    Did swipe on the ${task_name} - Task
    Log    Click on Assign User On a Task
    Click on Assign User On a Task    ${task_name}
    Log    Clicked on Assign User icon on ${task_name} Task.
    Log    Step4: select one of the users (if they're multiple users) and click Assign button
    Log    Step5: click in assign user.
    Assign User to a Task    ${task_details}[Assign_user]
    Log    ${task_details}[Assign_user] - User has been assigned.
    Click on Assign User Button
    Log    Clicked on Assign User button
    Validate Assigned User for a Task    ${task_details}[Validate_user]
    Log    Validated assigned ${task_details}[Validate_user] - user successfully.

TC_08 C7268 leave a note
    [Tags]    android    ios    test_case_id=7268    test_case_id=7268
    Comment    Launch and login to Mobile Application
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7268    Task_Form
    Comment    Click on Tasks Tab
    Log    Step2: Click on menu button
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${task_name}    Enter New Task Details    ${task_details}
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    ${task_name} - The Created Task is displayed successfully.
    Log    Step3: Swipe task to right and click Leave note button (light blue)
    Swipe On The Task To Perform The Action    ${task_name}    right
    Log    Did swipe on the ${task_name} - Task
    Log    Click on Add Note For a Task
    Log    Step4: click on leave a note
    Click on Add Note For a Task    ${task_name}
    Log    Enter Note For a Task
    Log    Step5: write a note and attach a photo
    Enter Note For a Task    ${task_details}
    Log    Click on Button
    Log    Step6: click in "leave a note"
    Click on Button    Leave a Note
    Log    Validate Added Comments for a Task
    Validate Added Comments for a Task    ${task_name}    ${task_details}[Note]
    Log    Added ${task_details}[Note] - Task Note is displayed successfully.

TC_09 C7269 cannot do option
    [Tags]    android    ios    test_case_id=7269    test_case_id=7269
    Comment    Launch and login to Mobile Application
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7269    Task_Form
    Comment    Click on Tasks Tab
    Log    Step2: Click on menu button
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${task_name}    Enter New Task Details    ${task_details}
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    ${task_name} - The Created Task is displayed successfully.
    Log    Step3: slide the task to the left
    Swipe On The Task To Perform The Action    ${task_name}
    Log    Did swipe on the ${task_name} - Task
    Log    Click on Cannot Do Image on a Task
    Log    Step4: click in red button ("cannot do button)
    Click on Cannot Do Image on a Task    ${task_name}
    Log    Enter Note For a Task
    Log    Step5: leave a note, attach an image,
    Enter Note For a Task    ${task_details}
    Log    Click on Cannot Do Button On a Task
    Log    Step6: click in "cannot do" red button
    Click on Button    Cannot Do
    Log    Click on Cannot Do Button On a Task
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Cannot Do
    Log    Validate Created Task on Tasks Page
    Validate Created Task on Tasks Page    ${task_name}
    Log    ${task_name} - and All changes and the note is displayed properly.

TC_10 C7272 change password
    [Tags]    android    ios    test_case_id=7272    test_case_id=7272
    Comment    Launch and login to Mobile Application
    Log    Step1: log in in the app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    Log    Select Navigation More Tab
    home_page.Select Navigation Tab    More
    Log    Click On Settings Icon
    Log    Step2: Click on Settings button in top right corner
    Click On Settings Icon
    Log    Clicked on Settings Icon
    Log    Click on Change Password
    Log    Step3: click in "change your password"
    Click on Change Password
    ${update_password_details}    mobile_common.Read TestData From Excel    C7272    Login_Creds
    Log    Read Confirm Password test data
    Log    Enter Password to Change Password
    Log    Step4: fill the spaces and click in "confirm new password and save"
    ${updated_pass}    Enter Password to Change Password    ${update_password_details}[change_password]
    Log    Click on Logout From the Application
    Log    Step5: sign out
    Click on Logout From the Application
    Log    Step6: log in again
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${updated_pass}
    Log    The new password works correctly and is logged in successfully.
    Log    Select Navigation More Tab
    home_page.Select Navigation Tab    More
    Log    Click On Settings Icon
    Click On Settings Icon
    Log    Clicked on Settings Icon
    Log    Click on Change Password
    Click on Change Password
    Log    Enter Password to Change Password
    ${updated_pass}    Enter Password to Change Password    ${NORMAL_PASSWORD}

TC_11 C7287 Set property to offline mode
    [Tags]    android    ios    test_case_id=7287    test_case_id=7287
    Comment    Launch and login to Mobile Application
    Log    Step1: log in in the app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    ${property_details}    mobile_common.Read TestData From Excel    C7272    Login_Creds
    Log    Read Property details from test data
    Log    Logged into the Leo Mobile App
    Log    Select Navigation More Tab
    home_page.Select Navigation Tab    More
    Log    Click On Settings Icon
    Log    Step2: Click on Settings button in top right corner
    Click On Settings Icon
    Log    Clicked on Settings Icon
    Log    Click on Offline Properties
    Click on Offline Properties
    Log    Clicked on Offline Properties button
    Select Properties from the Offline Properties List    ${property_details}[Property]
    Log    Selected ${property_details}[Property] - properties are into offline
    Click on Sync and go offline button
    Log    Wait For Loader to Disappear
    Wait For Loader to Disappear
    Log    Validate Offline Properties Page
    Validate Offline Properties Page
    Log    Properties are sync & no crash occured

TC_12 C7290 tasks category filter
    [Tags]    android    ios    test_case_id=7290    test_case_id=7290
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${first_task_details}    mobile_common.Read TestData From Excel    C7290    Task_Form
    Log    Step1: Go to property tasks page that contain multiple tasks, best case if those tasks belong to different categories.
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${first_task_details}[Default Property]
    Log    Selected Property - ${first_task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${first_task_name}    Enter New Task Details    ${first_task_details}
    Log    ${first_task_name} - task is created successfully
    Log    Click on Filter icon
    Click on Filter icon
    Log    Clicked on "Filter" icon
    mobile_common.Select Property    ${first_task_details}[Property_Name]
    Log    Selected Property - ${first_task_details}[Property_Name]
    Log    Select Category from Category drop down
    Select Category In Filter Page    ${dropdown.tasks.filter.category}    ${first_task_details}[Category]
    Log    ${first_task_details}[Category] - Category is selected.
    Log    Step2: Click filter sign and select some specific category or two and apply it
    Click on Apply button
    Log    Clicked on the "Apply" button
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    ${first_task_name} - The Created Task is displayed successfully.
    Wait For Loader to Disappear
    Log    Validate Selected Property
    Validate Selected Property    ${first_task_name}
    Log    Successfully displayed ${first_task_name} - Task
    ${second_task_details}    mobile_common.Read TestData From Excel    C7290_01    Task_Form
    Log    Step2: Click on menu button
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${second_task_name}    Enter New Task Details    ${second_task_details}
    Log    ${second_task_name} - task is created successfully
    Log    Click on Filter icon
    Click on Filter icon
    Log    Clicked on "Filter" icon
    mobile_common.Select Property    ${second_task_details}[Property_Name]
    Log    Selected Property - ${second_task_details}[Property_Name]
    Log    Step3: Go back to filter and select some other categories
    Log    Step4: Select all categories again
    Log    Select Category from Category drop down
    Select Category In Filter Page    ${dropdown.tasks.filter.category}    ${second_task_details}[Category]
    Log    ${second_task_details}[Category] - Category is selected.
    Log    Step4: Observe the attachment
    Click on Apply button
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    Clicked on "Daily" drop down
    Validate Selected Property    ${second_task_name}
    Log    ${second_task_name} - The Created Task is displayed successfully.

TC_13 C7291 past due tasks
    [Tags]    android    ios    test_case_id=7291    test_case_id=7291
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    Log    Step1: Go to property tasks page that contain multiple tasks, best case if those tasks belong to different categories.
    Select Task Type    Tasks
    Log    Step2: Click filter button in right top corner
    Click on Filter icon
    Log    Clicked on "Filter" icon
    Log    Step3: Click past due button in order to see past due tasks
    Click on Past Due Task
    Log    Clicked on Past Due Task button
    Click on Apply button
    Log    Clicked on the "Apply" button
    Open The Task under Status Bar    Daily Past Due
    Log    "Daily Past Due" is displayed successfully.
    Open The Task under Status Bar    Weekly Past Due
    Log    "Weekly Past Due" is displayed successfully.
    Open The Task under Status Bar    Monthly Past Due
    Log    "Monthly Past Due" is displayed successfully.
    Open The Task under Status Bar    Cannot do
    Log    "Cannot do" is displayed successfully.
    Open The Task under Status Bar    Snoozed
    Log    "Snoozed" is displayed successfully.
    Log    Daily, Weekly, monthly past due tasks opened, and Cannot due and snoozed tasks displayed.

TC_14 C7262 Complete/fail property task
    [Tags]    android    ios    test_case_id=7262    test_case_id=7262
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7262    Task_Form
    Log    Step2: Click on menu button
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${task_name}    Enter New Task Details    ${task_details}
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    ${task_name} - The Created Task is displayed successfully.
    Log    Step3: On desired task, swap screen to the left & click green button - Complete
    Swipe On The Task To Perform The Action    ${task_name}
    Log    Did swipe on the ${task_name} - Task
    Log    Click on Complete Image on a Task
    Click on Complete Image on a Task    ${task_name}
    Log    Enter Note For a Task
    Enter Note For a Task    ${task_details}
    Log    Click on Cannot Do Button On a Task
    Click on Button    Complete Task
    Log    Click on Cannot Do Button On a Task
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Completed
    Log    Validate Completed Task on Tasks Page
    Log    Step4: Verify that the task is completed
    Validate Created Task on Tasks Page    ${task_name}
    Log    ${task_name} - and All changes and the note is displayed properly.
    Swipe On The Task To Perform The Action    ${task_name}
    Log    Did swipe on the ${task_name} - Task
    Click on Reopen Image on a Task    ${task_name}
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    ${task_name} - The Created Task is displayed successfully.
    Log    Step5: On desired task, swap screen to the left & select Cannot Do It
    Swipe On The Task To Perform The Action    ${task_name}
    Log    Did swipe on the ${task_name} - Task
    Log    Click on Cannot Do Image on a Task
    Log    Step4: click in red button ("cannot do button)
    Click on Cannot Do Image on a Task    ${task_name}
    Log    Enter Note For a Task
    Log    Step5: leave a note, attach an image,
    Enter Note For a Task    ${task_details}[Note]
    Log    Click on Cannot Do Button On a Task
    Log    Step6: click in "cannot do" red button
    Click on Button    Cannot Do
    Log    Click on Cannot Do Button On a Task
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Cannot Do
    Log    Validate Created Task on Tasks Page
    Log    Step6: Verify that the task is failed
    Validate Created Task on Tasks Page    ${task_name}
    Log    ${task_name} - and All changes and the note is displayed properly.

TC_15 C7270 snooze task
    [Tags]    android    ios    test_case_id=7270    test_case_id=7270
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7270    Task_Form
    Log    Step2: Click on menu button
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${task_name}    Enter New Task Details    ${task_details}
    Log    ${task_name} - task is created successfully
    Log    Click on Filter icon
    Click on Filter icon
    Log    Clicked on "Filter" icon
    mobile_common.Select Property    ${task_details}[Property_Name]
    Log    Selected Property - ${task_details}[Property_Name]
    Log    Select Category from Category drop down
    Select Category In Filter Page    ${dropdown.tasks.filter.category}    ${task_details}[Category]
    Log    ${task_details}[Category] - Category is selected.
    Log    Step2: Click filter sign and select some specific category or two and apply it
    Click on Apply button
    Log    Clicked on the "Apply" button
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    ${task_details}[Task Open Under]
    Log    ${task_name} - The Created Task is displayed successfully.
    Wait For Loader to Disappear
    Log    Validate Selected Property
    Log    Step3: find some weekly/monthly task and slide it to the left
    Validate Selected Property    ${task_name}
    Log    Successfully displayed ${task_name} - Task
    Swipe On The Task To Perform The Action    ${task_name}
    Log    Select Monthly Recurrence
    Log    Step4: click on blue button "snooze button"
    Click on the Snooze Image for a Task    ${task_name}
    Log    Select a Date To Snooze the Task
    Log    Step5: select some radio button
    Log    Step6: click on "Snooze this task" button
    Select a Date To Snooze the Task
    Log    User is able to snooze task and Successfully Snoozed the Task - ${task_name}.

TC_16 C7299 dashborad filter check (top right icon on the app)
    [Tags]    android    ios    test_case_id=7299    test_case_id=7299
    Log    Step1: Open the app and tap on the top right filter icon
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7299    Task_Form
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${task_name}    Enter New Task Details    ${task_details}
    Log    ${task_name} - The Created Task is displayed successfully.
    Log    Click on Filter icon
    Log    Step2: Observe all filter items
    Click on Filter icon
    Log    Clicked on "Filter" icon
    mobile_common.Select Property    ${task_details}[Property_Name]
    Log    Selected Property - ${task_details}[Property_Name]
    Log    Select Category from Category drop down
    Log    Step3: Select any of filter items and tap on Apply button
    Select Category In Filter Page    ${dropdown.tasks.filter.category}    ${task_details}[Category]
    Log    ${task_details}[Category] - Category is selected.
    Click on Apply button
    Log    Clicked on the "Apply" button
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    Opened "Daily" drop down
    Validate Created Task on Tasks Page    ${task_name}
    Log    FIlters are applied and user is seeing only tasks from selected filters. Successfully displayed ${task_name} - task under Daily drop down.

TC_17 C7306 Complete task without form
    [Tags]    android    ios    test_case_id=7306    test_case_id=7306
    Log    Step1: Login to mobile app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7306    Task_Form
    Log    Step2: Click on menu button in upper left-hand corner
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${task_name}    Enter New Task Details    ${task_details}
    Log    Click on Filter icon
    Click on Filter icon
    Log    Clicked on "Filter" icon
    mobile_common.Select Property    ${task_details}[Property_Name]
    Log    Selected Property - ${task_details}[Property_Name]
    Log    Select Category from Category drop down
    Select Category In Filter Page    ${dropdown.tasks.filter.category}    ${task_details}[Category]
    Log    ${task_details}[Category] - Category is selected.
    Log    Step2: Click filter sign and select some specific category or two and apply it
    Click on Apply button
    Log    Clicked on the "Apply" button
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    ${task_name} - The Created Task is displayed successfully.
    Log    Step3: Swipe task to the left
    Swipe On The Task To Perform The Action    ${task_name}
    Log    Did swipe on the ${task_name} - Task
    Log    Click on Complete Image on a Task
    Log    Step4: Click Complete
    Log    Step5: Click Blue Complete Tasks Button
    Click on Complete Image on a Task    ${task_name}
    Log    Enter Note For a Task
    Enter Note For a Task    ${task_details}
    Log    Click on Cannot Do Button On a Task
    Log    Step6: Should have Green banner at bottom that reads Task Completed!
    Click on Button    Complete Task
    Log    Click on Cannot Do Button On a Task
    Log    Open created work order in Daily colomn
    Log    Step7: Scroll to the bottom to verify that the task shows under Completed area
    Open The Task under Status Bar    Completed
    Log    Validate Completed Task on Tasks Page
    Log    Step4: Verify that the task is completed
    Validate Created Task on Tasks Page    ${task_name}
    Log    Task is completed and user is able to see that task in complete section. ${task_name} - and All changes and the note is displayed properly.

TC_18 C7320 Settings Menu/Screen
    [Tags]    android    ios    test_case_id=7320    test_case_id=7320
    Comment    Launch and login to Mobile Application
    Log    Step1: log in in the app
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    Log    Select Navigation More Tab
    home_page.Select Navigation Tab    More
    Log    Click On Settings Icon
    Log    Step2: Tap cog (settings) button
    Click On Settings Icon
    Log    Step3: Ensure following buttons/functions are present: Go Offline/Power save, Offline Properties, Sync Status, Support, Change Password, Logout
    Log    Clicked on Settings Icon
    Validate Settings Page Icons    Go Offline/Power save
    Log    Go Offline/Power save - option is displayed successfully
    Validate Settings Page Icons    Offline Properties
    Log    Offline Properties - option is displayed successfully
    Validate Settings Page Icons    Sync status
    Log    Sync status - option is displayed successfully
    Validate Settings Page Icons    My Approvals
    Log    My Approvals - option is displayed successfully
    Validate Settings Page Icons    Support
    Log    Support - option is displayed successfully
    Validate Settings Page Icons    Change password
    Log    Change password - option is displayed successfully
    Validate Settings Page Icons    About
    Log    About - option is displayed successfully
    Validate Settings Page Icons    Logout
    Log    Logout - option is displayed successfully
    Log    All of the elements are present

TC_19 C7295 adding multiple photos from library
    [Tags]    android    ios    test_case_id=7295    test_case_id=7295
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7295    Task_Form
    ${file}    Run Process    adb    push    ${EXECDIR}/${task_details}[Image Name]    /sdcard/Pictures
    Log    Step1: Go to property tasks that contain multiple tesks
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${task_name}    Enter New Task Details    ${task_details}
    Comment    ${task_name}    Set Variable    Qz task
    Log    Click on Filter icon
    Click on Filter icon
    Log    Clicked on "Filter" icon
    mobile_common.Select Property    ${task_details}[Property_Name]
    Log    Selected Property - ${task_details}[Property_Name]
    Log    Select Category from Category drop down
    Select Category In Filter Page    ${dropdown.tasks.filter.category}    ${task_details}[Category]
    Log    ${task_details}[Category] - Category is selected.
    Click on Apply button
    Log    Clicked on the "Apply" button
    Log    Open created work order in Daily colomn
    Log    Step2: Find any active task with dynamic form and ability to add pictures
    Open The Task under Status Bar    Daily
    Log    ${task_name} - The Created Task is displayed successfully.
    Swipe On The Task To Perform The Action    ${task_name}
    Log    Did swipe on the ${task_name} - Task
    Log    Click on Complete Image on a Task
    Log    Step3: Complete dynamic form and upload the pictures in Multiple photo input section press Attach photos
    Click on Complete Image on a Task    ${task_name}
    Log    Enter Note For a Task
    Log    Step4: Press on Choose from library
    Enter Note For a Task    ${task_details}    True
    Log    Click on Cannot Do Button On a Task
    Click on Button    Complete Task
    Log    Click on Cannot Do Button On a Task
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Completed
    Log    Validate Completed Task on Tasks Page
    Validate Created Task on Tasks Page    ${task_name}
    Log    The task - ${task_name} is completed and the User is able to select and upload multiple photos from library

TC_20 C7277 offline sync
    [Tags]    android    ios    test_case_id=7277    test_case_id=7277
    Log    Step1: log in in the app as any user
    Login to Mobile Application    ${NORMAL_USER_NAME}    ${NORMAL_PASSWORD}
    Log    Logged into the Leo Mobile App
    ${task_details}    mobile_common.Read TestData From Excel    C7277    Task_Form
    Select Task Type    Tasks
    Log    Navigated to Tasks Tab
    Select Property in Mobile    ${task_details}[Default Property]
    Log    Selected Property - ${task_details}[Default Property]
    Click on Apply button
    Click on plus icon
    Log    Clicked on "Plus" icon.
    Log    Enter New Task Details
    ${task_name}    Enter New Task Details    ${task_details}
    Log    ${task_name} - task is created successfully
    ${properties_details}    mobile_common.Read TestData From Excel    C7277    Login_Creds
    Log    Select Navigation More Tab
    home_page.Select Navigation Tab    More
    Log    Click On Settings Icon
    Log    Step2: Click on Settings button in top right corner
    Click On Settings Icon
    Log    Clicked on Settings Icon
    Log    Go Offline/Power save - option is displayed successfully
    Log    Step3: go to set offline properties and select 5 properties and click in sync button
    Validate Settings Page Icons    Offline Properties    True
    Log    Offline Properties - option is displayed successfully
    Enter Property/Portfolio name in Offline Properties    ${properties_details}
    Log    Click on Sync and go offline button
    Log    Step4: turn off all the networks and work in offline mode
    Click on Sync and go offline button
    Log    Clicked on Sync and go offline button
    AppiumExtendedLibrary.Go Back
    Log    Select Navigation More Tab
    home_page.Select Navigation Tab    Tasks
    Log    Click on Filter icon
    Click on Filter icon
    Log    Clicked on "Filter" icon
    mobile_common.Select Property    ${task_details}[Property_Name]
    Log    Selected Property - ${task_details}[Property_Name]
    Log    Select Category from Category drop down
    Select Category In Filter Page    ${dropdown.tasks.filter.category}    ${task_details}[Category]
    Log    ${task_details}[Category] - Category is selected.
    Click on Apply button
    Log    Clicked on the "Apply" button
    Log    Open created work order in Daily colomn
    Open The Task under Status Bar    Daily
    Log    ${task_name} - The Created Task is displayed successfully.
    Swipe On The Task To Perform The Action    ${task_name}
    Log    Did swipe on the ${task_name} - Task
    Log    Click on Complete Image on a Task
    Log    Step4: complete more than 30 steps to test the sync mode and record all the options selected in the DFs to compare later in the reports or completed tasks options
    Click on Complete Image on a Task    ${task_name}
    Log    Enter Note For a Task
    Enter Note For a Task    ${task_details}
    Log    Click on Cannot Do Button On a Task
    Click on Button    Complete Task
    home_page.Select Navigation Tab    More
    Log    Click On Settings Icon
    Click On Settings Icon
    Click On Element    Go Offline/Power save    ${toggle.settings.go_offline/power_save}    ${MEDIUM_WAIT}
    Wait For Loader to Disappear
    Log    Clicked on Settings Icon
    Open The Task under Status Bar    Completed
    Log    Validate Completed Task on Tasks Page
    Validate Created Task on Tasks Page    ${task_name}
    Log    Task is completed and the sync takes a while, but everything its in order.
