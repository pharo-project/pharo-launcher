Extension { #name : #Collection }

{ #category : #'*PharoLauncher-CLI' }
Collection >> getMaxWithOn: printBlock [
	"evaluate print block and obtain string size, return max value from collection"
	^ (self collect: [ :item | (printBlock value: item) size ]) max
]
