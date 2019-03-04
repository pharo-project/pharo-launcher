"
Application that allows users to choose a template from a set of templates (potentially on the web). From a template, the user can create a Pharo image and launch it. This application also list the existing images.
"
Class {
	#name : #PharoLauncher,
	#superclass : #ComposablePresenter,
	#instVars : [
		'launcherModel',
		'imagesModel',
		'templatesModel',
		'statusbarModel',
		'quitOnLaunchCheckBoxModel',
		'imageRepository'
	],
	#classVars : [
		'TemplateRepository',
		'TemplatesClearedOnStartup'
	],
	#classInstVars : [
		'pharoIcon'
	],
	#category : 'PharoLauncher-Spec'
}

{ #category : #'instance creation' }
PharoLauncher class >> createLauncher [
	^ self createLauncherWithGroups: PhLTemplateGroupsBuilder build
]

{ #category : #'instance creation' }
PharoLauncher class >> createLauncherWithGroups: aListOfLauncherTemplatesGroup [
	^ self basicNew
		setImageRepository: PhLDirectoryBasedImageRepository default
			templateRepository: (PhLTemplateGroupRepository newFromGroups: aListOfLauncherTemplatesGroup);
		initialize;
		yourself
]

{ #category : #updating }
PharoLauncher class >> forceTemplateRepositoryUpdate [
	TemplateRepository := nil
]

{ #category : #settings }
PharoLauncher class >> hardResetPersistanceState [
	^false
]

{ #category : #settings }
PharoLauncher class >> hardResetPersistanceState: isClickedFromSettings [ 
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

{ #category : #'world menu' }
PharoLauncher class >> menuCommandOn: aBuilder [ 
	<worldMenu> 

	(aBuilder item: #'Pharo Launcher')
		icon: self pharoIcon16x16;
		parent: #Tools;
		order: 110;
		action: [ self open ];
		withSeparatorAfter
]

{ #category : #opening }
PharoLauncher class >> open [
	^ self createLauncher openWithSpec
]

{ #category : #opening }
PharoLauncher class >> openFull [
	"this is needed, because TreeModels unregister themselves only on window a close event,
	but in fullscreen mode are no windows"
	| launcher |
	PhLTitledTreePresenter unsubscribeAllRepositories.
	launcher := self createLauncher openWorldWithSpec.
	PluggableButtonMorph allInstances do: #changed. "Hack because buttons icons are not shown until you mouse over it ..."
	^ launcher
]

{ #category : #'world menu' }
PharoLauncher class >> pharoIcon16x16 [

	^ pharoIcon 
		ifNil: [ pharoIcon := (self iconNamed: #pharo) scaledToSize: 16@16 ].

]

{ #category : #settings }
PharoLauncher class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder group: #pharoLauncher)
		label: 'Pharo Launcher' translated;
		description: 'General application settings' translated;
		with: [ 
					(aBuilder setting: #templatesClearedOnStartup)
						label: 'Templates cleared at startup' translated;
						order: 20;
						target: PharoLauncher;
						description:
								'When enabled, Launcher startup clears the Templates List. ' , String cr
										, 'When disabled, Launcher startup retains the Templates List from last run.' translated.
		
					(aBuilder setting: #hardResetPersistanceState)
						label: 'Hard reset persistant state' translated;
						target: PharoLauncher;
						order: 70;
						description:
								'When PharoLauncher is updated through Monticello ' , 
								'sometimes you need to clear persistant state to pick up new changes.' , String cr, 
								'Clicking this box is a one-shot action, i.e. this state is also reset.', String cr, 
								'Note, all open windows are clsoed and the application restarted.'
								translated 
		
		]
]

{ #category : #specs }
PharoLauncher class >> specLayout [
	<spec: #default>
	^ SpecLayout composed
			newRow: 
			[ 	:r | r 
				newColumn: [ :c4 | ] width: 1; "Add a thin column so left side not pushed up so tight"
				newColumn:
				[	:c3 | c3
					add: #templatesModel;
					add: #quitOnLaunchCheckBoxModel height: 25 "2013-10-13-BTC How do you left justfiy checkbox?"
				] left: 0.60;
				addSplitter;
				newColumn: 
				[ 	:c2 | c2
					add: #imagesModel ;
					add: #statusbarModel height: 25						
				] right: 0.40
			];
			yourself.
]

{ #category : #settings }
PharoLauncher class >> templatesClearedOnStartup [
	^ TemplatesClearedOnStartup ifNil: [  TemplatesClearedOnStartup := false ].
]

{ #category : #settings }
PharoLauncher class >> templatesClearedOnStartup: aBoolean [ 
	TemplatesClearedOnStartup := aBoolean
]

{ #category : #initialization }
PharoLauncher >> actionSearch [
	^ imagesModel searchField widget
		takeKeyboardFocus;
		flash
		
		
		
]

{ #category : #private }
PharoLauncher >> commandClassesForImagesMenu [
	^ PhLImageCommand allConcreteCommands
]

{ #category : #private }
PharoLauncher >> commandClassesForImagesToolbar [
	^ Array 
		with: PhLLaunchImageCommand 
		with: PhLLaunchImageWithoutSettingCommand 
		with: PhLImportImageCommand 
		with: PhLDeleteImageCommand 
		with: PhLRefreshImageRepositoryCommand
]

{ #category : #private }
PharoLauncher >> commandClassesForStatusbar [
	^ { PhLAboutCommand . PhLOpenVmManagerCommand . PhLOpenSettingsCommand . PhLQuitCommand }
]

{ #category : #private }
PharoLauncher >> commandClassesForTemplatesMenu [
	^ PhLTemplateCommand allConcreteCommands
]

{ #category : #private }
PharoLauncher >> commandClassesForTemplatesToolbar [
	^ {PhLCreateImageFromTemplateCommand. PhLRefreshTemplateRepositoryCommand}
]

{ #category : #accessing }
PharoLauncher >> imageRepository [
	^ imageRepository
]

{ #category : #accessing }
PharoLauncher >> imagesModel [
	^ imagesModel
]

{ #category : #protocol }
PharoLauncher >> initialExtent [
	^ 900@560
]

{ #category : #initialization }
PharoLauncher >> initialize [

	super initialize.
	
	launcherModel := self newModel.
]

{ #category : #initialization }
PharoLauncher >> initializeImageAndTemplates [
	imagesModel
		toolbarCommandClasses: self commandClassesForImagesToolbar;
		menuCommandClasses: self commandClassesForImagesMenu;
		context: self launcherModel;
		repository: self imageRepository.
	templatesModel
		toolbarCommandClasses: self commandClassesForTemplatesToolbar;
		menuCommandClasses: self commandClassesForTemplatesMenu;
		context: self launcherModel;
		repository: self templateRepository.
	statusbarModel
		commandClasses: self commandClassesForStatusbar;
		context: self launcherModel
]

{ #category : #initialization }
PharoLauncher >> initializeKeyboardShortcuts [
	self adapter
		bindKeyCombination: $f meta asKeyCombination
		toAction: [ self actionSearch ]
]

{ #category : #initialization }
PharoLauncher >> initializePresenter [
	super initializePresenter.
	PhLDownloadManager default whenErrorAddedDo: [ self showNumberOfErrors ].
	self whenWindowChanged: [ :launcherWindow |
        launcherWindow whenClosedDo: [
			"There is no clean way to unregister our action (self showNumberOfErrors) from
			PhLDownloadManager errors (CollectionValueHolder). We miss a way to identify this action 
			to unregister it. For now, just reset the download manager when we close Pharo Launcher."
			PhLDownloadManager reset ] ].
]

{ #category : #initialization }
PharoLauncher >> initializeWidgets [

	statusbarModel := self newStatusBar.
	
	(imagesModel := self newSearchableTitledTree)
		title: 'Current Images' translated;
		doubleClickCommandClass: PhLLaunchImageCommand;
		whenSelectionChanged: [:items | self updateStatusBarWith: items ];
		makeMultiSelect.
	(templatesModel := self newTitledTree)
		title: 'New Image Templates' translated;
		doubleClickCommandClass: PhLCreateImageFromTemplateCommand.
	
	(quitOnLaunchCheckBoxModel := self newCheckBox)
		label: 'Quit on launch';
		state: PhLLaunchImageCommand quitOnLaunch;
		whenChangedDo: [ PhLLaunchImageCommand quitOnLaunch: self quitOnLaunchCheckBoxModel state ].
	PhLLaunchImageCommand announcer weak
		when: PhLQuitOnLaunchValueChanged 
		send: #refreshQuitOnLaunchCheckBox
		to: self.
		
	self whenChangedDo: [  :w  | w whenClosedDo:  [ PhLLaunchImageCommand announcer unsubscribe: self ] ].
	self whenBuiltDo: [ 
		self 
			initializeImageAndTemplates; 
			initializeKeyboardShortcuts ].
]

{ #category : #accessing }
PharoLauncher >> launcherModel [

	^ launcherModel
]

{ #category : #private }
PharoLauncher >> newModel [
	^ PharoLauncherModel selection: #() imageRepository: self imageRepository templateRepository: self templateRepository
]

{ #category : #widgets }
PharoLauncher >> newSearchableTitledTree [ 
	^ self instantiate: PhLSearchableTitledTreePresenter.
]

{ #category : #widgets }
PharoLauncher >> newStatusBar [
	^ self instantiate: PhLStatusbar.
	

]

{ #category : #widgets }
PharoLauncher >> newTitledTree [ 
	^ self instantiate: PhLTitledTreePresenter.
]

{ #category : #accessing }
PharoLauncher >> quitOnLaunchCheckBoxModel [
	^ quitOnLaunchCheckBoxModel
]

{ #category : #refreshing }
PharoLauncher >> refreshQuitOnLaunchCheckBox [
	quitOnLaunchCheckBoxModel state: PhLLaunchImageCommand quitOnLaunch
]

{ #category : #initialization }
PharoLauncher >> setImageRepository: anImageRepository templateRepository: aTemplateRepository [
	(self templatesMissingOnStartup or: self templatesClearedOnStartup)
		ifTrue: [ TemplateRepository := aTemplateRepository ].
	imageRepository := anImageRepository
]

{ #category : #private }
PharoLauncher >> showNumberOfErrors [
	statusbarModel content: PhLDownloadManager default numberOfErrors asString, ' network error(s)'
]

{ #category : #accessing }
PharoLauncher >> statusbarModel [
	^ statusbarModel
]

{ #category : #accessing }
PharoLauncher >> templateRepository [
	^ TemplateRepository
]

{ #category : #initialization }
PharoLauncher >> templatesClearedOnStartup [
	^ self class templatesClearedOnStartup
]

{ #category : #initialization }
PharoLauncher >> templatesMissingOnStartup [
	^ TemplateRepository isNil
]

{ #category : #accessing }
PharoLauncher >> templatesModel [
	^ templatesModel
]

{ #category : #protocol }
PharoLauncher >> title [
	^ 'Pharo Launcher'
]

{ #category : #initialization }
PharoLauncher >> updateStatusBarWith: selectedItems [

	statusbarModel
		content:
			(selectedItems size = 1
				ifTrue: [ selectedItems first content description ]
				ifFalse: [ '' ])
]
