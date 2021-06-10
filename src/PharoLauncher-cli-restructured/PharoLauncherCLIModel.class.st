"
Model used both for the test and the normal execution. When it is used by a normal user he doesn't need to change it, when it is used for tests the concerned repo is replaced with a Mock.
"
Class {
	#name : #PharoLauncherCLIModel,
	#superclass : #Object,
	#instVars : [
		'imageBaseRepository',
		'templateBaseRepository',
		'vmBaseRepository'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #accessing }
PharoLauncherCLIModel >> imageBaseRepository [
	^imageBaseRepository 
]

{ #category : #accessing }
PharoLauncherCLIModel >> imageBaseRepository: aPathString [
	imageBaseRepository := aPathString
]

{ #category : #accessing }
PharoLauncherCLIModel >> initialize [
	| configuration |
	configuration := PharoLauncherCLIConfiguration new.
	PhLVirtualMachineManager vmStore: configuration vmsDirectory.
	vmBaseRepository := PhLVirtualMachineManager new.
	PharoLauncherApplication default scriptsDirectory:  configuration initScriptsDirectory asFileReference.
	imageBaseRepository := PhLDirectoryBasedImageRepository
		forDirectory: configuration imagesDirectory.
	templateBaseRepository := PhLTemplateGroupRepository default
]

{ #category : #accessing }
PharoLauncherCLIModel >> templateBaseRepository [
	^templateBaseRepository 
]

{ #category : #accessing }
PharoLauncherCLIModel >> templateBaseRepository: aPathString [
	templateBaseRepository:=aPathString 
]

{ #category : #accessing }
PharoLauncherCLIModel >> vmBaseRepository [
	^vmBaseRepository
]

{ #category : #accessing }
PharoLauncherCLIModel >> vmBaseRepository: aPathString [
	vmBaseRepository:=aPathString 
]
