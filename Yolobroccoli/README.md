# yolobroccoli
scripts you should not know


# Prerequisite

- optool
- Python docopt

- Tested on Python 2.7.10

# Usage

```
yolobroccoli

Usage:
    yolobroccoli.py -a <apppath> -d <dylibpath> -p <mobileprovisionpath> -c <certname> -b <teambundleid> -o <ipapath>
    yolobroccoli.py (-h | --help)
    yolobroccoli.py --version

Options:
    -h --help       Show this screen
    --version       Show version
    -a              App Path (e.g. ~/test/Facebook.app )
    -d              Dylib Path (e.g. ~/test/hook.dylib )
    -p              Mobile Provision Path (e.g. embedded.mobileprovision )
    -c              Certificate Name (e.g. "iPhone Developer: xxx@gmail.com (XXXXXXXXX)" )
    -b              TeamID and Application Bundle ID (e.g. XXXTEAMID.com.company.bundleid )
    -o              Output XXX.ipa file path

```


# Example

```
AppPath=testapp/MyApp.app
DylibPath=testapp/myhook.dylib
MobileProvisionPath=testapp/embedded.mobileprovision
CertificateName="iPhone Developer: XXXXX (XXXXXXXX)"
BundleID=XXXXXX.com.xxxx.xxxxx
IpaPath=testapp/MyApp.ipa

python yolobroccoli.py -a "$AppPath" -d "$DylibPath" -p "$MobileProvisionPath" -c "$CertificateName" -b "$BundleID" -o "$IpaPath"

```