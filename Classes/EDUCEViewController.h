//
//  EDUCEViewController.h
//  VisCenter
//
//  Created by Zach Whelchel on 7/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ImageViewController.h"


@interface EDUCEViewController : UIViewController {

	IBOutlet UIScrollView *scrollView1;	// holds five small images to scroll horizontally
	UIWebView *webView;
	NSTimer* loader;	
	IBOutlet id youtube;
}

@property (nonatomic, retain) UIView *scrollView1;
@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
