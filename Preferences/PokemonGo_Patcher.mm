// #import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import <Preferences/PSControlTableCell.h>
#import <Preferences/PSListController.h>
#import <SpringBoard/SpringBoard.h>
#import "PokemonGo_Patcher.h"

@interface PokemonGo_PatcherController: PSListController 
{
	CGRect topFrame;
	UIImageView* logoImage;
	UILabel* bannerTitle;
	UILabel* footerLabel;
	UILabel* titleLabel;
}
@property(retain) UIImageView* bannerImage;
@property(retain) UIView* bannerView;
@property(retain) NSMutableArray *translationCredits;
@end

@implementation PokemonGo_PatcherController
// - (id)specifiers {
// 	if(_specifiers == nil) {
// 		_specifiers = [[self loadSpecifiersFromPlistName:@"HandyKey" target:self] retain];
// 	}
// 	return _specifiers;
// }

- (instancetype)init {
	self = [super init];
	return self;
}

- (NSArray *)specifiers {
	if (_specifiers == nil)
    {
        NSMutableArray *specifiers = [NSMutableArray array];

        PSSpecifier *gSetFakeLocation = [PSSpecifier groupSpecifierWithName:@"Fake Location"];
        [gSetFakeLocation setProperty:@"Default: x = 37.7883923, y = -122.4076413" forKey:@"footerText"];
        [gSetFakeLocation setProperty:@(YES) forKey:@"isStaticText"];
        [specifiers addObject:gSetFakeLocation];

        PSSpecifier *initx = [PSSpecifier preferenceSpecifierNamed:@"X" target:self set:@selector(setValue:forSpecifier:) get:@selector(getValueForSpecifier:) detail:Nil cell:[PSTableCell cellTypeFromString:@"PSEditTextCell"] edit:Nil];
        [initx setIdentifier:@"_init_x"];
        [specifiers addObject:initx];

        PSSpecifier *inity = [PSSpecifier preferenceSpecifierNamed:@"Y" target:self set:@selector(setValue:forSpecifier:) get:@selector(getValueForSpecifier:) detail:Nil cell:[PSTableCell cellTypeFromString:@"PSEditTextCell"] edit:Nil];
        [inity setIdentifier:@"_init_y"];
        [specifiers addObject:inity];

        PSSpecifier *gUseJapanese = [PSSpecifier groupSpecifierWithName:@""];
        [gUseJapanese setProperty:@"For some users, they are more faimilar with Japanese although they can't read any Japanese. lol" forKey:@"footerText"];
        [gUseJapanese setProperty:@(YES) forKey:@"isStaticText"];
        [specifiers addObject:gUseJapanese];

        PSSpecifier *useJapaneseSwitchCell = [PSSpecifier preferenceSpecifierNamed:@"Use Japanese" target:self set:@selector(setValue:forSpecifier:) get:@selector(getValueForSpecifier:) detail:Nil cell:[PSTableCell cellTypeFromString:@"PSSwitchCell"] edit:Nil];
        [useJapaneseSwitchCell setIdentifier:@"setJapanese"];
        [specifiers addObject:useJapaneseSwitchCell];

        if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/ua_tweak_resources/PokeGoPP/APResources.bundle/orig_1.png"]) {
            PSSpecifier *gShowOrigImageInPokePP = [PSSpecifier groupSpecifierWithName:@""];
            [gShowOrigImageInPokePP setProperty:@"Don't show tinted shadow pokemon images in Poke Go ++. (This hack doesn't work in map view.)" forKey:@"footerText"];
            [gShowOrigImageInPokePP setProperty:@(YES) forKey:@"isStaticText"];
            [specifiers addObject:gShowOrigImageInPokePP];

            PSSpecifier *showOrigInPokePPSwitchCell = [PSSpecifier preferenceSpecifierNamed:@"No Tinted Images " target:self set:@selector(setValue:forSpecifier:) get:@selector(getValueForSpecifier:) detail:Nil cell:[PSTableCell cellTypeFromString:@"PSSwitchCell"] edit:Nil];
            [showOrigInPokePPSwitchCell setIdentifier:@"showOrigImageInPokePP"];
            [specifiers addObject:showOrigInPokePPSwitchCell];
        }

        [_specifiers release];
        _specifiers = nil;
        _specifiers = [[NSArray alloc]initWithArray:specifiers];
    }
    return _specifiers;
}


- (id)getValueForSpecifier:(PSSpecifier *)specifier {
    return getUserDefaultForKey(specifier.identifier);
}

- (void)setValue:(id)value forSpecifier:(PSSpecifier *)specifier {
    system("killall pokemongo");
    setUserDefaultForKey(specifier.identifier, value);
}
@end

// vim:ft=objc
