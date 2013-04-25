as yet unclassified
open

	| gui |
	gui := ImageLauncherUI new.
	gui openWithSpec.
	gui model: ImageLauncherModel initialize.
	gui listElements: (gui model buildList) asArray 