private
dynamicLayout
	"Create a spec layout with 1 row, and as many columns as there are command classes"

	^ SpecLayout composed
		newRow: [ :r | 
			r newColumn: [ :col |  ].
			self commandClasses do: [ :commandClass | r add: commandClass specId width: self class toolbarHeight ] ]