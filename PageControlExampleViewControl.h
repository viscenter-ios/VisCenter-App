//
//  PageControlExampleViewControl.h
//  PageControlExample
//
//  Created by Chakra on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageControlExampleViewControl : UIViewController {

	IBOutlet UIImageView *imageSlide;
    int pageNumber;
	
	NSArray * imageNames;
}

@property (nonatomic, retain) UILabel *pageNumberLabel;

- (id)initWithPageNumber:(int)page;

	


@end
