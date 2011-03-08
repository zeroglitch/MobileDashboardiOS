//
//  LayersCell.h
//  MobileDashboard
//
//  Created by james whetsell on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LayersCell : UITableViewCell {
	
	IBOutlet UILabel *stateLabel;
	IBOutlet UILabel *capitalLabel;
	IBOutlet UISwitch *layerState;
}

@property (nonatomic,retain) IBOutlet UILabel *stateLabel;
@property (nonatomic,retain) IBOutlet UILabel *capitalLabel;
@property (nonatomic,retain) IBOutlet UISwitch *layerState;

@end
