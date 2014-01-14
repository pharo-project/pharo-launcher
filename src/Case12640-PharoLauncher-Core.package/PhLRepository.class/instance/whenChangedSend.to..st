announcements
whenChangedSend: aSelector to: aReceiver
	Transcript crShow: thisContext printString , '   ' , aSelector printString , '   ' , aReceiver printString , '    ' , self hash printString , '-->' , announcer hash printString.
	self halt.
	announcer when: ValueChanged send: aSelector to: aReceiver