//
//  YouTubeViewController.h
//  VisCenter
//
//  Created by Vis Center on 7/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YouTubeViewController : UIViewController {
	IBOutlet UIWebView* webView;

	IBOutlet UITableView * newsTable;
	UIActivityIndicatorView * activityIndicator;
	CGSize cellSize;
	NSXMLParser * rssParser;
	NSMutableArray * stories;
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink;
	IBOutlet id youtube;
	NSTimer* loader;	

}
@property(nonatomic, retain) IBOutlet UIWebView *webView;

@end
