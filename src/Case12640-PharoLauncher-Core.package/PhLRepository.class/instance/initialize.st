initialization
initialize
	super initialize.
	announcer := Announcer new.
	Transcript crShow: thisContext printString , '  announcer=' , announcer hash printString.
	wantNotification := true.