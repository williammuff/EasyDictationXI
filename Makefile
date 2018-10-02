GO_EASY_ON_ME=1
ARCHS = arm64
PACKAGE_VERSION = 1.0.0
FINALPACKAGE=1
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = EasyDictationXI
EasyDictationXI_FILES = Tweak.xm
EasyDictationXI_PrivateFrameworks = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
