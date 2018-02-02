as yet unclassified
open

	| gui |
	gui := ImageLauncherTabUI new.
	gui model: ImageLauncherModel initialize.
	gui listElements: (gui model buildList) asArray .
	^ gui buildWithSpec: #defaultSpec
	