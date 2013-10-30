protocol
openWithSpec
	| value |
	self flag: 'I don''t know why I have to put this code here. Please also fix #openWorldWithSpec'.
	value := super openWithSpec.
	self initializeImageAndTemplates.
	^ value