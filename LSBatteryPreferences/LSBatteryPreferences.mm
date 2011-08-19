#import <Preferences/Preferences.h>

@interface LSBatteryPreferencesListController: PSListController { }
@end

@implementation LSBatteryPreferencesListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"LSBatteryPreferences" target:self] retain];
	}
	return _specifiers;
}
@end