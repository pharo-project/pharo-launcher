"
I specify how the application warns the user that virtual machines can be updated: without interrupting, through the VMs button of the main window.
Updating from the VM manager is specified by `PhLUpdateVmCommandTest`.
"
Class {
	#name : 'PharoLauncherApplicationVmUpdateTest',
	#superclass : 'TestCase',
	#instVars : [
		'imagesPresenter',
		'vm'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'running' }
PharoLauncherApplicationVmUpdateTest >> setUp [

	super setUp.
	imagesPresenter := PhLTestImagesPresenter new.
	vm := PhLVirtualMachine new
		      id: '130-x64';
		      yourself
]

{ #category : 'tests' }
PharoLauncherApplicationVmUpdateTest >> testMainWindowShowsVmsToUpdateOnceCheckIsDone [

	| application |
	application := imagesPresenter application.
	application vmUpdateChecker: (PhLTestVmUpdateChecker vmsToUpdate: { vm }).

	application vmUpdateCheckDone.

	self assert: imagesPresenter vmsToUpdate equals: { vm }.
	self deny: imagesPresenter vmsButton icon extent equals: PhLOpenVmManagerCommand new icon extent
]
