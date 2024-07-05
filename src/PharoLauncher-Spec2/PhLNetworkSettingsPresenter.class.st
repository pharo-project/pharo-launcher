"
I allow to edit network settings in the context of Pharo Launcher
"
Class {
	#name : 'PhLNetworkSettingsPresenter',
	#superclass : 'PhLAbstractSettingsPresenter',
	#instVars : [
		'proxyServerInput',
		'proxyServerPortInput',
		'proxyUsernameInput',
		'proxyPasswordInput'
	],
	#category : 'PharoLauncher-Spec2',
	#package : 'PharoLauncher-Spec2'
}

{ #category : 'initialization' }
PhLNetworkSettingsPresenter class >> open [

	<script>

	^ self new open
]

{ #category : 'layout' }
PhLNetworkSettingsPresenter >> defaultLayout [ 

	^ self newBoxLayoutTopToBottom
		spacing: 15;
		add: (SpBoxLayout newLeftToRight 
			add: 'HTTP Proxy server';
			add: proxyServerInput ;
			yourself) expand: false;
		add: (SpBoxLayout newLeftToRight 
			add: 'HTTP Proxy port';
			add: proxyServerPortInput ;
			yourself) expand: false;
		add: (SpBoxLayout newLeftToRight 
			add: 'HTTP Proxy username';
			add: proxyUsernameInput ;
			yourself) expand: false;
		add: (SpBoxLayout newLeftToRight 
			add: 'HTTP Proxy password';
			add: proxyPasswordInput ;
			yourself) expand: false;
		yourself
]

{ #category : 'initialization' }
PhLNetworkSettingsPresenter >> initializePresenters [

	proxyServerInput := self newTextInput.
	proxyServerPortInput := self newTextInput.
	proxyUsernameInput := self newTextInput.
	proxyPasswordInput := self newTextInput.
	
]
