Extension { #name : #SettingDeclaration }

{ #category : #'*PharoLauncher-Spec2' }
SettingDeclaration >> inputWidgetForFileOrDirectoryWithAction: aSymbol [
	"Small update from the original version to get text auto-accepted as default"
	| list button |
	list := EditableDropListMorph
		on: self
		list: #list
		selected: #index
		changeSelected: #index:
		useIndex: true
		addToList: #addToList:
		class: String
		getEnabled: #enabled
		default: self defaultValue.
	list
		ghostText: self ghostHelp;
		hResizing: #rigid;
		width: 450;
		wantsFrameAdornments: true.
	list contentMorph autoAccept.
	button := self theme
		newButtonIn: self currentWorld
		for: self
		getState: nil
		action: aSymbol
		arguments: nil
		getEnabled: nil
		label:
			(AlphaImageMorph new
				image: (self iconNamed: #smallOpenIcon))
		help: 'Open directory chooser dialog' translated.
	^ self theme
		newRowIn: self currentWorld
		for:
			{list.
			button}
]
