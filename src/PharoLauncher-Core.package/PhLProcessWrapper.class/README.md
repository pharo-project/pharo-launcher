This class  allow to run external (OS) processes for the Pharo Launcher.
It hides some complexity to the Launcer.
OSProcess is used on Linux and OS X, while ProcessWrapper is used on Windows (OSProcess hangs on some processes on Windows and the Launcher becomes unusable).