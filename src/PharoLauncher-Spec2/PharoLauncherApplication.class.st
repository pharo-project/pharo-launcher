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
		'standalone',
		'vmUpdateChecker',
		'launcherUpdateChecker'
	],
	#classVars : [
		'CompactMode',
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
PharoLauncherApplication class >> compactMode [

	^ CompactMode ifNil: [ CompactMode := false ]
]

{ #category : 'settings' }
PharoLauncherApplication class >> compactMode: aBoolean [

	CompactMode := aBoolean
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
		  ifTrue: [ { (SimpleServiceEntry provider: self label: 'Launch image' selector: #launchImage:) } ]
		  ifFalse: [
				  (self isImageFolder: fullName)
					  ifTrue: [ { (SimpleServiceEntry provider: self label: 'Import image' selector: #importImageFolder:) } ]
					  ifFalse: [ #(  ) ] ]
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

{ #category : 'file service' }
PharoLauncherApplication class >> importImageFolder: fullName [

	PhLImportImageCommand new
		context: self default mainPresenter;
		importFromFolder: fullName asFileReference
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
PharoLauncherApplication class >> isImageFolder: fullName [

	| folder |
	folder := fullName asFileReference.
	^ folder isDirectory and: [ (PhLImportImageCommand imageFilesIn: folder) isNotEmpty ]
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

   "Default may be a PhLNotificationCenter when the launcher runs headless"
   Default
		releaseSharedResources;
		reset.
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
					description: 'When enabled, Launcher startup clears the Templates List. ' , String cr , 'When disabled, Launcher startup retains the Templates List from last run.'.

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
					description: 'When PharoLauncher is updated through Monticello ' , 'sometimes you need to clear persistent state to pick up new changes.' , String cr
						, 'Clicking this box is a one-shot action, i.e. this state is also reset.' , String cr , 'Note, all open windows are clsoed and the application restarted.' ]
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
PharoLauncherApplication >> defaultContext [
	"Answer the context to use when no `PhLCurrentContext` is set"

	^ self instantiate: SpPresenter
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

{ #category : 'accessing' }
PharoLauncherApplication >> imagesPresenter [

	^ imagesPresenter
]

{ #category : 'accessing' }
PharoLauncherApplication >> initializationScripts [
	| files |
	
	files := self scriptsDirectory files 
		select: [ :file | file extension = 'st' ].	
	files := files copyWithFirst: PhLNoInitializationScript new.
	
	^ files
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
			self useBackend: #Morphic with: PhLMorphicConfiguration new ].
	
	imageRepository :=  PhLDirectoryBasedImageRepository default.
	imageRepository reset.
	
	self templatesClearedOnStartup 
		ifTrue: [ self class resetTemplateRepository ].
	self resetTemplateRepository
]

{ #category : 'initialization' }
PharoLauncherApplication >> initializeImagesPresenter [
	^ imagesPresenter := PhLImagesPresenter
		newApplication: self
		model: imageRepository
]

{ #category : 'announcements' }
PharoLauncherApplication >> initializeLauncherUpdateChecker [

	self launcherUpdateChecker announcer
		unsubscribe: self;
		when: PhLLauncherUpdateCheckDone
		do: [ :event | "Announced from the update checker process: the UI must be updated by the UI process"
			self defer: [ self launcherUpdateCheckDone ] ]
		for: self
]

{ #category : 'initialization' }
PharoLauncherApplication >> initializeProgressRunner [
	"Show the progress of long running operations (downloads, extractions) in Spec windows"

	ITProgressRunner default: (ITSpecProgressRunner application: self)
]

{ #category : 'announcements' }
PharoLauncherApplication >> initializeTemplateSourcesAnnouncer [
	| announcer |
	announcer := PhLTemplateSourcesAnnouncer default.
	announcer unsubscribe: self.
	announcer
		when: PhLTemplateSourcesUpdateAvailable
			do: [ :event | "Announced from the update checker process: the modal dialog must be opened by the UI process"
				self defer: [ self sourcesFileUpdateAvailable ] ]
			for: self;
		when: PhLTemplateSourcesUpdated do: [ :event | self resetTemplateRepository ] for: self
]

{ #category : 'announcements' }
PharoLauncherApplication >> initializeVmUpdateChecker [

	self vmUpdateChecker announcer
		unsubscribe: self;
		when: PhLVmUpdateCheckDone
		do: [ :event | "Announced from the update checker process: the UI must be updated by the UI process"
			self defer: [ self vmUpdateCheckDone ] ]
		for: self
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

{ #category : 'events' }
PharoLauncherApplication >> launcherUpdateCheckDone [
	"Warn the user without interrupting: the About button of the main window shows that a newer launcher is published"

	imagesPresenter ifNotNil: [ :presenter | presenter refreshLauncherUpdate ]
]

{ #category : 'accessing' }
PharoLauncherApplication >> launcherUpdateChecker [

	^ launcherUpdateChecker ifNil: [ launcherUpdateChecker := PhLLauncherUpdateChecker new ]
]

{ #category : 'accessing' }
PharoLauncherApplication >> launcherUpdateChecker: aPhLLauncherUpdateChecker [

	launcherUpdateChecker := aPhLLauncherUpdateChecker
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

{ #category : 'initialization' }
PharoLauncherApplication >> releaseProgressRunner [
	"The progress runner is global: an application that is no more the default one must not show progress"

	ITProgressRunner default application == self
		ifTrue: [ ITProgressRunner default: nil ]
]

{ #category : 'initialization' }
PharoLauncherApplication >> releaseSharedResources [
	"Announcers and the progress runner are global: an application that is no more the default one must release them"

	self
		unsubscribeFromAnnouncers;
		releaseProgressRunner
]

{ #category : 'configuring' }
PharoLauncherApplication >> resetConfiguration [ 

	self configuration configure: self
]

{ #category : 'resetting' }
PharoLauncherApplication >> resetTemplateRepository [
	templateRepository := nil.
]

{ #category : 'running' }
PharoLauncherApplication >> runUpdateChecker [
	"Template sources are checked first: their update is proposed before the one of virtual machines."

	PhLUpdateChecker runChecks: {
			[ self launcherUpdateChecker check ].
			[ PhLTemplateSourcesUpdateChecker new check ].
			[ self vmUpdateChecker check ] }
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

{ #category : 'events' }
PharoLauncherApplication >> sourcesFileUpdateAvailable [

	self shouldUpdateTemplateSources ifFalse: [ ^ self ].
	
	PhLPharoTemplateSources fromFile updateSourcesFile.
	self resetTemplateRepository
]

{ #category : 'running' }
PharoLauncherApplication >> start [

	self initializeImagesPresenter.
	self initializeProgressRunner.

	openAsWorld
		ifTrue: [ self startFull ]
		ifFalse: [ imagesPresenter open ].

	self initializeTemplateSourcesAnnouncer.
	self initializeVmUpdateChecker.
	self initializeLauncherUpdateChecker.
	self runUpdateChecker.

	self isStandalone ifTrue: [ self cleanProcesses ]
]

{ #category : 'running' }
PharoLauncherApplication >> startFull [

	| world |
	world := imagesPresenter asWorldWindow.
	world
		title: 'Pharo Launcher';
		open.
	"The world presenter does not register itself as an application window"
	self registerWindow: world
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

{ #category : 'announcements' }
PharoLauncherApplication >> unsubscribeFromAnnouncers [
	"Announcers are global: an application that is no more the default one must stop 
	 handling announcements"

	PhLTemplateSourcesAnnouncer default unsubscribe: self.
	PhLVmUpdateAnnouncer default unsubscribe: self.
	PhLLauncherUpdateAnnouncer default unsubscribe: self
]

{ #category : 'events' }
PharoLauncherApplication >> vmUpdateCheckDone [
	"Warn the user without interrupting: the main window shows how many VMs can be updated"

	imagesPresenter ifNotNil: [ :presenter | presenter refreshVmUpdates ]
]

{ #category : 'accessing' }
PharoLauncherApplication >> vmUpdateChecker [

	^ vmUpdateChecker ifNil: [ vmUpdateChecker := PhLVmUpdateChecker new ]
]

{ #category : 'accessing' }
PharoLauncherApplication >> vmUpdateChecker: aPhLVmUpdateChecker [

	vmUpdateChecker := aPhLVmUpdateChecker
]
