echo off
set source=%~dp0
set today=%Date:~10,4%%Date:~4,2%%Date:~7,2%
set t=%time:~0,8%
set t=%t::=%
set t=%t: =0%
set timestamp=%today%_%t%
set results=%source%\Results\UI_Reports
set env=%1
set username=%2
set password=%3
set headless=%4
set suite=%5
echo set tc_name=%6
echo %timestamp%
@echo "#######################################"
@echo "# Executing Web UI Testcases #"
@echo "#######################################"
@echo robot --logtitle Web_Tests_Report --reporttitle Web_Tests_Report --outputdir %source%\Results\UI_Reports KeywordTestcases\Web\*.robot
@echo robot --logtitle Web_Tests_Report --reporttitle Web_Tests_Report --outputdir %results%  --variable url:%url% KeywordTestcases\Web\Dashboard.robot 
robot --logtitle Web_Tests_Report --reporttitle Web_Tests_Report --outputdir %results% --variable ENVIRONMENT:%env% --variable APP_USER_NAME:%username% --variable APP_PASSWORD:%password% --variable HEADLESS:%headless% KeywordTestcases\Web\%suite%.robot