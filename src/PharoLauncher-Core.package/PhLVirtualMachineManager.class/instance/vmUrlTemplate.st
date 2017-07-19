private
vmUrlTemplate
	"$1: IMAGE_VERSION
	 $2: VM_ARCH
	 $3: OS
	 $4: VM_STATUS"
	^ 'http://files.pharo.org/get-files/{1}/pharo{2}-{3}-{4}.zip'