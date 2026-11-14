"
Presenter of the details of a virtual machine: download URL and location on disk, as links.
My model is nil when there is no virtual machine to show.

I'm part of the VM manager window, see `PhLVMPresenter`.
"
Class {
	#name : 'PhLVMDetailPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'downloadUrl',
		'location'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'layout' }
PhLVMDetailPresenter >> defaultLayout [

	^ SpGridLayout build: [ :builder |
		  builder
			  beRowNotHomogeneous;
			  beColumnNotHomogeneous;
			  borderWidth: 5;
			  column: 1 withConstraints: [ :c | c hAlignEnd ];
			  column: 2 withConstraints: [ :c | c beExpand ];
			  add: 'Download URL';
			  add: downloadUrl;
			  nextRow;
			  add: 'Location';
			  add: location ]
]

{ #category : 'accessing' }
PhLVMDetailPresenter >> downloadUrl [

	^ downloadUrl
]

{ #category : 'initialization' }
PhLVMDetailPresenter >> initializePresenters [

	downloadUrl := self newLink.
	location := self newLink
]

{ #category : 'accessing' }
PhLVMDetailPresenter >> location [

	^ location
]

{ #category : 'updating' }
PhLVMDetailPresenter >> modelChanged [

	self vm
		ifNil: [ self showNoVm ]
		ifNotNil: [ :vm | self showVm: vm ]
]

{ #category : 'private - updating' }
PhLVMDetailPresenter >> showNoVm [

	downloadUrl
		label: '';
		action: [  ].
	location
		label: '';
		action: [  ]
]

{ #category : 'private - updating' }
PhLVMDetailPresenter >> showVm: aVm [

	downloadUrl
		label: aVm downloadUrl;
		url: aVm downloadUrl;
		help: 'Download the archive of this virtual machine'.
	location
		label: aVm location;
		action: [ aVm showInFolder ];
		help: 'Show this virtual machine in its folder'
]

{ #category : 'accessing' }
PhLVMDetailPresenter >> vm [

	^ self model
]
