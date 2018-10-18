Class {
	#name : #PhLLocalTemplateTest,
	#superclass : #PhLAbstractTemplateTest,
	#category : 'PharoLauncher-Tests-Core'
}

{ #category : #coverage }
PhLLocalTemplateTest >> classToBeTested [
	^ PhLLocalTemplate 
]

{ #category : #'instance-creation' }
PhLLocalTemplateTest >> newTemplate [
	^ PhLLocalTemplate name: 'Test' zipFile: root / 'Test.zip'
]
