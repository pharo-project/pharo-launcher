Class {
	#name : #PhLProcessCliCommandTest,
	#superclass : #PhLCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLProcessCliCommandTest >> testExecuteOSShellCommand [

	"nothing is executed"
	self assert: PhLProcessCliCommand new executeOSShellCommand isEmptyOrNil.
	
]

{ #category : #tests }
PhLProcessCliCommandTest >> testExecuteOSShellCommandWithArgs [

	| aCmd |
	aCmd := PhLProcessCliCommand new.
	
	self deny:
		(aCmd executeOSShellCommandWithArgs: #( 'ls' )) isEmptyOrNil.
	self
		should: [ aCmd executeOSShellCommandWithArgs: #( 'non-existing-command' ) ]
		raise: PhLProcessCommandError
		description: 'Invoking invalid OS shell command should end up with domain error exception: PHLProcessCommandError'
]
