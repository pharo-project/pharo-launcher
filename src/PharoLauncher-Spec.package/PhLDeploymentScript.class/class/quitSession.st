actions
quitSession
	self flag: 'TODO'.
	"Since UserManager is now over, there is no clean way to avoid warning when we juast ask to quit the image. More general, there should be a way to have an image in read/only mode"
	Save 
		ifTrue: [Smalltalk snapshot: true andQuit: true] 
		ifFalse: [Smalltalk snapshot: false andQuit: true]
 