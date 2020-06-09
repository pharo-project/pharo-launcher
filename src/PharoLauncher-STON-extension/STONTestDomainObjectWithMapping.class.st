"
Simple object used to test instance variables mapping before serialization and after deserialization.
"
Class {
	#name : #STONTestDomainObjectWithMapping,
	#superclass : #STONTestDomainObject,
	#category : #'PharoLauncher-STON-extension'
}

{ #category : #'ston mapping' }
STONTestDomainObjectWithMapping >> fromStonMapping [
	^ { #color -> #asString }
]

{ #category : #'ston mapping' }
STONTestDomainObjectWithMapping >> stonOnMapping [
	^ { #color -> [ :value | Color perform: value ] }
]
