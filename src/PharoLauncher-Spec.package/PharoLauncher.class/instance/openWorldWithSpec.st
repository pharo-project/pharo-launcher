protocol
openWorldWithSpec
	| value |
	self flag: 'I don''t know why I have to put this code here. Please also fix #openWithSpec'.
	value := super openWorldWithSpec.
	self initializeImageAndTemplates.
	^ value