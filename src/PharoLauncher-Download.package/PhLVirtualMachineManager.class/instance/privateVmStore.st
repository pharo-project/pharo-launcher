private
privateVmStore
	"The private store is used to fetch one VM per image format and open image to determine their pharo version number (e.g. 6.0, 7.0, etc.). Then we download the latest stable VM for the given Pharo image version."
	^ (self vmStore / 'private') ensureCreateDirectory