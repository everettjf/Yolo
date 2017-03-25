THEOS_DEVICE_IP = 192.168.199.164
TARGET = iphone:latest:8.0
ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = wechatvideodownloader
wechatvideodownloader_FILES = Tweak.xm
wechatvideodownloader_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
