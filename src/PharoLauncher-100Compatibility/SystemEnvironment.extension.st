Extension { #name : 'SystemEnvironment' }

{ #category : '*PharoLauncher-100Compatibility' }
SystemEnvironment >> at: aKey put: anObject [
	"Override from Dictionary to check Undeclared and fix up
	references to undeclared variables."
	| index assoc registeredMethods |
	aKey isSymbol ifFalse: [ self error: 'Only symbols are accepted as keys in SystemDictionary' ].
	registeredMethods := #().
	((self includesKey: aKey) not and: [ Undeclared includesKey: aKey ]) ifTrue: [
 			| undeclared |
 			undeclared := Undeclared associationAt: aKey.
 			"Undeclared variables record using methods in a property, remove. Boostrap might have used Associations"
			(undeclared class == UndeclaredVariable) ifTrue: [
				registeredMethods := undeclared removeProperty: #registeredMethods ifAbsent: [ #() ]]. 
 			"and change class to be Global" 
 			self add: (undeclared primitiveChangeClassTo: GlobalVariable new).
 			Undeclared removeKey: aKey].
 	"code of super at:put:, not using Associations but GlobalVariable"
 	index := self findElementOrNil: aKey.
 	assoc := array at: index.
 	assoc
 		ifNil: [self atNewIndex: index put: (GlobalVariable key: aKey value: anObject). self flushClassNameCache]
 		ifNotNil: [assoc value: anObject].
	registeredMethods do: [ :aMethod | aMethod isInstalled ifTrue: [aMethod recompile] ].
 	^ anObject
]
