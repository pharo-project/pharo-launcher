initialization
setFocusOrder
	"I have no idea what this #focusOrder is about, but it looks important :-)"
	self focusOrder removeAll.
	self buttonsDo: [ :button | self focusOrder add: button ].