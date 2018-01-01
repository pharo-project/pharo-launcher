accessing
roots
	^ (super images , self imageTreeNodes) sorted: [ :i1 :i2 | i1 name < i2 name ]