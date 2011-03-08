//
//  LayersCell.m
//  MobileDashboard
//
//  Created by james whetsell on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LayersCell.h"



@implementation LayersCell

@synthesize stateLabel;
@synthesize capitalLabel;
@synthesize layerState;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end

