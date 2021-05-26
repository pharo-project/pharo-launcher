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
PharoLauncherCLIModel >> imageBaseRepository: aPath [
	imageBaseRepository := aPath
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
PharoLauncherCLIModel >> templateBaseRepository: aPath [
	templateBaseRepository:=aPath 
]

{ #category : #accessing }
PharoLauncherCLIModel >> vmBaseRepository [
	^vmBaseRepository
]

{ #category : #accessing }
PharoLauncherCLIModel >> vmBaseRepository: aPath [
	vmBaseRepository:=aPath 
]
