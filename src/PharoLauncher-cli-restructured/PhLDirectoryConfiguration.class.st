Class {
	#name : #PhLDirectoryConfiguration,
	#superclass : #PhLCliCommand,
	#instVars : [
		'imageBaseRepository',
		'templateBaseRepository',
		'VMBaseRepository'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #tests }
PhLDirectoryConfiguration class >> test [ 
   |a|
	a := self new.
	a VMBaseRepository: nil.
	a imageBaseRepository: nil.
	a templateBaseRepository: nil.
	^a
	
]

{ #category : #accessing }
PhLDirectoryConfiguration >> VMBaseRepository [
	^VMBaseRepository
]

{ #category : #accessing }
PhLDirectoryConfiguration >> VMBaseRepository: aPath [
	VMBaseRepository:=aPath 
]

{ #category : #accessing }
PhLDirectoryConfiguration >> imageBaseRepository [
	^imageBaseRepository 
]

{ #category : #accessing }
PhLDirectoryConfiguration >> imageBaseRepository: aPath [
	imageBaseRepository := aPath
]

{ #category : #accessing }
PhLDirectoryConfiguration >> initialize [
	VMBaseRepository := PhLVirtualMachineManager new.
	imageBaseRepository := PhLDirectoryBasedImageRepository default.
	templateBaseRepository := PhLTemplateGroupRepository default.
]

{ #category : #accessing }
PhLDirectoryConfiguration >> templateBaseRepository [
	^templateBaseRepository 
]

{ #category : #accessing }
PhLDirectoryConfiguration >> templateBaseRepository: aPath [
	templateBaseRepository:=aPath 
]
