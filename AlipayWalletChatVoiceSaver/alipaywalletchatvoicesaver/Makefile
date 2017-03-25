THEOS_DEVICE_IP = 192.168.199.164
ARCHS = armv7 arm64
TARGET = iphone:latest:8.0

include theos/makefiles/common.mk

TWEAK_NAME = alipaywalletchatvoicesaver
alipaywalletchatvoicesaver_FILES = Tweak.xm
alipaywalletchatvoicesaver_FRAMEWORKS = UIKit


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 AlipayWallet"
