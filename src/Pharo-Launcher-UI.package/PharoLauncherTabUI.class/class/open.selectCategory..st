as yet unclassified
open: anImageLauncherModel selectCategory: aString

	| gui |
	gui := PharoLauncherTabUI new.
	gui model: anImageLauncherModel .
	gui listElements: (gui model buildList: aString) asArray .
	^ gui buildWithSpec: #defaultSpec