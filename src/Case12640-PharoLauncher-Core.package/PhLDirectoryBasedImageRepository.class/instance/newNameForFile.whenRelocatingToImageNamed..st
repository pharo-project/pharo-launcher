private
newNameForFile: file whenRelocatingToImageNamed: targetName
	"Return the name that should be given to file when the file is going to be moved or copied to the image targetName. The file name is kept intact unless it must reflect the image name."
	^ (#('image' 'changes') includes: file extension)
		ifTrue: [ targetName , '.' , file extension ]
		ifFalse: [ file basename ]