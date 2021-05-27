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
	vmBaseRepository := PhLVirtualMachinesDataSource default.
	imageBaseRepository := PhLDirectoryBasedImageRepository default.
	templateBaseRepository := PhLTemplateGroupRepository default.
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
