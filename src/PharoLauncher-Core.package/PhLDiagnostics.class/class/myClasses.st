public
myClasses
	"self myClasses"
	| result |
	result := OrderedCollection new.
	self myPackages do:
	[ 	:package |
		result addAll: package definedClasses.
	].
	^ result