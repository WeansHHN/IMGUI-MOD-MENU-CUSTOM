#export THEOS=/var/mobile/theos
ARCHS = arm64
#Add arm64e if it needed
THEOS_DEVICE_IP = 192.168.1.13
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1
#THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = hhnios
#If you want to change TWEAK_NAME just change up here. It will automatically change these below, don't need to change it by hand anymore!

$(TWEAK_NAME)_FRAMEWORKS =  UIKit Foundation Security QuartzCore CoreGraphics CoreText  AVFoundation Accelerate GLKit SystemConfiguration GameController

$(TWEAK_NAME)_CCFLAGS = -std=c++14 -fno-rtti -fno-exceptions -DNDEBUG
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value

#Using both DobbyHook
$(TWEAK_NAME)_OBJ_FILES = Hook/libdobby.a

$(TWEAK_NAME)_FILES = ImGuiDrawView.mm $(wildcard Esp/*.mm) $(wildcard Esp/*.m) $(wildcard IMGUI/*.cpp) $(wildcard IMGUI/*.mm) $(wildcard Hook/*.m)


#$(TWEAK_NAME)_LIBRARIES += substrate
# GO_EASY_ON_ME = 1

include $(THEOS_MAKE_PATH)/tweak.mk


