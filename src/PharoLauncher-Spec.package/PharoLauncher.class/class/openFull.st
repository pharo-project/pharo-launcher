opening
openFull
	"this is needed, because TreeModels unregister themselves only on window a close event,
	but in fullscreen mode are no windows"
	| launcher |
	PhLTitledTreeModel unsubscribeAllRepositories.
	launcher := self createLauncher openWorldWithSpec.
	PluggableButtonMorph allInstances do: #changed. "Hack because buttons icons are not shown until you mouse over it ..."
	UIManager default defer: [ World changed ]. "Hack to get the Launcher window maximized at the startup even if seetings are loaded, then trigerring PharoLauncher>>#doAll"
	^ launcher