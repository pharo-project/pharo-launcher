unzipping
canUseSytemZip
	^ (OSProcess waitForCommand: 'unzip --help') succeeded