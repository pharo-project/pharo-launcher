instance creation
open
	| url pharo | 
	url := self urlList.
	pharo := self pharoList.
	self new 
		pharoVersions: pharo;
		urlList: url;
		openInWorld.