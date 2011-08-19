SDKVERSION = 5.0
include theos/makefiles/common.mk

TWEAK_NAME = LSBattery
LSBattery_FILES = Tweak.xm
LSBattery_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
