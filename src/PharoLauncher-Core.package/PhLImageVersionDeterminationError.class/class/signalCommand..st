signalling
signalCommand: aCommandString
	^ self new
		setCommand: aCommandString;
		signal