opening
openFull
	"this is needed, because TreeModels unregister themselves only on window a close event,
	but in fullscreen mode are no windows"
	| launcher |
	PhLTitledTreePresenter unsubscribeAllRepositories.
	launcher := self createLauncher openWorldWithSpec.
	PluggableButtonMorph allInstances do: #changed. "Hack because buttons icons are not shown until you mouse over it ..."
	^ launcher