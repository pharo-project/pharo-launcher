# Pharo Launcher executable signing
It is now important to sign Pharo Launcher executables as many Operation Systems now have a mechanism detecting non-signed executables as risky software and try to convice users to do not install it.
It is especially true on Mac OS X  and Windows.

To sign Pharo Launcher, we use certificates provided by Inria Foundation.

# How to store certificates safely on git?
To automatize the signing of certificates, we need to get them along with sources files needed to build the executable, i.e. in the git repository.
The certificate should not be usable by anyone outside the Pharo organization, so we will encrypt certificates to store them on git.
```
openssl aes-256-cbc -k password -in ${path_cer} -out ${path_cer}.enc -e
```
To use these encrypted certificates in automated builds, we need to decrypt them :
* OS X
```bash
  local deploy_dir="./deploy"
  wget --quiet --directory-prefix="${deploy_dir}" https://github.com/OpenSmalltalk/opensmalltalk-vm/raw/Cog/deploy/pharo/pharo.cer.enc
  wget --quiet --directory-prefix="${deploy_dir}" https://github.com/OpenSmalltalk/opensmalltalk-vm/raw/Cog/deploy/pharo/pharo.p12.enc
  local path_cer="${deploy_dir}/pharo.cer"
  local path_p12="${deploy_dir}/pharo.p12"
  openssl aes-256-cbc -k "${pharo_sign_password}" -in "${path_cer}.enc" -out "${path_cer}" -d
  openssl aes-256-cbc -k "${pharo_sign_password}" -in "${path_p12}.enc" -out "${path_p12}" -d
```
For security concerns, we create a temporary keychain, where we will import the certificate before signing:
```bash
security delete-keychain "${key_chain}" || true
security create-keychain -p ci "${key_chain}"
security default-keychain -s "${key_chain}"
security unlock-keychain -p ci "${key_chain}"
security set-keychain-settings -t 3600 -u "${key_chain}"
security import "${path_cer}" -k ~/Library/Keychains/"${key_chain}" -T /usr/bin/codesign
security import "${path_p12}" -k ~/Library/Keychains/"${key_chain}" -P "${cert_pass}" -T /usr/bin/codesign

# insert code to sign here

# Remove sensitive files again
rm -rf "${path_cer}" "${path_p12}"
security delete-keychain "${key_chain}
```

* Windows

```
wget --quiet --directory-prefix="${deploy_dir}" https://github.com/pharo-project/pharo-launcher/raw/signing/pharo-windows-certificate.p12.enc
openssl aes-256-cbc -k "${pharo_sign_password}" -in pharo-windows-certificate.p12.enc -out pharo-windows-certificate.p12 -d
```
The password needed to decrypt them will be stored in an environment variable (secured) on the CI tool (travis or Jenkins).

# How to sign on OS X?
Some links:
- [macOS Code Signing In Depth](https://developer.apple.com/library/archive/technotes/tn2206/_index.html)
- [Distribute outside the Mac App Store (macOS)](https://help.apple.com/xcode/mac/current/#/dev033e997ca)
- [Troubleshooting Failed Signature Verification](https://developer.apple.com/library/archive/technotes/tn2318/_index.html#//apple_ref/doc/uid/DTS40013777-CH1-TNTAG2)
- [security / codesign in Sierra: Keychain ignores access control settings and UI-prompts for permission](https://stackoverflow.com/questions/39868578/security-codesign-in-sierra-keychain-ignores-access-control-settings-and-ui-p/41220140#41220140)


You need to use codesign (shipped with Xcode):
```
codesign -s "${sign_identity}" --keychain "${key_chain}" --force --deep "${app_dir}/Contents/MacOS/Plugins/"*
codesign -s "${sign_identity}"  --keychain "${key_chain}" --force --deep "${app_dir}"
```
# How to sign on Windows?
You first need to install Microsoft Windows SDK
```
wget https://download.microsoft.com/download/A/6/A/A6AC035D-DA3F-4F0C-ADA4-37C8E5D34E3D/winsdk_web.exe
```
Run **winsdk_web.exe** and only select **.Net development tools**
Then, use signtool:
```
signtool.exe sign /f signing_certificate.p12 /p password app.exe
```
We need to sgin both the executable and the generated installer.

# Debugging
## OS X
On OS X, the keychain *macos-build* we create by command line does not appear in KeychainAccess.app. To see it in the KeychainAccess, we need to add it:
```bash
security list-keychains -d user -s macos-build.keychain

```
Then you can check it succeeded with
 ```bash
 security list-keychains                                
    "/Users/ci/Library/Keychains/macos-build.keychain-db"
    "/Library/Keychains/System.keychain"
```
