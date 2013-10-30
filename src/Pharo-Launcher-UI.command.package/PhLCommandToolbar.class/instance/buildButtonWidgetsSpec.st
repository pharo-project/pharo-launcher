initialization
buildButtonWidgetsSpec
	"Return a collection where odd elements are ids and even elements are the class to instantiate (here PhLCommandButton). I return a collection that is suited to pass to #instantiateModels:."
	^ commandClasses
		inject: OrderedCollection new
		into: [ :specs :commandClass | 
			specs
				add: commandClass specId;
				add: #PhLCommandButton;
				yourself ]