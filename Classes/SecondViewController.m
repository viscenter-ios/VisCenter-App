//
//  SecondViewController.m
//  VisCenter
//
//  Created by Zach Whelchel on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "SecondViewController.h"
#import "STITCHViewController.h"
#import "EDUCEViewController.h"
#import "SLIViewController.h"
#import "LSMViewController.h"
#import "LextranViewController.h"
#import "SpainViewController.h"

#import "SurveillanceViewController.h"
#import "CustomCell.h"


@implementation SecondViewController

- (void)viewDidLoad {
	self.title = @"Projects";

	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.22745098 green:0.34117647 blue:0.65490196 alpha:1.0];

	states = [[NSArray alloc] initWithObjects:@"Lextran",@"FoLIO",@"Liquid Modeling",@"STITCH",@"EDUCE",@"Structured Light",@"Surveillance Privacy", nil];
	descriptions = [[NSArray alloc] initWithObjects:@"\"Human Factors and Public Transit\"",@"\"Framework for Longitudinal Image-based Organization\"",@"\"Physically Guided Liquid Surface Modeling from Videos\"",@"\"Surgical Technology Integration with Tools for Cognitive Human Factors\"",@"\"Enhanced Digital Unwrapping for Conservation and Exploration\"",@"\"LUT-based processing for real-time generation and 3D reconstruction.\"",@"\"Video technology used to protect individual privacy.\"", nil];
	thumbs = [[NSArray alloc] initWithObjects:@"lextranthumb.jpg",@"spainthumb.jpg",@"lsmthumb.jpg",@"stitchthumb.jpg",@"educethumb.jpg",@"slithumb.jpg",@"surveillancethumb.jpg", nil];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70.0f;
}
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [states count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomCell";
	
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (CustomCell *) currentObject;
				break;
			}
		}
	}
	
	cell.image = [UIImage imageNamed:[thumbs objectAtIndex:indexPath.row]];

	cell.stateLabel.text = [states objectAtIndex:indexPath.row];
	cell.descriptionLabel.text = [descriptions objectAtIndex:indexPath.row];

    return cell;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath 
{ 
   return UITableViewCellAccessoryDisclosureIndicator; 
}  


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if (indexPath.row == 0){
		LextranViewController *lexController = [[LextranViewController alloc] initWithNibName:@"LextranViewController" bundle:nil];
		[self.navigationController pushViewController:lexController animated:YES];
	}
	
	if (indexPath.row == 1){
		SpainViewController *spainController = [[SpainViewController alloc] initWithNibName:@"SpainViewController" bundle:nil];
		[self.navigationController pushViewController:spainController animated:YES];
	}
	
	if (indexPath.row == 2){
	LSMViewController *lsmController = [[LSMViewController alloc] initWithNibName:@"LSMViewController" bundle:nil];
	[self.navigationController pushViewController:lsmController animated:YES];
	}
	
	if (indexPath.row == 3){
	STITCHViewController *stitchController = [[STITCHViewController alloc] initWithNibName:@"STITCHViewController" bundle:nil];
	[self.navigationController pushViewController:stitchController animated:YES];
	}
	
	if (indexPath.row == 4){
	EDUCEViewController *educeController = [[EDUCEViewController alloc] initWithNibName:@"EDUCEViewController" bundle:nil];
	[self.navigationController pushViewController:educeController animated:YES];
	}
	
	if (indexPath.row == 5){
	SLIViewController *sliController = [[SLIViewController alloc] initWithNibName:@"SLIViewController" bundle:nil];
	[self.navigationController pushViewController:sliController animated:YES];
	}
	
	if (indexPath.row == 6){
	SurveillanceViewController *surveillanceController = [[SurveillanceViewController alloc] initWithNibName:@"SurveillanceViewController" bundle:nil];
	[self.navigationController pushViewController:surveillanceController animated:YES];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

@end