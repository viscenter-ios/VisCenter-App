//
//  ThirdViewController.h
//  VisCenter
//
//  Created by Zach Whelchel on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ThirdViewController : UIViewController {

	IBOutlet UITableView * newsTable;
	UIActivityIndicatorView * activityIndicator;
	CGSize cellSize;
	NSXMLParser * rssParser;
	NSMutableArray * stories;
	
	NSAutoreleasePool *pool;
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink;
	
}

@end
