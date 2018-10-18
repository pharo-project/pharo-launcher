Extension { #name : #ZnUrl }

{ #category : #'*pharolauncher-core' }
ZnUrl >> jenkinsOptions [
	| options |
	options := Dictionary new.
	(self segments atWrap: -2)
		splitOn: $,
		do: [ :option | 
			| pair |
			pair := option splitOn: $=.
			pair size ~= 2
				ifTrue: [ ^ Dictionary new	"the url is not properly formatted, we can't extract anything." ].
			options at: pair first put: pair second ].
	^ options
]
