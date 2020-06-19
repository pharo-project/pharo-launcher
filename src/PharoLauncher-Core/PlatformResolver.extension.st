Extension { #name : #PlatformResolver }

{ #category : #'*PharoLauncher-Core' }
PlatformResolver >> launcherImagesLocation [
	<origin>
	^ PhLDirectoryBasedImageRepository location
]

{ #category : #'*PharoLauncher-Core' }
PlatformResolver >> launcherUserFilesLocation [
	"Where to put the user files (images, virtual machines) for the pharo launcher"
	<origin>
	^ self documents / 'Pharo'
]

{ #category : #'*PharoLauncher-Core' }
PlatformResolver >> launcherVMsLocation [
	<origin>
	^ PhLVirtualMachineManager vmStore
]

{ #category : #'*PharoLauncher-Core' }
PlatformResolver >> vmExecutableName [
	self subclassResponsibility
]
