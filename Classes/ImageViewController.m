//
//  ImageViewController.m
//  VisCenter
//
//  Created by Zach Whelchel on 7/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageViewController.h"
#import "VisCenterAppDelegate.h"

@implementation ImageViewController

- (void)viewDidLoad {
		CGAffineTransform transform = CGAffineTransformMakeRotation (3.14159/2); 
        textside.transform = transform; 
        // Repositions and resizes the view. 
        CGRect contentRect = CGRectMake(0, 0, 480, 30); 
        textside.bounds = contentRect; 
        [textside setCenter:CGPointMake(15.0f, 240.0f)]; 
	
	alphavalue = -.4;
	needside = NO;
	needflat = NO;
	textside.alpha = 0.0;
	textflat.alpha = 0.0;
	
	gettext = [NSTimer scheduledTimerWithTimeInterval:(1.0/60.0) target:self selector:@selector(show) userInfo:nil repeats:YES];
	
	VisCenterAppDelegate *mainDelegate = (VisCenterAppDelegate *)[[UIApplication sharedApplication]delegate];
	if (mainDelegate.sliderValue == 1) {
		UIImage *theImageObject = [UIImage imageNamed:@"educe1large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Carbonized scroll during a preliminary CT scan"];
	}
	if (mainDelegate.sliderValue == 2) {
		UIImage *theImageObject = [UIImage imageNamed:@"educe2large.jpg"];
		[imagelarge setImage:theImageObject];
		needflat = YES;
		[flat setText:@"Viewing scan of Herculaneum scroll at French National Institute"];
	}
	if (mainDelegate.sliderValue == 3) {
		UIImage *theImageObject = [UIImage imageNamed:@"educe3large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Example of a papyrus scroll"];
	}
	if (mainDelegate.sliderValue == 4) {
		UIImage *theImageObject = [UIImage imageNamed:@"educe4large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Carbonized Herculaneum scroll"];
	}
	if (mainDelegate.sliderValue == 5) {
		UIImage *theImageObject = [UIImage imageNamed:@"educe5large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Carbonized Herculaneum scroll"];
	}	
	if (mainDelegate.sliderValue == 6) {
		UIImage *theImageObject = [UIImage imageNamed:@"image1large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Eye-tracking cameras provide feedback on a subject’s mental workload"];
	}
	if (mainDelegate.sliderValue == 7) {
		UIImage *theImageObject = [UIImage imageNamed:@"image2large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Projector array creates one continuous, large display area"];
	}
	if (mainDelegate.sliderValue == 8) {
		UIImage *theImageObject = [UIImage imageNamed:@"image3large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Research setup tracks subject’s use of surgical tools"];
	}
	if (mainDelegate.sliderValue == 9) {
		UIImage *theImageObject = [UIImage imageNamed:@"image4large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"A training exercise using surgical tools"];
	}
	if (mainDelegate.sliderValue == 10) {
		UIImage *theImageObject = [UIImage imageNamed:@"image5large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Developing advanced non-invasive tools is the future of the surgical field"];
	}
	if (mainDelegate.sliderValue == 11) {
		UIImage *theImageObject = [UIImage imageNamed:@"sli1large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Example of a real-time 3-D video model"];
	}
	if (mainDelegate.sliderValue == 12) {
		UIImage *theImageObject = [UIImage imageNamed:@"sli2large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Camera and projector used for capturing real-time 3D video"];
	}
	if (mainDelegate.sliderValue == 13) {
		UIImage *theImageObject = [UIImage imageNamed:@"sli3large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Light pattern projected on a hand during process of structured light"];
	}
	if (mainDelegate.sliderValue == 14) {
		UIImage *theImageObject = [UIImage imageNamed:@"sli4large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"3-D model of palm print"];
	}
	if (mainDelegate.sliderValue == 15) {
		UIImage *theImageObject = [UIImage imageNamed:@"sli5large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Light pattern projected on a hand during process of structured light"];
	}
	if (mainDelegate.sliderValue == 16) {
		UIImage *theImageObject = [UIImage imageNamed:@"lsm1large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"3-D rendering of liquid surface modeling from video"];
	}
	if (mainDelegate.sliderValue == 17) {
		UIImage *theImageObject = [UIImage imageNamed:@"lsm2large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Research setup for liquid modeling with cameras, projector and splash tub"];
	}
	if (mainDelegate.sliderValue == 18) {
		UIImage *theImageObject = [UIImage imageNamed:@"lsm3large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"3-D rendering of liquid surface modeling from video"];
	}
	if (mainDelegate.sliderValue == 19) {
		UIImage *theImageObject = [UIImage imageNamed:@"lsm4large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"3-D rendering of liquid surface modeling from video"];
	}
	if (mainDelegate.sliderValue == 20) {
		UIImage *theImageObject = [UIImage imageNamed:@"lsm5large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"3-D rendering of liquid surface modeling from video"];
	}
	if (mainDelegate.sliderValue == 21) {
		UIImage *theImageObject = [UIImage imageNamed:@"surveillance1large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Key fob transmits a radio frequency removing the person from the image"];
	}
	if (mainDelegate.sliderValue == 22) {
		UIImage *theImageObject = [UIImage imageNamed:@"surveillance2large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Signal received by a receiver"];
	}
	if (mainDelegate.sliderValue == 23) {
		UIImage *theImageObject = [UIImage imageNamed:@"surveillance3large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"While two people are in the hallway, only one is seen in the video playback"];
	}
	if (mainDelegate.sliderValue == 24) {
		UIImage *theImageObject = [UIImage imageNamed:@"surveillance4large.jpg"];
		[imagelarge setImage:theImageObject];
		needflat = YES;
		[flat setText:@"Receiver signals recording device to protect part of the image"];
	}
	if (mainDelegate.sliderValue == 25) {
		UIImage *theImageObject = [UIImage imageNamed:@"surveillance5large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Camera records the scene"];
	}
	if (mainDelegate.sliderValue == 26) {
		UIImage *theImageObject = [UIImage imageNamed:@"spain1large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"El Escorial Monastery and Cathedral in San Lorenzo, Spain"];
	}
	if (mainDelegate.sliderValue == 27) {
		UIImage *theImageObject = [UIImage imageNamed:@"spain2large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Interior of El Escorial Library"];
	}
	if (mainDelegate.sliderValue == 28) {
		UIImage *theImageObject = [UIImage imageNamed:@"spain3large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Researchers processing the incoming data"];
	}
	if (mainDelegate.sliderValue == 29) {
		UIImage *theImageObject = [UIImage imageNamed:@"spain4large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Two complete manuscripts of Homer’s Iliad from the eleventh century"];
	} 
	if (mainDelegate.sliderValue == 30) {
		UIImage *theImageObject = [UIImage imageNamed:@"spain5large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"El Escorial Library is famous for its scholarly holdings"];
	}
	if (mainDelegate.sliderValue == 31) {
		UIImage *theImageObject = [UIImage imageNamed:@"lextran1large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"LexTran General Manager Rocky Burke attended the presentations"];
	}
	if (mainDelegate.sliderValue == 32) {
		UIImage *theImageObject = [UIImage imageNamed:@"lextran2large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"2010 Human-Technology Interaction students"];
	}
	if (mainDelegate.sliderValue == 33) {
		UIImage *theImageObject = [UIImage imageNamed:@"lextran3large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"The project gave students the opportunity to apply ideas to a real problem"];
	}
	if (mainDelegate.sliderValue == 34) {
		UIImage *theImageObject = [UIImage imageNamed:@"lextran4large.jpg"];
		[imagelarge setImage:theImageObject];
		needflat = YES;
		[flat setText:@"Students presented ideas such as user-friendly maps"];
	}
	if (mainDelegate.sliderValue == 35) {
		UIImage *theImageObject = [UIImage imageNamed:@"lextran5large.jpg"];
		[imagelarge setImage:theImageObject];
		needside = YES;
		[side setText:@"Other ideas included making LexTran’s website and information system more friendly"];
	}
    [super viewDidLoad];
}

- (void) show {
	if (needside == YES && textside.alpha < .7) {
		alphavalue = alphavalue + .03;
		
		textside.alpha = alphavalue;
	}
	
	
	if (needflat == YES && textflat.alpha < .7) {
		alphavalue = alphavalue + .03;
		
		textflat.alpha = alphavalue;	
	}
	
}



- (IBAction) returntoproject {
[self dismissModalViewControllerAnimated:YES];

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
