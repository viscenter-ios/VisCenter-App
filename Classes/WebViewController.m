//
//  WebViewController.m
//  Web
//
//  Created by Andrew Schenk on 2/20/09.
//  Copyright Schenk Studios 2009. All rights reserved.
//

#import "WebViewController.h"
#import "VisCenterAppDelegate.h"

@implementation WebViewController
@synthesize web;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	alerton = NO;
	// make the activity indicator as the right side button
	CGRect frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
	activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
	[activityIndicator startAnimating];
	[activityIndicator sizeToFit];
	activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
										  UIViewAutoresizingFlexibleRightMargin |
										  UIViewAutoresizingFlexibleTopMargin |
										  UIViewAutoresizingFlexibleBottomMargin);
	UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	loadingView.target = self;
	self.navigationItem.rightBarButtonItem = loadingView;
	
	NSURL *url = [[NSURL alloc] initWithString:mainDelegate.site];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
	
	[web loadRequest:request];
	
	[url release]; //We release these since we made them with an "alloc"  This gives them a retain count of 1
	[request release]; //We release these since we made them with an "alloc"  This gives them a retain count of 1
	
	loader = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(tick) userInfo:nil repeats:YES];
	
    [super viewDidLoad];
}


- (void)tick{
	if(!web.loading) {//If the UIWebView is finished loading stop the animation for the activity indicator
		[activityIndicator stopAnimating];
		[activityIndicator removeFromSuperview];
		
	}
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	mainDelegate.loadURL = [ [ request URL ] retain ]; // retain the loadURL for use	
	if ( ( [ [ mainDelegate.loadURL scheme ] isEqualToString: @"http" ] || [ [ mainDelegate.loadURL scheme ] isEqualToString: @"https" ] ) && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
		(web.stopLoading);	
		alerton = YES;

		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Open Link In Safari" message:@"You are leaving to open the link."
													   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"OK", nil];
		[alert show];	
		[alert release];
	}
	//return ![ [ UIApplication sharedApplication ] openURL: [ loadURL autorelease ] ];
    
	//	[ loadURL release ];
	//	return YES; // URL is not http/https and should open in UIWebView
	
}

- (void) webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
	if (alerton == NO){
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Loading Content" message:@"You are not connected to the Internet."
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
	[alert show];	
	[alert release];
	}
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 0) {	
		alerton = NO;
	}
	if(buttonIndex == 1) {	
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];

	[[UIApplication sharedApplication] openURL:mainDelegate.loadURL];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[web release];
	[web dealloc];
    [super dealloc];
}

@end
