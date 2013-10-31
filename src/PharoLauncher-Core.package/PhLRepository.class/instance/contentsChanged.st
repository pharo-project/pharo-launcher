private
contentsChanged
	"Called by my subclasses to announce that they changed"

	wantNotification
		ifTrue: [ announcer announce: ValueChanged new ]