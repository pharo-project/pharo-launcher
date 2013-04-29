as yet unclassified
open

	| gui |
	gui := PharoLauncherTabUI new.
	gui model: PharoLauncherModel initialize.
	gui listElements: (gui model buildList) asArray .
	^ gui buildWithSpec: #defaultSpec
	