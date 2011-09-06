//
//  ImageViewController.h
//  VisCenter
//
//  Created by Zach Whelchel on 7/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageViewController : UIViewController {
	IBOutlet id imagelarge;
	IBOutlet UIView *textside;
	IBOutlet UIView *textflat;
	BOOL needside;
	BOOL needflat;
	NSTimer *gettext;
	double alphavalue;
	
	IBOutlet UILabel *side;
	IBOutlet UILabel *flat;

}

- (IBAction) returntoproject;


@end