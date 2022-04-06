"
I provide NetworkSystemSettings proxy setting
for the PhLSettingsBrowser (pragma pharoLauncherSettings).

"
Class {
	#name : #PhLNetworkSettings,
	#superclass : #Object,
	#category : #'PharoLauncher-Core-Settings'
}

{ #category : #settings }
PhLNetworkSettings class >> networkSettingsOn: aBuilder [

	<pharoLauncherSettings>
	(aBuilder setting: #useHTTPProxy)
		label: 'Use HTTP proxy';
		parent: #pharoLauncher;
		target: NetworkSystemSettings;
		order: 10;
		description:
			'If checked then the you will be able to set a port number and a server name. If unchecked, then no http proxy is used.';
		with: [ 
			(aBuilder setting: #httpProxyPort)
				label: 'Port' translated;
				target: NetworkSystemSettings;
				description: 'The HTTP proxy port'.
			(aBuilder setting: #httpProxyServer)
				label: 'Server' translated;
				target: NetworkSystemSettings;
				description: 'The HTTP proxy server (i.e. proxy.univ-brest.fr)'.
			(aBuilder setting: #manageHttpProxyExceptions)
				label: 'Exceptions' translated;
				target: NetworkSystemSettings;
				description: 'Domains to avoid to proxy (separated by ;)' ]
]
