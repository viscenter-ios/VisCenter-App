//
//  ThirdViewController.m
//  VisCenter
//
//  Created by Zach Whelchel on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"
#import "WebViewController.h"
#import "VisCenterAppDelegate.h"


@implementation ThirdViewController

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
	self.navigationItem.leftBarButtonItem = loadingView;
	}

	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Twitter" style:UIBarButtonItemStylePlain target:self action:@selector(Twitter)];
	//UIBarButtonItem *tempButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Twitter)];
	self.navigationItem.rightBarButtonItem = buttonItem;
	//[tempButton release];
	[buttonItem release];
	self.title = @"News";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.22745098 green:0.34117647 blue:0.65490196 alpha:1.0];
}

- (void)viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];

	cellSize = CGSizeMake([newsTable bounds].size.width, 60);
	NSTimer *timer; 
	timer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(getcontent) userInfo: nil repeats: NO];
}

-(void) getcontent {
	
	[NSThread detachNewThreadSelector:@selector(getTwitter) toTarget:self withObject:nil];
	
}


- (void) getTwitter {
	
	pool = [[NSAutoreleasePool alloc] init];
	
	if ([stories count] == 0) {
		NSString * path = @"http://viscenter.wordpress.com/feed/";
		[self parseXMLFileAtURL:path];
		
		
	}
	[pool release];
	
}


- (void) Twitter {
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	mainDelegate.site = @"http://www.twitter.com/viscenter";
	WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	[self.navigationController pushViewController:webController animated:YES];
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
	// Navigation logic
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	NSString * storyLink = [[stories objectAtIndex: storyIndex] objectForKey: @"link"];
	
	// clean up the link - get rid of spaces, returns, and tabs...
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
	
	NSLog(@"link: %@", storyLink);
	// open in Safari
	//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:storyLink]];
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	mainDelegate.site = storyLink;
	WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	[self.navigationController pushViewController:webController animated:YES];
	//[self presentModalViewController:webController animated:YES];
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

