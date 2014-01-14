actions
extractTo: aDirectory
	"Extract myself to aDirectory, making sure to name the resulting image after me"

	"In most cases, you probably want to call #extractTo:named: and let the user choose the new name for the image."

	self extractTo: aDirectory named: self name