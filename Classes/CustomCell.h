//
//  StateTableCellView.h
//  States
//
//  Created by Julio Barros on 1/26/09.
//  Copyright 2009 E-String Technologies, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell {
	IBOutlet UILabel *stateLabel;
	IBOutlet UITextView *descriptionLabel;

}

@property (nonatomic,retain) IBOutlet UILabel *stateLabel;
@property (nonatomic,retain) IBOutlet UITextView *descriptionLabel;

@end
