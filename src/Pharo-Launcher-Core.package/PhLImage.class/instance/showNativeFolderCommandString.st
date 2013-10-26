printing
showNativeFolderCommandString 
	| folderPath |
	folderPath := Path withAll: file pathSegments allButLast. 
	OSProcess isWindows ifTrue: [  ^ 'cmd.exe /C "start ' ,  folderPath printString , ' " ' ].
	^nil.
	
	"
	This method returns a string for OSProcess to execute to display an OS folder outside the image. 
	Other OS platforms need to be fleshed out here. This is not very OO, but is the simplest first pass.  	
	"