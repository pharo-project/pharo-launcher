"
I'm an extension of STONWriter allowing to map instance variables of an object just after the deserialization
"
Class {
	#name : #STONReaderWithMapping,
	#superclass : #STONReader,
	#category : #'PharoLauncher-STON-extension'
}

{ #category : #parsing }
STONReaderWithMapping >> parseObject [
	| targetClass reference object |
	[
		reference := self newReference.
		targetClass := self parseClass.
		object := targetClass fromSton: self .
		object fromStonMapping asDictionary
			keysAndValuesDo: [ :varName :block | object instVarNamed: varName put: (block value: (object instVarNamed: varName)) ].
		self setReference: reference to: object ]
		on: NotFound 
		do: [ :notFound |
			acceptUnknownClasses 
				ifTrue: [ 
					object := STON mapClass new.
					self storeReference: object.
					self parseMapDo: [ :key :value |
						object at: key put: value ].
					object at: STON classNameKey put: notFound object ]
				ifFalse: [ self error: 'Cannot resolve class named ', notFound object printString ] ].
	^ object
]
