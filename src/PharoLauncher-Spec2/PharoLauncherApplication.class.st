"
Application that allows users to choose a template from a set of templates (potentially on the web). From a template, the user can create a Pharo image and launch it. This application also list the existing images.

PharoLauncherApplication open
"
Class {
	#name : #PharoLauncherApplication,
	#superclass : #SpApplication,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'imageRepository',
		'templateRepository',
		'imagesPresenter',
		'openInWorld'
	],
	#classVars : [
		'Default',
		'IsDeployed',
		'TemplatesClearedOnStartup'
	],
	#classInstVars : [
		'pharoIcon'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #testing }
PharoLauncherApplication class >> beDeployed [
	IsDeployed := true
]

{ #category : #testing }
PharoLauncherApplication class >> beUndeployed [
	IsDeployed := false
]

{ #category : #accessing }
PharoLauncherApplication class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #settings }
PharoLauncherApplication class >> hardResetPersistanceState [
	^false
]

{ #category : #settings }
PharoLauncherApplication class >> hardResetPersistanceState: isClickedFromSettings [ 
	|packages|
	
	isClickedFromSettings ifFalse: [ ^ self ]. "Important: this code should not be run when loading stored preferences, else PharoLauncher deployment mode is set to not deployed!"
	
	SystemWindow allSubInstances do:[ :window | window delete].
	self inform: 'PharoLauncher state reset'.
	World doOneCycle.
	500 milliSeconds wait. "To help user perception that *something* was reset"
		
	packages := RPackageOrganizer default packages select:[ :package | 
		(package name includesSubstring: 'PharoLauncher') ].
	packages do: 
		[ :package | 
		package definedClasses 
			reject: [ :class | class = PhLStartupManager ] "Do not reset this class, else Pharo settings will not be loaded at startup and repository location couldbe wrong!"
			thenDo: [ :class | class classPool keys do: [ :key | class classPool at: key put: nil ] ] ].

	self open.
]

{ #category : #testing }
PharoLauncherApplication class >> isDeployed [
	^ IsDeployed ifNil: [ IsDeployed := false ]
]

{ #category : #'world menu' }
PharoLauncherApplication class >> menuCommandOn: aBuilder [ 
	<worldMenu> 

	(aBuilder item: #'Pharo Launcher')
		icon: self pharoIcon16x16;
		parent: #Tools;
		order: 110;
		action: [ self open ];
		withSeparatorAfter
]

{ #category : #opening }
PharoLauncherApplication class >> open [
	<script>
	^ self default run
]

{ #category : #opening }
PharoLauncherApplication class >> openFull [ 
	<script>
	^ self default 
		beOpenedInWorld;
		run
]

{ #category : #'world menu' }
PharoLauncherApplication class >> pharoIcon16x16 [

	^ pharoIcon 
		ifNil: [ pharoIcon := (self iconNamed: #pharo) scaledToSize: 16@16 ].

]

{ #category : #settings }
PharoLauncherApplication class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder group: #pharoLauncher)
		label: 'Pharo Launcher' translated;
		description: 'General application settings' translated;
		with: [ 
					(aBuilder setting: #templatesClearedOnStartup)
						label: 'Templates cleared at startup' translated;
						order: 20;
						target: self;
						description:
								'When enabled, Launcher startup clears the Templates List. ' , String cr
										, 'When disabled, Launcher startup retains the Templates List from last run.' translated.
		
					(aBuilder setting: #hardResetPersistanceState)
						label: 'Hard reset persistent state' translated;
						target: self;
						order: 70;
						description:
								'When PharoLauncher is updated through Monticello ' , 
								'sometimes you need to clear persistent state to pick up new changes.' , String cr, 
								'Clicking this box is a one-shot action, i.e. this state is also reset.', String cr, 
								'Note, all open windows are clsoed and the application restarted.'
								translated 
		
		]
]

{ #category : #settings }
PharoLauncherApplication class >> templatesClearedOnStartup [
	^ TemplatesClearedOnStartup ifNil: [  TemplatesClearedOnStartup := false ].
]

{ #category : #settings }
PharoLauncherApplication class >> templatesClearedOnStartup: aBoolean [ 
	TemplatesClearedOnStartup := aBoolean
]

{ #category : #configuring }
PharoLauncherApplication >> beOpenedInWorld [
	openInWorld := true
]

{ #category : #accessing }
PharoLauncherApplication >> imageRepository [
	^ imageRepository
]

{ #category : #accessing }
PharoLauncherApplication >> imageRepository: aPhlImageRepository [
	imageRepository := aPhlImageRepository
]

{ #category : #announcements }
PharoLauncherApplication >> imageRepositoryChanged [
	imagesPresenter ifNotNil: #refresh
]

{ #category : #initialization }
PharoLauncherApplication >> initialize [ 
	openInWorld := false.
	imageRepository :=  PhLDirectoryBasedImageRepository default.
	self resetTemplateRepository
]

{ #category : #initialization }
PharoLauncherApplication >> resetTemplateRepository [
	templateRepository := PhLTemplateGroupRepository newFromGroups: PhLTemplateGroupsBuilder build.
]

{ #category : #running }
PharoLauncherApplication >> run [ 
	| presenterClass |
	
	imagesPresenter := PhLImagesPresenter newApplication: self model: imageRepository.
	presenterClass := openInWorld 
		ifTrue: [ SpWorldPresenter ]
		ifFalse: [ imagesPresenter defaultWindowPresenterClass ].
	self 
		open: imagesPresenter 
		withSpecLayout: imagesPresenter defaultSpec
		using: presenterClass
]

{ #category : #accessing }
PharoLauncherApplication >> templateRepository [
	^ templateRepository
]

{ #category : #accessing }
PharoLauncherApplication >> templateRepository: aPhLTemplateGroupRepository [
	templateRepository := aPhLTemplateGroupRepository
]
