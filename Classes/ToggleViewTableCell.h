//
//  ToggleViewTableCell.h
//  MobileDashboard
//
//  Created by james whetsell on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ToggleViewTableCell : UITableViewCell {
    IBOutlet UILabel *toggleNameLabel;
    IBOutlet UILabel *detailedTextLabel;
    IBOutlet UISwitch *toggle;
    NSNumber *value;
    id owner;
	
	IBOutlet UITableViewCell *view;
}

@property (nonatomic, retain) UILabel *toggleNameLabel;
@property (nonatomic, retain) UILabel *detailedTextLabel;
@property (nonatomic, retain) UISwitch *toggle;
@property (nonatomic, retain) id owner;
@property (nonatomic, retain) UITableViewCell *view;


-(void) setLabel:(NSString*)aString;
-(void) setValue:(NSNumber*)aNum;
-(NSNumber*)value;
-(void) setTagOnToggle:(NSInteger)aTag;

-(IBAction)toggleValue:(id)sender;

@end