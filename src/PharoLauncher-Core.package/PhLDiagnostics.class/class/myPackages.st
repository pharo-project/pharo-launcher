public
myPackages
	"self myPackages"
	^ RPackage organizer packages select: [  :package | package name includesSubstring: 'PharoLauncher' ]