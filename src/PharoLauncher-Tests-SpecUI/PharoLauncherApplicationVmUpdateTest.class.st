"
I specify how the application proposes the user to update virtual machines: it opens the VM manager on them.
Updating from the VM manager is specified by `PhLUpdateVmCommandTest`.
"
Class {
	#name : 'PharoLauncherApplicationVmUpdateTest',
	#superclass : 'TestCase',
	#instVars : [
		'application',
		'vm'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'running' }
PharoLauncherApplicationVmUpdateTest >> setUp [

	super setUp.
	application := PhLTestApplication new.
	vm := PhLVirtualMachine new
		      id: '130-x64';
		      yourself
]

{ #category : 'tests' }
PharoLauncherApplicationVmUpdateTest >> testVmManagerIsOpenedOnVmsToUpdate [

	application vmUpdatesAvailable: { vm }.

	self assert: application vmsProposedInVmManager equals: { vm }
]

{ #category : 'tests' }
PharoLauncherApplicationVmUpdateTest >> testVmManagerIsOpenedOnceTemplateSourcesProposalIsAnswered [

	| proposedVmsWhileProposingTemplateSources |
	application whenProposingTemplateSourcesUpdateDo: [
		application vmUpdatesAvailable: { vm }.
		proposedVmsWhileProposingTemplateSources := application vmsProposedInVmManager ].

	application sourcesFileUpdateAvailable.

	self assert: proposedVmsWhileProposingTemplateSources isNil.
	self assert: application vmsProposedInVmManager equals: { vm }
]
