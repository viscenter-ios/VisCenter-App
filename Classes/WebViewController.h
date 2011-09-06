//
//  WebViewController.h
//  Web
//
//  Created by Andrew Schenk on 2/20/09.
//  Copyright Schenk Studios 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController {

	IBOutlet UIWebView* web;
	UIActivityIndicatorView * activityIndicator;

	BOOL alerton;
	NSTimer* loader;	
}

@property(nonatomic, retain) IBOutlet UIWebView *web;

@end

