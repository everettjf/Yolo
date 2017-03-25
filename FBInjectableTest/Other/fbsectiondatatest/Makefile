THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222
ARCHS = armv7 
TARGET = iphone:latest:8.0

include theos/makefiles/common.mk

TWEAK_NAME = fbsectiondatatest
fbsectiondatatest_FILES = Tweak.xm
fbsectiondatatest_FRAMEWORKS = UIKit


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Facebook"
