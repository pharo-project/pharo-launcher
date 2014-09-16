opening
openFull
	"this is needed, because TreeModels unregister themselves only on window a close event,
	but in fullscreen mode are no windows"
	PhLTitledTreeModel unsubscribeAllRepositories.
	^ self createLauncher openWorldWithSpec