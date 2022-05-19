This directory contains the scripts to tests the list running images and kill images functionalities. TestKillImage and testListRunningImages scripts needs the shunit application to work. If it is absent, it is automatically dowload by the ensureShunitIsPresent script.  

Purspose of files:
- meta-inf.ston: This is image launch configuration used by unit tests. Images launched from shell unit tests are running in headless mode (x window is not required).
- sources-for-tests.list: Set of minimal Pharo image templates used by shell unit tests (thus not dependent on remote site for pulling up-to-date templates)
- PharoLauncherCommonFunctions.sh: Contains elementary functions to e.g. download Shunit library, prepare launcher script and and launcher image in needed dirs, setup of templates, assert functions with extra printout,...
- testImageCommands.sh: unit tests for Pharo Launcher CLI itself, using functions from previous file
