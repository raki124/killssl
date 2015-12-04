GO_EASY_ON_ME = 1
ARCHS = arm64 armv7

include theos/makefiles/common.mk

TWEAK_NAME = killssl
killssl_FILES = Tweak.xm
killssl_CFLAGS=-DSUBSTRATE_BUILD

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 itunesstored"
