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
	#category : 'PharoLauncher-Spec2-View-Settings',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Settings'
}

{ #category : 'initialization' }
PhLNetworkSettingsPresenter class >> open [

	<script>

	^ self new open
]

{ #category : 'layout' }
PhLNetworkSettingsPresenter >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom
		vAlignStart;
		add: (SpBoxLayout newTopToBottom
			vAlignStart;
			add: 'HTTP Proxy server';
			add: proxyServerInput;
			yourself);
		add: (SpBoxLayout newTopToBottom
			vAlignStart;
			add: 'HTTP Proxy port';
			add: proxyServerPortInput;
			yourself);
		add: (SpBoxLayout newTopToBottom
			vAlignStart;
			add: 'HTTP Proxy username';
			add: proxyUsernameInput;
			yourself);
		add: (SpBoxLayout newTopToBottom
			vAlignStart;
			add: 'HTTP Proxy password';
			add: proxyPasswordInput;
			yourself);
		yourself
]

{ #category : 'initialization' }
PhLNetworkSettingsPresenter >> initializePresenters [

	self addStyle: 'settings_form'.

	proxyServerInput := self newTextInputFor: #httpProxyServer.
	proxyServerPortInput := self newTextInputFor: #httpProxyPort.
	proxyUsernameInput := self newTextInputFor: #proxyUser.
	proxyPasswordInput := self newTextInputFor: #proxyPassword.
]
