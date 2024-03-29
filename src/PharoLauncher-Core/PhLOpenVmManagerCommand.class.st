"
Open the VM Manager UI
"
Class {
	#name : #PhLOpenVmManagerCommand,
	#superclass : #PhLGeneralCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLOpenVmManagerCommand >> asSpecCommand [
	^ super asSpecCommand
		iconProvider: self;
		iconName: #configurationIcon;
		yourself
]

{ #category : #executing }
PhLOpenVmManagerCommand >> execute [

	(PhLVMPresenter
		 newApplication: self application
		 model: PhLVirtualMachinesDataSource default) open
]

{ #category : #accessing }
PhLOpenVmManagerCommand >> icon [
	"encoded with 
		ZnBase64Encoder new encode: 'Cog-icon-grey.png' asFileReference binaryReadStream upToEnd."
	^ ImageReadWriter formFromStream: (ZnBase64Encoder new decode: 
		'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4gkECQkiHlkkLQAAAu1JREFUOMttk09oXFUYxX/33Zs3k8wbhmQaMyUWBy00Jg1Yl1p3igpqwHaSgAs3QjZF60JwZWYVk6wEkSQlGxcuMqM7hUqxRJSIUs0iZqwiE9qq8TExf18yee/d+66bMUyxZ/Wtzvm+c84nAMbGxgAeX1paul0qlc4Aa8ArjuN8DZxPkuSXarVqeAAEQKlUAlgBHgKanuedD4LgLvAP0A0MDw0NBYBTLpeTdgKnbf4ik8k8BjhBEFwF7mQymQvAV5VK5XB5eVkNDg4mlUpFWmvFyQYt9R+llE8aY2ySJGfz+Xwd6NjZ2dmUUuajKLolpXy5Wq3+DWCtBRBCCCvGx8cBilrrN9Pp9NthGC4JIT601o6nUqkrcRx/XigUfk6S5KOurq4/gFFr7crGxsZmtVo17R5cB54HjlKpVFcYhlprvem6blQsFovAmrX212w2OxYEwQszMzNfAkKUy2UAZ319/VXgB6Agpfzedd2rhULhchzHF13XBTgEmkqpU1rrm9bah2dnZ8+pFkECfNq67d7AwMCjSqk/R0ZG3M7OzovHx8erxphnpJSHWusPcrncW7u7uzcBVHsko6OjAM7U1JSo1+sdvu87LVIcx3Huy1+IGED95+ji4uIlpdStMAxPHxwcrCil3nNd93Iul2N/f/9CHMc+cKSUyu/t7d0ATp8UaWFhAeCG4zjPGmOa2Wy2MwiCWErpG2OO6vX6GWttzXGc3z3PGwuC4MXp6enrgJBzc3NYa4tCiEc8z3sqiqLPoih6Awg9z3suDMNvtNaf5HK5d5rN5sdRFN0xxqz29/fv12q1RLTUV13XfSKKImuMOSulrAMdwF/pdPpUFEU/JUny0sTExOb/itR2wrs9PT3vb29v3wauWWsv9fb2Pr21tXWtu7t7ApC1Ws0AanJy0ggh7IkH8/PzAN8JIfLAcV9f37Dv+3eBLaBHaz3caDQe+EyqFRHA68aY34B+3/fXgNestd8Cg41G46itL/fhX0CxZrLKWx8FAAAAAElFTkSuQmCC') readStream
]

{ #category : #accessing }
PhLOpenVmManagerCommand >> iconNamed: aName [
	^ self icon
]

{ #category : #initialization }
PhLOpenVmManagerCommand >> initialize [
	super initialize.
	self
		name: 'Open VM Manager';
		description:
			'Open a new window allowing to manage Virtual Machines used to launch images'
]
