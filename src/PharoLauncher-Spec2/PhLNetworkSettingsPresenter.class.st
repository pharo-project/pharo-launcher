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
		'proxyPasswordInput',
		'useProxySwitch',
		'proxyPresenter',
		'manageHttpProxyExceptionsInput'
	],
	#category : 'PharoLauncher-Spec2-View-Settings',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Settings'
}

{ #category : 'initialization' }
PhLNetworkSettingsPresenter class >> open [

	<script>

	^ (self on: PharoLauncherSettings new) open
]

{ #category : 'layout' }
PhLNetworkSettingsPresenter >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom
		vAlignStart;
		add: (SpBoxLayout newLeftToRight
			add: 'Use HTTP Proxy' expand: false;
			add: useProxySwitch expand: false;
			yourself);
		add: proxyPresenter;
		yourself
]

{ #category : 'initialization' }
PhLNetworkSettingsPresenter >> initializePresenters [

	self addStyle: 'settings_form'.

	useProxySwitch := self newSwitchFor: #useHTTPProxy.
	useProxySwitch whenChangedDo: [ proxyPresenter enabled: useProxySwitch state ].
	proxyServerInput := self newTextInputFor: #httpProxyServer.
	proxyServerPortInput := self newNumberInputFor: #httpProxyPort.
	manageHttpProxyExceptionsInput := self newTextInputFor: #manageHttpProxyExceptions.
	proxyUsernameInput := self newTextInputFor: #proxyUser.
	proxyPasswordInput := self newTextInputFor: #proxyPassword.
	proxyPresenter := self newPresenter
		layout: self proxyLayout;
		yourself.
]

{ #category : 'layout' }
PhLNetworkSettingsPresenter >> proxyLayout [ 

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
			add: 'Exceptions';
			add: manageHttpProxyExceptionsInput;
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

{ #category : 'accessing' }
PhLNetworkSettingsPresenter >> proxyPassword: aString [

	proxyPasswordInput text: aString
]

{ #category : 'accessing' }
PhLNetworkSettingsPresenter >> proxyPort: anInteger [

	proxyServerPortInput text: anInteger
]

{ #category : 'accessing' }
PhLNetworkSettingsPresenter >> proxyServer: aString [

	proxyServerInput text: aString
]

{ #category : 'accessing' }
PhLNetworkSettingsPresenter >> proxyUser: aString [

	proxyUsernameInput text: aString
]
