"
Application that allows users to choose a template from a set of templates (potentially on the web). From a template, the user can create a Pharo image and launch it. This application also list the existing images.

PharoLauncherApplication open
"
Class {
	#name : #PharoLauncherApplication,
	#superclass : #SpApplication,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'imageRepository',
		'templateRepository',
		'imagesPresenter'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #'instance creation' }
PharoLauncherApplication class >> open [
	<script>
	^ self new run
]

{ #category : #accessing }
PharoLauncherApplication >> imageRepository [
	^ imageRepository
]

{ #category : #accessing }
PharoLauncherApplication >> imageRepository: aPhlImageRepository [
	imageRepository := aPhlImageRepository
]

{ #category : #announcements }
PharoLauncherApplication >> imageRepositoryChanged [
	imagesPresenter ifNotNil: #refresh
]

{ #category : #initialization }
PharoLauncherApplication >> initialize [ 
	imageRepository :=  PhLDirectoryBasedImageRepository default.
	templateRepository :=  PhLTemplateGroupRepository newFromGroups: PhLTemplateGroupsBuilder build.
]

{ #category : #running }
PharoLauncherApplication >> run [ 
	imagesPresenter := PhLImagesPresenter newApplication: self model: imageRepository.
	self open: imagesPresenter.
]

{ #category : #accessing }
PharoLauncherApplication >> templateRepository [
	^ templateRepository
]
