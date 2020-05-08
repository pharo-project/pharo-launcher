Class {
	#name : #PhLRemoteTemplateTest,
	#superclass : #PhLAbstractTemplateTest,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #coverage }
PhLRemoteTemplateTest >> classToBeTested [
	^ PhLRemoteTemplate 
]

{ #category : #'instance creation' }
PhLRemoteTemplateTest >> newTemplate [
	^ self classToBeTested name: 'Test' url: 'http://foo.example.com/Test.zip'
]
