updating
update
	"The context just changed, update all the buttons"
	self buttonsDo: [ :button | button context: self context ]