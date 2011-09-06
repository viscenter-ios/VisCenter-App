//
//  FourthViewController.h
//  VisCenter
//
//  Created by Vis Center on 7/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FourthViewController : UIViewController {
	UIAlertView *alert;
	IBOutlet UIWebView* web;
	
	IBOutlet UIWebView* web2;

	UIWebView *webView;
	
	UIWebView *webView2;

	
	
	IBOutlet id youtube;
	
	IBOutlet id youtube2;

	NSTimer* loader;	
	
	NSTimer* loader2;	

	NSTimer* timer;

	IBOutlet UIScrollView *scrollHome;	
	IBOutlet UIView *theView;
}

-(IBAction)youtube;
-(IBAction)channel;

@property(nonatomic, retain) IBOutlet UIWebView *web;
@property(nonatomic, retain) IBOutlet UIWebView *web2;

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIWebView *webView2;

@end
