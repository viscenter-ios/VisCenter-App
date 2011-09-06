//
//  ProfileViewController.m
//  VisCenter
//
//  Created by Zach Whelchel on 7/6/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LextranViewController.h"
#import "VisCenterAppDelegate.h"
#import "MediaPlayer/MPMoviePlayerController.h"

@implementation LextranViewController

@synthesize scrollView1;




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [scrollView1 subviews];
	
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (280);
		}
	}
	
	// set the content size so it can be scrollable
	[scrollView1 setContentSize:CGSizeMake((5 * 280), [scrollView1 bounds].size.height)];
}

- (void)viewDidLoad
{
	//[self embedYouTube:@"http://www.youtube.com/watch?v=DG76YaM9hmI&feature=channel_page" frame:webView.frame];

	self.title = @"Lextran";
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
	
	// 1. setup the scrollview for multiple images and add it to the view controller
	//
	// note: the following can be done in Interface Builder, but we show this in code for clarity
	[scrollView1 setBackgroundColor:[UIColor blackColor]];
	[scrollView1 setCanCancelContentTouches:NO];
	scrollView1.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView1.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	scrollView1.scrollEnabled = YES;
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
	scrollView1.pagingEnabled = YES;
	
	// load all the images from our bundle and add them to the scroll view
	NSUInteger i;
	for (i = 1; i <= 5; i++)
	{
		NSString *imageName = [NSString stringWithFormat:@"lextran%d.jpg", i];
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect = imageView.frame;
		rect.size.height = 125;
		rect.size.width = 280;
		imageView.frame = rect;
		imageView.tag = i;	// tag our images for later use when we place them in serial fashion
		[scrollView1 addSubview:imageView];
		[imageView release];
	}
	
	UIButton *btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	//[btn setBackgroundColor:[UIColor whiteColor]];
	btn.frame = CGRectMake(0, 0, 280, 125);
	btn.bounds = CGRectMake(0, 0, 280, 125);
	[btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
	[scrollView1 addSubview:btn];
	
	UIButton *btn2 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	btn2.frame = CGRectMake(280, 0, 280, 125);
	btn2.bounds = CGRectMake(280, 0, 280, 125);
	[btn2 addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
	[scrollView1 addSubview:btn2];
	
	UIButton *btn3 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	btn3.frame = CGRectMake(560, 0, 280, 125);
	btn3.bounds = CGRectMake(560, 0, 280, 125);
	[btn3 addTarget:self action:@selector(buttonClick3) forControlEvents:UIControlEventTouchUpInside];
	[scrollView1 addSubview:btn3];
	
	UIButton *btn4 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	btn4.frame = CGRectMake(840, 0, 280, 125);
	btn4.bounds = CGRectMake(840, 0, 280, 125);
	[btn4 addTarget:self action:@selector(buttonClick4) forControlEvents:UIControlEventTouchUpInside];
	[scrollView1 addSubview:btn4];
	
	UIButton *btn5 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	btn5.frame = CGRectMake(1120, 0, 280, 125);
	btn5.bounds = CGRectMake(1120, 0, 280, 125);
	[btn5 addTarget:self action:@selector(buttonClick5) forControlEvents:UIControlEventTouchUpInside];
	[scrollView1 addSubview:btn5];
	
	[self layoutScrollImages];	// now place the photos in serial layout within the scrollview
}

- (void)embedYouTube:(NSString*)url frame:(CGRect)frame {  
	
	
    NSString* embedHTML = @"<html><head><style type=\"text/css\">body {background-color: transparent; color: white;    }    </style>    </head><body style=\"margin:0\">    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"%0.0f\" height=\"%0.0f\"></embed></body></html>";  
    NSString* html = [NSString stringWithFormat:embedHTML, url, frame.size.width, frame.size.height];  	

	[webView loadHTMLString:html baseURL:nil];  
	[webView setNeedsDisplay];
	//[[(UIScrollView*)webView.subviews objectAtIndex:0] setAllowsRubberBanding:NO];

	loader = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(tick) userInfo:nil repeats:YES];

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

-(void) buttonClick {
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	mainDelegate.sliderValue = 31;
	ImageViewController *imageController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
	[self presentModalViewController:imageController animated:YES];
}

-(void) buttonClick2 {
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	mainDelegate.sliderValue = 32;
	ImageViewController *imageController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
	[self presentModalViewController:imageController animated:YES];
}

-(void) buttonClick3 {
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	mainDelegate.sliderValue = 33;
	ImageViewController *imageController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
	[self presentModalViewController:imageController animated:YES];
}

-(void) buttonClick4 {
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	mainDelegate.sliderValue = 34;
	ImageViewController *imageController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
	[self presentModalViewController:imageController animated:YES];
}

-(void) buttonClick5 {
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	mainDelegate.sliderValue = 35;
	ImageViewController *imageController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
	[self presentModalViewController:imageController animated:YES];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	[scrollView1 release];
    [super dealloc];
}


@end
