action
closeWindowsAndOpenDevelopmentEnvironment
	PanelMorph allInstancesDo: [  :pm | pm delete ].
	self new closeAllWindows.
	Workspace open contents: 'PharoLauncher open.'.
	PharoLauncher browse.
	
	"PanelMorph comes from use of #openWorldWithSpec"
	