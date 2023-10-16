"
Model used both for the test and the normal execution. 
When it is used by a user, dafault configuration is used.
When it is used for tests, repositories are replaced by mocks.
"
Class {
	#name : #PharoLauncherCLIModel,
	#superclass : #Object,
	#instVars : [
		'imageRepository',
		'templateRepository',
		'vmManager',
		'configuration'
	],
	#category : #'PharoLauncher-CLI-Model'
}

{ #category : #'instance creation' }
PharoLauncherCLIModel class >> fromConfiguration: aPharoLauncherConfiguration [

	^ self new
		configuration: aPharoLauncherConfiguration;
		yourself
]

{ #category : #'instance creation' }
PharoLauncherCLIModel class >> fromDefaultConfiguration [

	^ self fromConfiguration: PharoLauncherCLIConfiguration defaultConfiguration
]

{ #category : #accessing }
PharoLauncherCLIModel >> configuration: aPharoLauncherConfiguration [

	configuration := aPharoLauncherConfiguration
]

{ #category : #accessing }
PharoLauncherCLIModel >> imageRepository [
	^ imageRepository
		ifNil: [ self
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
					templateRepository ]
]

{ #category : #accessing }
PharoLauncherCLIModel >> templateRepository: aPathString [
	templateRepository := aPathString 
]

{ #category : #accessing }
PharoLauncherCLIModel >> vmManager [
	^ vmManager
		ifNil: [ PhLVirtualMachineManager vmStore: configuration vmsDirectory.
			self vmManager: PhLVirtualMachineManager new.
			vmManager ]
]

{ #category : #accessing }
PharoLauncherCLIModel >> vmManager: aPathString [
	vmManager := aPathString 
]
