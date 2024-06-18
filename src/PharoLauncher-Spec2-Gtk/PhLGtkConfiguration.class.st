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
box.status_bar {
	min-height: 40px;
	padding: 10px;
}
actionbar.status_bar {
	border-radius: 0;
	border-bottom-left-radius: 13px; 
	border-bottom-right-radius: 13px;
	border-left: none; 
	border-right: none; 
}
actionbar.status_bar label.form_header {
	font-size: larger;
}
box.status_bar label.status_message {
	font-weight: lighter;
}
grid.form {
	padding: 15px;
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
