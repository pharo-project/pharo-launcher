action
closeWindowsAndOpenDevelopmentEnvironment
	PanelMorph allInstancesDo: [  :pm | pm delete ].
	self closeAllWindows.
	TaskbarMorph reset.
	Workspace open contents: 'PharoLauncher open.'.
	
	"PanelMorph comes from use of #openWorldWithSpec"