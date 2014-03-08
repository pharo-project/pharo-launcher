private
classesWithClassVariables
	"self classesWithClassVariables"
	| result |
	result := Dictionary new.
	self myClasses do: 
	[ 	:class | class classVarNames isNotEmpty 
			ifTrue: [  result at: class put: class classPool ]
	]. 
	^ result.