Extension { #name : 'SettingNodeBuilder' }

{ #category : '*PharoLauncher-Spec2' }
SettingNodeBuilder >> groupName: aSymbol [
	self parent: aSymbol
]

{ #category : '*PharoLauncher-Spec2' }
SettingNodeBuilder >> defaultValue: anObject [
	self default: anObject
]
