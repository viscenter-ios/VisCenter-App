//
//  VisCenterAppDelegate.h
//  VisCenter
//
//  Created by Zach Whelchel on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondViewController;

@interface VisCenterAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	NSURL *loadURL;

	NSString *site;
	double sliderValue;
	double sitetogoto;

	UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) NSString *site;

@property (nonatomic, retain) NSURL *loadURL;

@property (nonatomic) double sliderValue;
@property (nonatomic) double sitetogoto;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
