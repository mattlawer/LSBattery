#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <TelephonyUI/TPLCDTextView.h>
#import <SpringBoard/SBUIController.h>

static NSString *settingsFile = @"/var/mobile/Library/Preferences/com.mathieubolard.lsbatterypreferences.plist";


%hook SBAwayDateView

-(void)updateClock{
	BOOL enabled = NO;
	int style = 1;
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		NSDictionary *settings = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		enabled = [[settings objectForKey:@"Enabled"] boolValue];
		style = [[settings objectForKey:@"Style"] intValue];
		[settings release];
	}
	%orig;
	if (enabled && (style == 0)) {
		TPLCDTextView *clock = MSHookIvar<TPLCDTextView *>(self, "_timeLabel");
		NSString *battery = [NSString stringWithFormat:@"%i%%",[[%c(SBUIController) sharedInstance] displayBatteryCapacityAsPercentage]];
		[clock setText:battery];
	}
}

%end


%hook SBAwayChargingView

+(BOOL)shouldShowDeviceBattery {
	BOOL enabled = YES;
	int style = 1;
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		NSDictionary *settings = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		enabled = [[settings objectForKey:@"Enabled"] boolValue];
		style = [[settings objectForKey:@"Style"] intValue];
		[settings release];
	}
	if (enabled && (style == 1)) {
		return YES;
	}
	return %orig;
}

%end


%hook SBAwayLockBar 

- (void)_setLabel:(id)label {
	BOOL enabled = NO;
	int style = 1;
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		NSDictionary *settings = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		enabled = [[settings objectForKey:@"Enabled"] boolValue];
		style = [[settings objectForKey:@"Style"] intValue];
		[settings release];
	}
	if (enabled && (style == 2)) {
		label = [NSString stringWithFormat:@"%i%%",[[%c(SBUIController) sharedInstance] displayBatteryCapacityAsPercentage]];
	}
	%orig;
}

%end


%ctor {
	%init
}

