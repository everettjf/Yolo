THEOS_DEVICE_IP = 192.168.199.235
ARCHS = armv7 armv7s arm64
TARGET = iphone:latest:9.0

include theos/makefiles/common.mk

TWEAK_NAME = characountfornotes9
characountfornotes9_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileNotes"
