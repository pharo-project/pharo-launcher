initialize-release
openInWorld
	"| content|
	self builder: UITheme builder.
	content := self addEntry: self fetchOnlineImage.| dialog builder list container text |
	"
	| dialog container |
	self fetchOnlineImage.
	dialog := StandardWindow new.
	
	listModel := ListModel new list: ( self buildList ).
	listModel addDependent: self.	
	
	button := (dialog newButtonFor: self action: #loadAndRun label:  self buttonName help: 'Load and run seleceted image')
		hResizing: #spaceFill.
	
	container := PanelMorph new.
	container 
		changeTableLayout; 
		listDirection: #rigthToLeft.
		
	container addMorph:(
		(dialog newColumn: {
		(dialog newTitle: 'List of Pharo versions' for: (
			(dialog newListFor: listModel
				list: #list
				selected: #selectionIndex 
				changeSelected: #selectionIndex:
				help: 'List of Pharo versions') minWidth: 100;minHeight: 100)).
		(button).
		})).
	
	dialog
		addMorph: container
		frame: (0@0 corner: 1@1).	
	dialog openInWorld.
	dialog
		width: 300;
		height: 300.
	dialog title: 'Image Launcher'.