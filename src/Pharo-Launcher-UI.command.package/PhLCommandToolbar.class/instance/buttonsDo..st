private
buttonsDo: aBlock
	"Iterate over all my buttons. aBlock is a one or two argument block. The first argument is the button itself, instance of PhLCommandButton. The second argument (optional) is the related command class."
	commandClasses do: [ :commandClass | aBlock cull: (self widgets at: commandClass specId) cull: commandClass ]