//
//  PageControlExampleViewControl.m
//  PageControlExample
//
//  Created by Chakra on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PageControlExampleViewControl.h"


static NSArray *__pageControlColorList = nil;

@implementation PageControlExampleViewControl

@synthesize pageNumberLabel;

// Creates the color list the first time this method is invoked. Returns one color object from the list.
+ (UIColor *)pageControlColorWithIndex:(NSUInteger)index {
    if (__pageControlColorList == nil) {
        __pageControlColorList = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor magentaColor],
                                  [UIColor blueColor], [UIColor orangeColor], [UIColor brownColor], [UIColor grayColor], [UIColor grayColor], nil];
    }
    // Mod the index by the list length to ensure access remains in bounds.
    return [__pageControlColorList objectAtIndex:index % [__pageControlColorList count]];
}

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"PageControllerExample" bundle:nil]) {
		
		
		imageNames = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"slide_CLOUDS_01.png"],[UIImage imageNamed:@"slide_CLOUDS_02.png"],[UIImage imageNamed:@"slide_GRASS.png"],[UIImage imageNamed:@"slide_EYE.png"],[UIImage imageNamed:@"slide_FACULTY-STAFF-STUDENTS.png"],[UIImage imageNamed:@"slide_WATER.png"],[UIImage imageNamed:@"slide_PEOPLE.png"], [UIImage imageNamed:@"slide_HAND.png"], nil];
		
		
        pageNumber = page;
    }
    return self;
}

- (void)dealloc {
    [pageNumberLabel release];
    [super dealloc];
}

// Set the label and background color when the view has finished loading.
- (void)viewDidLoad {
    imageSlide.image = [imageNames objectAtIndex:pageNumber];
    //self.view.backgroundColor = [PageControlExampleViewControl pageControlColorWithIndex:pageNumber];
}


@end
