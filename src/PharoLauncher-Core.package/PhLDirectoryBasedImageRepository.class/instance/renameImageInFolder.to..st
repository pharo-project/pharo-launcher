private
renameImageInFolder: targetDirectory to: newName
	targetDirectory children
		do: [ :file | 
			| targetFilename |
			targetFilename := self
				newNameForFile: file
				whenRelocatingToImageNamed: newName.
			file basename = targetFilename
				ifFalse: [ file renameTo: targetFilename ] ]