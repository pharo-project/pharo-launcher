"
I specify how the application proposes the user to update virtual machines.
"
Class {
	#name : 'PharoLauncherApplicationVmUpdateTest',
	#superclass : 'TestCase',
	#instVars : [
		'application',
		'vmPresenter',
		'vm'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'asserting' }
PharoLauncherApplicationVmUpdateTest >> isVmUpdated [

	^ (vm vmStore / vm name / 'fetched!') exists
]

{ #category : 'running' }
PharoLauncherApplicationVmUpdateTest >> setUp [

	super setUp.
	application := PhLTestApplication new.
	vmPresenter := PhLTestVmPresenter new.
	vm := vmPresenter vmFor: vmPresenter singleVmName
]

{ #category : 'running' }
PharoLauncherApplicationVmUpdateTest >> tearDown [

	PhLTestVirtualMachineManager reset.
	super tearDown
]

{ #category : 'tests' }
PharoLauncherApplicationVmUpdateTest >> testAcceptingProposalUpdatesVms [

	application requestAnswer: true.

	application vmUpdatesAvailable: { vm }.

	self assert: application proposedVms equals: { vm }.
	self assert: self isVmUpdated
]

{ #category : 'tests' }
PharoLauncherApplicationVmUpdateTest >> testPostponingProposalUpdatesNoVm [

	application requestAnswer: false.

	application vmUpdatesAvailable: { vm }.

	self assert: application proposedVms equals: { vm }.
	self deny: self isVmUpdated
]

{ #category : 'tests' }
PharoLauncherApplicationVmUpdateTest >> testVmFailingToUpdateIsReported [

	vm manager: PhLFailingVirtualMachineManager new.
	application requestAnswer: true.

	application vmUpdatesAvailable: { vm }.

	self deny: self isVmUpdated.
	self assert: (application error longDescription includesSubstring: vm id)
]

{ #category : 'tests' }
PharoLauncherApplicationVmUpdateTest >> testVmUpdateIsProposedOnceTemplateSourcesProposalIsAnswered [

	| proposedVmsWhileProposingTemplateSources |
	application whenProposingTemplateSourcesUpdateDo: [
		application vmUpdatesAvailable: { vm }.
		proposedVmsWhileProposingTemplateSources := application proposedVms ].

	application sourcesFileUpdateAvailable.

	self assert: proposedVmsWhileProposingTemplateSources isNil.
	self assert: application proposedVms equals: { vm }
]
