Class {
	#name : 'PhLVMPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'running' }
PhLVMPresenterTest >> tearDown [

	presenter ifNotNil: [
		presenter window ifNotNil: [ :window | window close ] ].
	super tearDown
]

{ #category : 'tests' }
PhLVMPresenterTest >> testVmTableKeepsAlternateRowsColorAfterThemeSwitch [

	| application themeClass |
	themeClass := UITheme current class.
	application := PhLTestApplication new.
	application useBackend: #Morphic with: PhLMorphicConfiguration new.
	presenter := PhLTestVmPresenter new.
	presenter
		application: application;
		model: (PhLVirtualMachinesDataSource vmsBlock: [ #(  ) ]);
		refresh;
		open.

	[ application switchThemeToDark ]
		ensure: [ themeClass beCurrent ].

	self assert: presenter hasAlternateRowsColor
]
