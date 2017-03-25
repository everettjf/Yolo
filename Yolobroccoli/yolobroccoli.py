"""yolobroccoli

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
"""
from docopt import docopt
import os


def run(cmd):
    print('------------------------------------')
    print(cmd)
    os.system(cmd)


class Broccoli:
    def __init__(self):
        self.app_path = ''
        self.dylib_path = ''
        self.mobile_provision_path = ''
        self.cert_name = ''
        self.team_bundle_id = ''
        self.ipa_path = ''

    def __check(self):
        if not os.path.isdir(self.app_path):
            print('App path does not exist or is not a directory : %s' % self.app_path )
            return False
        if not os.path.isfile(self.dylib_path):
            print('Dylib path does not exist or is not a file : %s' % self.dylib_path)
            return False
        if not os.path.isfile(self.mobile_provision_path):
            print('Mobile provision path does not exist or is not a file : %s' % self.dylib_path)
            return False

        if self.cert_name.strip() == '':
            print('Certificate name should not be empty')
            return False

        if os.path.exists(self.ipa_path):
            print('Output path already exist : %s' % self.ipa_path)
            return False

        return True

    def __remove_something(self):
        # remove Watch directory
        run('rm -rf %s' % os.path.join(self.app_path, 'Watch'))
        # remove PlugIns directory
        run('rm -rf %s' % os.path.join(self.app_path, 'PlugIns'))

    def __modify_bundle_identifier(self):
        bundle_id = '.'.join(self.team_bundle_id.split('.')[1:])
        info_plist_path = os.path.join(self.app_path, 'Info.plist')

        run('/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier %s" %s' % (bundle_id, info_plist_path))

    def __copy_mobileprovision(self):
        """
        Copy embedded.mobileprovision file into app path
        """
        target = os.path.join(self.app_path, 'embedded.mobileprovision')
        run('cp %s %s' % (self.mobile_provision_path, target))

    def __inject_dylib(self):
        dylib_name = self.dylib_path.split('/')[-1]
        binary_name = self.app_path.split('/')[-1].split('.')[0]
        run('optool uninstall -p "@executable_path/%s" -t %s/%s' % (dylib_name, self.app_path, binary_name))
        run('optool install -c load -p "@executable_path/%s" -t %s/%s' % (dylib_name, self.app_path, binary_name))

    def __create_entitlements_plist(self):
        xml = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>application-identifier</key>
    <string>XXXX.XXXX.XXXX.XXXX</string>
    <key>get-task-allow</key>
    <true/>
</dict>
</plist>
        """
        xml = xml.replace('XXXX.XXXX.XXXX.XXXX', self.team_bundle_id)
        plistdir = os.sep.join(self.ipa_path.split('/')[0:-1])
        plistpath = os.path.join(plistdir, 'Entitlements.plist')
        with open(plistpath, 'w+') as f:
            f.write(xml)
            f.flush()

    def __sign_dylib(self):
        dylib_name = self.dylib_path.split('/')[-1]
        run('cp %s %s/%s' % (self.dylib_path, self.app_path, dylib_name))
        run('codesign -f -s "%s" %s/%s' % (self.cert_name, self.app_path, dylib_name))

    def __sign_app(self):
        plistdir = os.sep.join(self.ipa_path.split('/')[0:-1])
        plistpath = os.path.join(plistdir, 'Entitlements.plist')

        run('codesign -f -s "%s" --entitlements %s %s' % (self.cert_name, plistpath, self.app_path))

    def __create_ipa(self):
        run('xcrun -sdk iphoneos PackageApplication -v %s -o %s' % (self.app_path, self.ipa_path))

    def build(self):
        # Check
        if not self.__check():
            return False

        self.__remove_something()
        self.__modify_bundle_identifier()
        self.__copy_mobileprovision()
        self.__inject_dylib()
        self.__create_entitlements_plist()
        self.__sign_dylib()
        self.__sign_app()
        self.__create_ipa()

        return True


if __name__ == '__main__':
    arguments = docopt(__doc__, version="yolobroccoli 0.1")
    print(arguments)

    bro = Broccoli()

    bro.app_path = arguments['<apppath>']
    bro.dylib_path = arguments['<dylibpath>']
    bro.mobile_provision_path = arguments['<mobileprovisionpath>']
    bro.cert_name = arguments['<certname>']
    bro.team_bundle_id = arguments['<teambundleid>']
    bro.ipa_path = arguments['<ipapath>']

    # ipa path must be absolute path
    if not bro.ipa_path.startswith('~') and not bro.ipa_path.startswith('/'):
        bro.ipa_path = os.path.join(os.getcwd(), bro.ipa_path)

    bro.build()

