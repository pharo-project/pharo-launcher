unzipping
canUseSytemZip
	^ (PhLProcessWrapper waitForCommand: 'unzip --help') succeeded