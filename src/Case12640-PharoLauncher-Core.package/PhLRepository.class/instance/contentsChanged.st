announcements
contentsChanged
	"Called me to announce that I changed"

	wantNotification
		ifTrue: [ announcer announce: ValueChanged new ]