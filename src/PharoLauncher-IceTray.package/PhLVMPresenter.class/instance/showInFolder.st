actions
showInFolder
	| vms |
	vms := self selectedItems.
	vms size >= 1
		ifTrue: [ vms first showInFolder]