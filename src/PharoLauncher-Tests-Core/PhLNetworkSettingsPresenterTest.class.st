Class {
	#name : 'PhLNetworkSettingsPresenterTest',
	#superclass : 'PharoLauncherSettingsTest',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'running' }
PhLNetworkSettingsPresenterTest >> setUp [
	super setUp.
	presenter := PhLNetworkSettingsPresenter on: settings
]

{ #category : 'tests' }
PhLNetworkSettingsPresenterTest >> testCanSetProxyPassword [

	presenter proxyPassword: 'pass'.

	self
		assert: NetworkSystemSettings proxyPassword
		equals: 'pass'
]

{ #category : 'tests' }
PhLNetworkSettingsPresenterTest >> testCanSetProxyPort [

	presenter proxyPort: '9000'.

	self
		assert: NetworkSystemSettings httpProxyPort
		equals: 9000
]

{ #category : 'tests' }
PhLNetworkSettingsPresenterTest >> testCanSetProxyServer [

	presenter proxyServer: 'foo'.

	self assert: NetworkSystemSettings httpProxyServer equals: 'foo'
]

{ #category : 'tests' }
PhLNetworkSettingsPresenterTest >> testCanSetProxyUser [

	presenter proxyUser: 'me'.

	self
		assert: NetworkSystemSettings proxyUser
		equals: 'me'
]
