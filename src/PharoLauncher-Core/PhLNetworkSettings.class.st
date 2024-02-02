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
	(aBuilder group: #network)
		label: 'Network' ;  
		description: 'All settings concerned with the network'.

	 (aBuilder setting: #useHTTPProxy)
		label: 'Use HTTP proxy';
		parent: #network;
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
				description: 'Domains to avoid to proxy (separated by ;)' ].
			
	(aBuilder setting: #useNetworkAuthentification) 
		label: 'Proxy authentication' ;
		parent: #network;
		order: 20;
		target: NetworkSystemSettings;
		description: 'If checked then you will be able to enter a user name and a password for network authentification. Store  HTTP 1.0 basic authentication credentials. Note: this is an ugly hack that stores your password in your image.  It''s just enought to get you going if you use a firewall that requires authentication';
		with: [
			(aBuilder setting: #proxyUser)
				label: 'User name' ;
				description: 'The proxy user name'.
			(aBuilder setting: #proxyPassword)
				type: #Password;
				label: 'Password' ;
				description: 'The user password'].

]
