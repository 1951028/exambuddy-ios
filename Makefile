# sdk 写 latest：跟随 runner 上 Xcode 自带的 iOS SDK，别写死版本号
TARGET := iphone:clang:latest:14.0
ARCHS = arm64
INSTALL_TARGET_PROCESSES = ExamBuddy

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = ExamBuddy
ExamBuddy_FILES = Sources/main.m Sources/AppDelegate.m Sources/RootViewController.m Sources/LocalSchemeHandler.m
ExamBuddy_CFLAGS = -fobjc-arc -Wno-unused-parameter
ExamBuddy_FRAMEWORKS = UIKit WebKit

include $(THEOS_MAKE_PATH)/application.mk
