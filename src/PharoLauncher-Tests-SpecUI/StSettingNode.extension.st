Extension { #name : 'StSettingNode' }

{ #category : '*PharoLauncher-Tests-SpecUI' }
StSettingNode >> settingNodeIdentifier [
	| id |
	
	id := ''.
	parentName ifNotNil: [ id := '#' , parentName ].
	^ id , '#', self settingDeclaration name
]
