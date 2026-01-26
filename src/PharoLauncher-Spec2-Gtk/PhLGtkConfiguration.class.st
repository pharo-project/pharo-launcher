Class {
	#name : 'PhLGtkConfiguration',
	#superclass : 'SpGtkConfiguration',
	#category : 'PharoLauncher-Spec2-Gtk',
	#package : 'PharoLauncher-Spec2-Gtk'
}

{ #category : 'configuring' }
PhLGtkConfiguration >> addPredefinedStyles [

	super addPredefinedStyles.
	self addCSSProviderFromString: self palette.
	self addCSSProviderFromString: self launcherStyle
]

{ #category : 'configuring' }
PhLGtkConfiguration >> configureGeneral: anApplication [

	PhLAppearanceSettings uiThemeClass ifNotNil: [ :aThemeClass | 
		aThemeClass uniqueInstance activateOn: anApplication ].
	
	GtkMorphicClipboard new beDefault
]

{ #category : 'configuring' }
PhLGtkConfiguration >> configureOSX: anApplication [

	super configureOSX: anApplication.
	self addCSSProviderFromString: self macOSStyle
]

{ #category : 'configuring' }
PhLGtkConfiguration >> configureWindows: anApplication [

	super configureWindows: anApplication.
	self addCSSProviderFromString: self windowsStyle
]

{ #category : 'configuring' }
PhLGtkConfiguration >> darkPalette [
	
	^ '
:root { 
	--dim-color: #d3d3d3;
}'
]

{ #category : 'initialization' }
PhLGtkConfiguration >> initialize [ 

	super initialize.
	self applicationId: 'org.pharo.PharoLauncher'.
	self applicationClass: AdwApplication
]

{ #category : 'testing' }
PhLGtkConfiguration >> isDarkTheme [

	^ PharoLauncherSettings default uiThemeClass
		  ifNil: [ self isSystemUsingDarkTheme ]
		  ifNotNil: [ :uiThemeClass | uiThemeClass uniqueInstance isLight not ]
]

{ #category : 'testing' }
PhLGtkConfiguration >> isSystemUsingDarkTheme [

	^ GRunLoop defer: [ AdwStyleManager default isDark ]
]

{ #category : 'accessing - styles' }
PhLGtkConfiguration >> launcherStyle [

	^ '
label {  
	color: var(--text-color)
}
label.list_header { 
	padding: 8px;
	font-weight: bold;
}
box.status_bar {
	min-height: 30px;
	padding: 5px;
}
actionbar.status_bar, box.action_area {
	border-spacing: 0px;
	border-radius: 0;
	border-bottom-left-radius: 13px; 
	border-bottom-right-radius: 13px;
	border-left: none; 
	border-right: none; 
}
label.form_header {
	font-size: larger;
}
box.status_bar label.status_message {
	font-weight: normal;
	color: var(--dim-color);
}
grid.form, box.settings_form {
	margin: 10px 10px 0px 10px;
	padding: 15px 30px 15px 30px;
	border-spacing: 0px;
}
/* box inside a form */
box.settings_form box {
	margin: 0px;	
	padding: 3px 0px 3px 0px;
}
box.settings_form box.section {
	padding: 8px 0px 8px 0px;
}
scrolledwindow.frame {
	border-style: solid;
	border-radius: 5px;
}
scrolledwindow textview { 
	border-radius: 5px;
	padding: 5px;
}
grid.form button.link {
	margin: 0px;
	padding: 0px;
}
box {
	border-spacing: 5px;
}
box.choice_area {
	padding: 15px;
}
box.choice_area checkbutton {
	padding-left: 10px;
}
box.choice_area checkbutton label { 
	margin-left: 10px;
}

box.appearance {  
	margin: 10px;
	padding: 5px;
}

box.welcomeThemeImage { 
	min-width: 280px;
	min-height: 280px;
	margin: 20px 0px 0px 0px;
	padding: 5px;
	/* color: var(--accent-fg-color); */
}
box.welcomeThemeImage image { 
	min-width: 180px;
}
box.welcomeThemeImage label { 
	color: var(--text-color);
}
box.welcomeThemeSelected {
	background-color: var(--accent-bg-color);
}
box.welcomeThemeSelected label {
}
.aboutIcon { 
	min-width: 120px;
	min-height: 120px;
}
.stToolbar label {
	font-weight: normal;
	letter-spacing: 0.05em;
	color: var(--text-color);
}
'
]

{ #category : 'configuring' }
PhLGtkConfiguration >> lightPalette [
	
	^ '
:root { 
	--dim-color: darkgray; 
}'
]

{ #category : 'accessing - styles' }
PhLGtkConfiguration >> macOSStyle [

	^ '* {
  /* font-family: "Helvetica Neue", "Lucida Grande", sans-serif; */
}'
]

{ #category : 'configuring' }
PhLGtkConfiguration >> palette [
	
	^ self isDarkTheme 
		ifTrue: [ self darkPalette ]
		ifFalse: [ self lightPalette ] 
]

{ #category : 'configuring' }
PhLGtkConfiguration >> switchThemeToDark [

	GRunLoop defer: [ 
		AdwStyleManager default forceDark.
		self addCSSProviderFromString: self palette ].
	
]

{ #category : 'configuring' }
PhLGtkConfiguration >> switchThemeToLight [

	GRunLoop defer: [ 
		AdwStyleManager default forceLight.
		self addCSSProviderFromString: self palette ]
]

{ #category : 'accessing - styles' }
PhLGtkConfiguration >> windowsStyle [

	^ '* { 
	/* font-family: "Segoe UI", Tahoma, sans-serif; */
}
'
]
