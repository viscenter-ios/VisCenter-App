//
//  YouTubeViewController.m
//  VisCenter
//
//  Created by Vis Center on 7/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "YouTubeViewController.h"


#import "VisCenterAppDelegate.h"

@implementation YouTubeViewController
- (void)viewDidLoad {
	
	//UIApplication* app = [UIApplication sharedApplication];
	//app.networkActivityIndicatorVisible = YES;
	
	// make the activity indicator as the right side button
	if ([stories count] == 0) {
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
	}
	
	self.title = @"YouTube";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.22745098 green:0.34117647 blue:0.65490196 alpha:1.0];
}

- (void)viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	cellSize = CGSizeMake([newsTable bounds].size.width, 60);
	NSTimer *timer; 
	timer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(getcontent) userInfo: nil repeats: NO];
}



-(void) getcontent {
	
	
		
		[NSThread detachNewThreadSelector:@selector(getYoutube) toTarget:self withObject:nil];
		
	
	
	
}

- (void) getYoutube {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if ([stories count] == 0) {
		NSString * path = @"http://gdata.youtube.com/feeds/base/users/viscenter/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile";
		[self parseXMLFileAtURL:path];
	}
	[pool release];

}


- (void)parseXMLFileAtURL:(NSString *)URL {
	stories = [[NSMutableArray alloc] init];
	
	//you must then convert the path to a proper NSURL or it won't work
	NSURL *xmlURL = [NSURL URLWithString:URL];
	
	// here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
	// this may be necessary only for the toolchain
	rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
	// Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
	[rssParser setDelegate:self];
	
	// Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
	[rssParser setShouldProcessNamespaces:NO];
	[rssParser setShouldReportNamespacePrefixes:NO];
	[rssParser setShouldResolveExternalEntities:NO];
	
	[rssParser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	NSLog(@"found file and started parsing");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"You are not connected to the Internet.", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error Loading Content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	//NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
	
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array...
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentLink forKey:@"link"];
		[item setObject:currentSummary forKey:@"summary"];
		[item setObject:currentDate forKey:@"date"];
		
		[stories addObject:[item copy]];
		NSLog(@"adding story: %@", currentTitle);
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"link"]) {
		[currentLink appendString:string];
	} else if ([currentElement isEqualToString:@"description"]) {
		[currentSummary appendString:string];
	} else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	
	NSLog(@"all done!");
	NSLog(@"stories array has %d items", [stories count]);
	
	//UIApplication* app = [UIApplication sharedApplication];
	//app.networkActivityIndicatorVisible = NO;
	
	[newsTable reloadData];
}
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stories count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	[cell setText:[[stories objectAtIndex: storyIndex] objectForKey: @"title"]];
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
	UIImage *img = [UIImage imageNamed:@"youtube2.png"];
	[youtube setImage:img];
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	NSString * storyLink = [[stories objectAtIndex: storyIndex] objectForKey: @"link"];
	
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
	
	NSLog(@"link: %@", storyLink);
	//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:storyLink]];
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	mainDelegate.site = storyLink;
	//WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	//[self presentModalViewController:webController animated:YES];
	
	[self embedYouTube:mainDelegate.site frame:webView.frame];
	
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
	
	[activityIndicator startAnimating];
}

- (void)embedYouTube:(NSString*)url frame:(CGRect)frame {  
	
    NSString* embedHTML = @"<html><head><style type=\"text/css\">body {background-color: transparent; color: white;    }    </style>    </head><body style=\"margin:0\">    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"%0.0f\" height=\"%0.0f\"></embed></body></html>";  
    NSString* html = [NSString stringWithFormat:embedHTML, url, frame.size.width, frame.size.height];  	
	
	[webView loadHTMLString:html baseURL:nil];
	[webView setNeedsDisplay];
	loader = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(tick) userInfo:nil repeats:YES];
	//[[(UIScrollView*)webView.subviews objectAtIndex:0] setAllowsRubberBanding:NO];

	UIImage *img = [UIImage imageNamed:@"youtube2.png"];
	[youtube setImage:img];
}  

-(void)tick{
	if(!webView.loading) {//If the UIWebView is finished loading stop the animation for the activity indicator
		UIImage *img = [UIImage imageNamed:@"blank.png"];
		[youtube setImage:img];	
		[activityIndicator stopAnimating];
		[activityIndicator removeFromSuperview];
	}
	else {
		UIImage *img = [UIImage imageNamed:@"youtube2.png"];
		[youtube setImage:img];
	}
	
}

/*
 // Override to support row selection in the table view.
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
 // Navigation logic may go here -- for example, create and push another view controller.
 // AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
 // [self.navigationController pushViewController:anotherViewController animated:YES];
 // [anotherViewController release];
 }
 */


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
	[currentElement release];
	[rssParser release];
	[stories release];
	[item release];
	[currentTitle release];
	[currentDate release];
	[currentSummary release];
	[currentLink release];
	
	[super dealloc];
}


@end

