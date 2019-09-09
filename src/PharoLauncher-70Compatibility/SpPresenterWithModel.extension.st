Extension { #name : #SpPresenterWithModel }

{ #category : #'*PharoLauncher-70Compatibility' }
SpPresenterWithModel >> defineInputPorts [
	
	^ { SpModelPort new }
]

{ #category : #'*PharoLauncher-70Compatibility' }
SpPresenterWithModel >> setModel: aDomainObject [

	^ self model: aDomainObject
]
