"
Application that allows users to choose a template from a set of templates (potentially on the web). From a template, the user can create a Pharo image and launch it. This application also list the existing images.

PharoLauncherApplication open
"
Class {
	#name : 'PharoLauncherApplication',
	#superclass : 'SpApplication',
	#instVars : [
		'imageRepository',
		'templateRepository',
		'imagesPresenter',
		'scriptsDirectory',
		'openAsWorld',
		'standalone'
	],
	#classVars : [
		'Default',
		'IsDeployed',
		'ScriptsDirectory',
		'TemplatesClearedOnStartup'
	],
	#classInstVars : [
		'pharoIcon'
	],
	#category : 'PharoLauncher-Spec2-Application',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Application'
}

{ #category : 'activation' }
PharoLauncherApplication class >> applicationName [

	^ 'launcher'
]

{ #category : 'testing' }
PharoLauncherApplication class >> beDeployed [
	IsDeployed := true
]

{ #category : 'testing' }
PharoLauncherApplication class >> beUndeployed [
	IsDeployed := false
]

{ #category : 'accessing' }
PharoLauncherApplication class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : 'accessing' }
PharoLauncherApplication class >> default: aPharoLauncherApplication [
	Default := aPharoLauncherApplication
]

{ #category : 'settings' }
PharoLauncherApplication class >> defaultInitializationScriptLocation [
	^ FileLocator launcherUserFilesLocation / 'scripts' 
]

{ #category : 'file service' }
PharoLauncherApplication class >> fileReaderServicesForFile: fullName suffix: suffix [

	<fileService>

	^ suffix = 'image'
		ifTrue: [
			{ SimpleServiceEntry provider: self label: 'Launch image' selector: #launchImage: } ]
		ifFalse: [ #() ]
]

{ #category : 'settings' }
PharoLauncherApplication class >> hardResetPersistanceState [
	^false
]

{ #category : 'settings' }
PharoLauncherApplication class >> hardResetPersistanceState: isClickedFromSettings [ 
	|packages|
	
	isClickedFromSettings ifFalse: [ ^ self ]. "Important: this code should not be run when loading stored preferences, else PharoLauncher deployment mode is set to not deployed!"
	
	SystemWindow allSubInstances do:[ :window | window delete].
	self inform: 'PharoLauncher state reset'.
	World doOneCycle.
	500 milliSeconds wait. "To help user perception that *something* was reset"
		
	packages := PackageOrganizer default packages select:[ :package | 
		(package name includesSubstring: 'PharoLauncher') ].
	packages do: 
		[ :package | 
		package definedClasses 
			reject: [ :class | class = PhLStartupManager ] "Do not reset this class, else Pharo settings will not be loaded at startup and repository location couldbe wrong!"
			thenDo: [ :class | class classPool keys do: [ :key | class classPool at: key put: nil ] ] ].

	self openFull.
]

{ #category : 'accessing' }
PharoLauncherApplication class >> initializationScriptsDirectory [

	^ ScriptsDirectory ifNil: [ self defaultInitializationScriptLocation ]
]

{ #category : 'accessing' }
PharoLauncherApplication class >> initializationScriptsDirectory: aFileUrl [

	| directory |
	directory := aFileUrl asFileReference.
	ScriptsDirectory := directory.
	^ directory ensureCreateDirectory
]

{ #category : 'settings' }
PharoLauncherApplication class >> initializationScriptsLocation [
	" Used to display a nice file url in settings browser"
	^ self initializationScriptsDirectory pathString 
	
]

{ #category : 'settings' }
PharoLauncherApplication class >> initializationScriptsLocation: aFileUrl [
	" Used to display a nice file url in settings browser"
	^ self initializationScriptsDirectory: aFileUrl
]

{ #category : 'testing' }
PharoLauncherApplication class >> isDeployed [
	^ IsDeployed ifNil: [ IsDeployed := false ]
]

{ #category : 'file service' }
PharoLauncherApplication class >> launchImage: fullName [

	(PhLLaunchImageFromDiskCommand forContext: self default mainPresenter)
		launchImage: (PhLImage location: fullName asFileReference)
]

{ #category : 'world menu' }
PharoLauncherApplication class >> menuCommandOn: aBuilder [ 
	<worldMenu> 

	(aBuilder item: #'Pharo Launcher')
		icon: self pharoIcon16x16;
		parent: #Tools;
		order: 110;
		action: [ self open ];
		withSeparatorAfter
]

{ #category : 'opening' }
PharoLauncherApplication class >> open [
	<script>
	
	^ self default
		openAsWorld: false;
		run
]

{ #category : 'opening' }
PharoLauncherApplication class >> openFull [ 
	<script>
	
	^ self default
		beOpenedAsWorld;
		run
]

{ #category : 'world menu' }
PharoLauncherApplication class >> pharoIcon16x16 [

	^ pharoIcon 
		ifNil: [ pharoIcon := (self iconNamed: #pharo) scaledToSize: 16@16 ].

]

{ #category : 'class initialization' }
PharoLauncherApplication class >> reset [
	<script>
   Default ifNil: [ ^ self ].

   Default reset.
	Default := nil
]

{ #category : 'settings' }
PharoLauncherApplication class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder group: #pharoLauncher)
		label: 'Pharo Launcher' translated;
		description: 'General application settings';
		with: [ 
					(aBuilder setting: #templatesClearedOnStartup)
						label: 'Templates cleared at startup' translated;
						order: 20;
						target: self;
						description:
								'When enabled, Launcher startup clears the Templates List. ' , String cr
										, 'When disabled, Launcher startup retains the Templates List from last run.'.
		
					(aBuilder setting: #initializationScriptsLocation)
						label: 'Location of your image initialization scripts';
						type: #Directory;
						groupName: #pharoLauncher;
						target: self;
						order: 40;
						description: 'A directory where all your Pharo images initialization scripts will be saved (executed once at image creation)'.
		
					(aBuilder setting: #hardResetPersistanceState)
						label: 'Hard reset persistent state' translated;
						target: self;
						order: 70;
						description:
								'When PharoLauncher is updated through Monticello ' , 
								'sometimes you need to clear persistent state to pick up new changes.' , String cr, 
								'Clicking this box is a one-shot action, i.e. this state is also reset.', String cr, 
								'Note, all open windows are clsoed and the application restarted.' 
		]
]

{ #category : 'accessing' }
PharoLauncherApplication class >> templatesClearedOnStartup [
	^ TemplatesClearedOnStartup ifNil: [ TemplatesClearedOnStartup := false ].
]

{ #category : 'settings' }
PharoLauncherApplication class >> templatesClearedOnStartup: aBoolean [ 
	TemplatesClearedOnStartup := aBoolean
]

{ #category : 'testing' }
PharoLauncherApplication class >> useDefault: aPharoLauncherApplication during: aBlock [
	"Used to set a different app for testing purposes"
	| oldDefault |
	
	oldDefault := self default.
	[ self default: aPharoLauncherApplication.
	aBlock value ]
		ensure: [ self default: oldDefault ]	
]

{ #category : 'configuring' }
PharoLauncherApplication >> beOpenedAsWorld [
	self openAsWorld: true
]

{ #category : 'initialization' }
PharoLauncherApplication >> cleanProcesses [

    (Smalltalk classNamed: #MorphicUIManager) 
        ifNotNil: [ :clazz | clazz uiProcess ifNotNil: #terminate ].
    (Smalltalk classNamed: #ProcessBrowser) 
        ifNotNil: [ :clazz | 
            clazz new processList
                detect: [ :each | each name = 'SDL2 Event loop' ]
                ifFound: [ :aProcess | aProcess terminate ] ]
]

{ #category : 'accessing' }
PharoLauncherApplication >> defaultTemplateRepository [
	^ PhLTemplateGroupRepository default
]

{ #category : 'initialization' }
PharoLauncherApplication >> exitApplication [

	Smalltalk exitSuccess
]

{ #category : 'accessing' }
PharoLauncherApplication >> imageRepository [
	^ imageRepository
]

{ #category : 'accessing' }
PharoLauncherApplication >> imageRepository: aPhlImageRepository [
	imageRepository := aPhlImageRepository
]

{ #category : 'announcements' }
PharoLauncherApplication >> imageRepositoryChanged [
	imagesPresenter ifNotNil: #refresh
]

{ #category : 'announcements' }
PharoLauncherApplication >> imageRepositoryChanged: newImage [

	self imageRepositoryChanged.
	imagesPresenter ifNotNil: [ imagesPresenter selectImage: newImage ].
]

{ #category : 'initialization' }
PharoLauncherApplication >> initialize [

 	super initialize.
	"I want to register windows in order to be able to know which one is the last opened 
	 This can be use to push progress bars (they stack)."
	windows := OrderedCollection new. 
	openAsWorld := false.
	PharoLauncherSettings default load.
	self isStandalone 
		ifTrue: [ 
			GEngine ensureEngine
				applicationId: 'org.pharo.PharoLauncher';
				whenInitializedDo: [ GLibLibrary uniqueInstance gSetPrgName: 'Pharo Launcher' ];
				run.
			self useBackend: #Gtk with: PhLGtkConfiguration new ]
		ifFalse: [ 
			self useBackend: #Morphic with: PharoLauncherConfiguration new ].
	
	imageRepository :=  PhLDirectoryBasedImageRepository default.
	imageRepository reset.
	
	self templatesClearedOnStartup 
		ifTrue: [ self class resetTemplateRepository ].
	self resetTemplateRepository.

]

{ #category : 'initialization' }
PharoLauncherApplication >> initializeImagesPresenter [
	^ imagesPresenter := PhLImagesPresenter
		newApplication: self
		model: imageRepository
]

{ #category : 'testing' }
PharoLauncherApplication >> isDarkTheme [

	^ self configuration isDarkTheme
]

{ #category : 'testing' }
PharoLauncherApplication >> isLightTheme [

	^ self isDarkTheme not
]

{ #category : 'testing' }
PharoLauncherApplication >> isMorphicBackend [

	^ self backend isKindOf: SpMorphicBackend
]

{ #category : 'testing' }
PharoLauncherApplication >> isStandalone [

	^ standalone ifNil: [ standalone := false ]
]

{ #category : 'events' }
PharoLauncherApplication >> launchConfigurationEdited: aLaunchConfiguration [
	"set the last edited launch configuration in the toolbar "

	aLaunchConfiguration isNullConfiguration 
		ifFalse: [ imagesPresenter selectConfiguration: aLaunchConfiguration ].
]

{ #category : 'accessing' }
PharoLauncherApplication >> mainPresenter [

	^ imagesPresenter
]

{ #category : 'ui' }
PharoLauncherApplication >> newConfirm [

	^ PhLConfirmDialog newApplication: self
]

{ #category : 'events' }
PharoLauncherApplication >> newImageCreated [
	"We want to launch the freshly created image"
	imagesPresenter ifNotNil: [ imagesPresenter actionLaunch ]
]

{ #category : 'ui' }
PharoLauncherApplication >> newInform [

	^ PhLInformDialog newApplication: self
]

{ #category : 'instance creation' }
PharoLauncherApplication >> newJobList [

	^ PhLModalJobListPresenter newApplication: self
]

{ #category : 'ui' }
PharoLauncherApplication >> newRequest [

	^ PhLRequestDialog newApplication: self
]

{ #category : 'ui' }
PharoLauncherApplication >> newSelect [

	^ PhLSelectDialog newApplication: self
]

{ #category : 'configuring' }
PharoLauncherApplication >> openAsWorld: aBoolean [
	openAsWorld := aBoolean
]

{ #category : 'initialization' }
PharoLauncherApplication >> prepareAsStandaloneApplication [
	
	standalone := true.
	self class default: self.
	
	"I do not want the morphic world... nor the idle process annoying us"
	Smalltalk vm isRunningInWorkerThread 
		ifTrue: [ ProcessorScheduler idleTime: 3600000000*12 "12hs" ].

	self useBackend: #Gtk with: PhLGtkConfiguration new.
	self openAsWorld: false
]

{ #category : 'ui' }
PharoLauncherApplication >> pushProgress: aString with: aBlock [

	self jobList pushJob: (SpJob newTitle: aString block: aBlock)
]

{ #category : 'configuring' }
PharoLauncherApplication >> resetConfiguration [ 

	self configuration configure: self
]

{ #category : 'resetting' }
PharoLauncherApplication >> resetTemplateRepository [
	templateRepository := nil.
]

{ #category : 'private' }
PharoLauncherApplication >> safeExit [

	self windows ifNotEmpty: [ ^ self ].
	self isStandalone ifFalse: [ ^ self ].
	self shouldExitWhenNoMoreWindows ifFalse: [ ^ self ].
	self exitApplication
]

{ #category : 'accessing' }
PharoLauncherApplication >> scriptsDirectory [
	^ (scriptsDirectory ifNil: [ 
		   self class initializationScriptsDirectory: self class defaultInitializationScriptLocation ])
		  ensureCreateDirectory
]

{ #category : 'accessing' }
PharoLauncherApplication >> scriptsDirectory: aFileReference [
	scriptsDirectory := aFileReference
]

{ #category : 'asserting' }
PharoLauncherApplication >> shouldExitWhenNoMoreWindows [

	^ true
]

{ #category : 'ui' }
PharoLauncherApplication >> shouldUpdateTemplateSources [

	^ self newConfirm
		title: 'Update';
		label: 'Update available for Pharo Launcher templates sources!';
		acceptLabel: 'Update';
		cancelLabel: 'Remind me later';
		openModal
]

{ #category : 'ui' }
PharoLauncherApplication >> showError: anError [

	self newInform 
		title: anError name;
		label: anError longDescription;
		openModalWithParent: self topWindow
]

{ #category : 'running' }
PharoLauncherApplication >> start [

	self initializeImagesPresenter.

	openAsWorld ifTrue: [ 
		self startFull.
		^ self ].

	imagesPresenter open.
	
	self isStandalone ifTrue: [ self cleanProcesses ]
]

{ #category : 'running' }
PharoLauncherApplication >> startFull [
	
	imagesPresenter asWorldWindow 
		title: 'Pharo Launcher';
		open.
]

{ #category : 'configuring' }
PharoLauncherApplication >> switchThemeToDark [

	self configuration switchThemeToDark
]

{ #category : 'configuring' }
PharoLauncherApplication >> switchThemeToLight [

	self configuration switchThemeToLight
]

{ #category : 'accessing' }
PharoLauncherApplication >> templateRepository [
	^ 	templateRepository ifNil: [ templateRepository := self defaultTemplateRepository ] 
]

{ #category : 'accessing' }
PharoLauncherApplication >> templateRepository: aPhLTemplateGroupRepository [
	templateRepository := aPhLTemplateGroupRepository
]

{ #category : 'accessing' }
PharoLauncherApplication >> templatesClearedOnStartup [
	^ self class templatesClearedOnStartup
]

{ #category : 'ui' }
PharoLauncherApplication >> topWindow [
	"The window that will accept a modal window related to it. 
	 This is usually the top window, but in case of stacking dialogs, some times this is lost. 
	 In that case, I want still choose one window"
	
	super topWindow ifNotNil: [ :topWindow | ^ topWindow ].
	^ self windows 
		ifNotEmpty: [ :aCollection | aCollection last ]
		ifEmpty: [ nil ]
]

{ #category : 'private' }
PharoLauncherApplication >> unregisterWindow: aWindow [

	super unregisterWindow: aWindow.
	self safeExit
]
