Extension { #name : #SpWorldPresenter }

{ #category : #'*PharoLauncher-Spec2' }
SpWorldPresenter >> close [
	self application windowClosed: self.
	"We could remove all morphs from the world but it is already done by PhLDeploymentScript
	self adapter ifNotNil: [ :adapter | adapter removeSubWidgets ]"
]

{ #category : #'*PharoLauncher-Spec2' }
SpWorldPresenter >> title: aString [
	titleHolder := aString.
	self adapter ifNotNil: [ :worldAdapter | worldAdapter title: self title ]
]
