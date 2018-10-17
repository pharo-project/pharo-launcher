private
fetchVm
	[ self class fetch: self vmUrl to: self vmFileName ]
		on: KeyNotFound
		do: [ self error: 'No Virtual Machine available for ' , self imageVersion , ' image.' ]