announcements
contentsChanged
	"Called me to announce that I changed"
	Transcript crShow: thisContext printString , '  ' , announcer hash printString.
	wantNotification
		ifTrue: [ announcer announce: ValueChanged new ]