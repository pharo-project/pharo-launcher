public
myInstances
	"self myInstances"
	| result |
	result := OrderedCollection new.
	self myClasses do: [ :class | result addAll: class allInstances ].
	^result