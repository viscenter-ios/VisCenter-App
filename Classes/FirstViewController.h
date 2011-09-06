//
//  FirstViewController.h
//  VisCenter
//
//  Created by Zach Whelchel on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface FirstViewController : UIViewController <UIScrollViewDelegate> {

	IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;
}

- (void)loadScrollViewWithPage:(int)page;

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;

@end
