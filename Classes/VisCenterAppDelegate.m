//
//  VisCenterAppDelegate.m
//  VisCenter
//
//  Created by Zach Whelchel on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "VisCenterAppDelegate.h"

@implementation VisCenterAppDelegate
@synthesize site;
@synthesize loadURL;

@synthesize sliderValue, sitetogoto;

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
  
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
	[tabBarController.view setBackgroundColor:[UIColor blackColor]];

	//tabBarController.tabBarItem.image = [UIImage imageNamed:@"vislogo@2x.png"];

}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

