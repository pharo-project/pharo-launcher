updating
updateContext
	"The context just changed, update all the buttons"

	self context notNil
		ifTrue: [ self buttonsDo: [ :button | button context: self context ] ]