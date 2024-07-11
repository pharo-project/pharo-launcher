Class {
	#name : 'PhLGtkConfiguration',
	#superclass : 'SpGtkConfiguration',
	#category : 'PharoLauncher-Spec2-Gtk',
	#package : 'PharoLauncher-Spec2-Gtk'
}

{ #category : 'configuring' }
PhLGtkConfiguration >> addPredefinedStyles [

	super addPredefinedStyles.
	self addCSSProviderFromString: self launcherStyle
]

{ #category : 'configuring' }
PhLGtkConfiguration >> launcherStyle [

	^ '
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
	font-weight: lighter;
}
grid.form, box.settings_form {
	margin: 10px 10px 0px 10px;
	padding: 15px 30px 15px 30px;
	border-spacing: 0px;
}
.welcomeThemeImage image { 
	min-width: 200px;
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
'
]
