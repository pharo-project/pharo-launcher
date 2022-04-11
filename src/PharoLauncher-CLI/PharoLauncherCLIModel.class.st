"
Model used both for the test and the normal execution. When it is used by a normal user he doesn't need to change it, when it is used for tests the concerned repo is replaced with a Mock.
"
Class {
	#name : #PharoLauncherCLIModel,
	#superclass : #Object,
	#instVars : [
		'imageRepository',
		'templateRepository',
		'vmManager'
	],
	#category : #'PharoLauncher-CLI-Model'
}

{ #category : #accessing }
PharoLauncherCLIModel >> imageRepository [
	^ imageRepository
		ifNil: [ | configuration |
			configuration := PharoLauncherCLIConfiguration defaultConfiguration.
			self
				imageRepository:
					(PhLDirectoryBasedImageRepository
						forDirectory: configuration imagesDirectory).
			imageRepository ]
]

{ #category : #accessing }
PharoLauncherCLIModel >> imageRepository: aPhLDirectoryBasedImageRepository [
	imageRepository := aPhLDirectoryBasedImageRepository
]

{ #category : #accessing }
PharoLauncherCLIModel >> templateRepository [
	^ templateRepository
		ifNil: [ self templateRepository: PhLTemplateGroupRepository default.
			^ templateRepository ]
]

{ #category : #accessing }
PharoLauncherCLIModel >> templateRepository: aPathString [
	templateRepository:=aPathString 
]

{ #category : #accessing }
PharoLauncherCLIModel >> vmManager [
	^ vmManager
		ifNil: [ | configuration |
			configuration := PharoLauncherCLIConfiguration defaultConfiguration.
			PhLVirtualMachineManager vmStore: configuration vmsDirectory.
			self vmManager: PhLVirtualMachineManager new.
			^ vmManager ]
]

{ #category : #accessing }
PharoLauncherCLIModel >> vmManager: aPathString [
	vmManager:=aPathString 
]
