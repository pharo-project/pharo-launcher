private
compatibleVm
	"Do not get the exact VM for the given image but only an image able to run the image to get its version number"

	^ self availableVirtualMachinesByImageFormat
		at: self imageFormatNumber asString
		ifPresent: [ :vm | vm executablePath ]
		ifAbsent: [ | vmPath |
			self fetchCompatibleVm.
			vmPath := (self availableVirtualMachinesByImageFormat at: self imageFormatNumber asString)
				executablePath ]