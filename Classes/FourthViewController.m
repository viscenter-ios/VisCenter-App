//
//  FourthViewController.m
//  VisCenter
//
//  Created by Vis Center on 7/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FourthViewController.h"
#import "YouTubeViewController.h"

@implementation FourthViewController

- (void)viewDidLoad {	
	
	
	[scrollHome addSubview:theView];
	
	scrollHome.contentSize = CGSizeMake(320, 552);
	
	[self embedYouTube2:@"http://www.youtube.com/watch?v=YelVedGIz4I" frame:webView2.frame];

	
	
	[self embedYouTube:@"http://www.youtube.com/watch?v=Mu_6onOVxZ8" frame:webView.frame];

	self.title = @"Videos";

	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.22745098 green:0.34117647 blue:0.65490196 alpha:1.0];
}


-(IBAction)channel{
	alert = [[UIAlertView alloc] initWithTitle:@"Opening iTunes Store" message:@"Loading..." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Stop", nil];
	[alert show];	
	[alert release];
	
	NSURL *url = [[NSURL alloc] initWithString:@"http://deimos3.apple.com/WebObjects/Core.woa/Browse/researchchannel.org.1420202552"];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];

	[web loadRequest:request];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(check) userInfo:nil repeats:NO];
}

-(void)check{
	NSString * test = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
	if (test == nil) {
		//display an alertview saying you don't have an internet connection
		[alert dismissWithClickedButtonIndex:0 animated:TRUE];
		UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Error Loading Content" message:@"You are not connected to the Internet."
														delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
		[alert2 show];	
	[alert2 release];	
	}


}


- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 0) {	
		(web.stopLoading);	
	}
}


-(IBAction)youtube{
YouTubeViewController *youController = [[YouTubeViewController alloc] initWithNibName:@"YouTubeViewController" bundle:nil];
[self.navigationController pushViewController:youController animated:YES];
}

- (void)embedYouTube:(NSString*)url frame:(CGRect)frame {  
	
    NSString* embedHTML = @"<html><head><style type=\"text/css\">body {background-color: transparent; color: white;    }    </style>    </head><body style=\"margin:0\">    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"%0.0f\" height=\"%0.0f\"></embed></body></html>";  
    NSString* html = [NSString stringWithFormat:embedHTML, url, frame.size.width, frame.size.height];  	
	
	[webView loadHTMLString:html baseURL:nil];  
	[webView setNeedsDisplay];
	//[[(UIScrollView*)webView.subviews objectAtIndex:0] setAllowsRubberBanding:NO];
	
	loader = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(tick) userInfo:nil repeats:YES];
	
}  


- (void)embedYouTube2:(NSString*)url frame:(CGRect)frame {  
	
    NSString* embedHTML = @"<html><head><style type=\"text/css\">body {background-color: transparent; color: white;    }    </style>    </head><body style=\"margin:0\">    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"%0.0f\" height=\"%0.0f\"></embed></body></html>";  
    NSString* html = [NSString stringWithFormat:embedHTML, url, frame.size.width, frame.size.height];  	
	
	[webView2 loadHTMLString:html baseURL:nil];  
	[webView2 setNeedsDisplay];
	//[[(UIScrollView*)webView.subviews objectAtIndex:0] setAllowsRubberBanding:NO];
	
	loader2 = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(tick2) userInfo:nil repeats:YES];
	
} 

-(void)tick{
	if(!webView.loading) {//If the UIWebView is finished loading stop the animation for the activity indicator
		UIImage *img = [UIImage imageNamed:@"blank.png"];
		[youtube setImage:img];	

	}
	else {
		UIImage *img = [UIImage imageNamed:@"youtube.png"];
		[youtube setImage:img];

	}
}

-(void)tick2{
	if(!webView2.loading) {//If the UIWebView is finished loading stop the animation for the activity indicator
		UIImage *img = [UIImage imageNamed:@"blank.png"];
		[youtube2 setImage:img];	
		
	}
	else {
		UIImage *img = [UIImage imageNamed:@"youtube.png"];
		[youtube2 setImage:img];
		
	}
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewWillDisappear:(BOOL)animated {
	//[alert dismissWithClickedButtonIndex:0 animated:NO];

	[super viewWillDisappear:animated];
}	


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
