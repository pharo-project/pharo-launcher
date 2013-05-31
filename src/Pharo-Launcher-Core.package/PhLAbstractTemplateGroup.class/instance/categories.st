accessing
categories
	"Return a collection of all the categories in which at least one of my templates is included"
	^ (self templates gather: #categories) asSet