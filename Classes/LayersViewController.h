//
//  LayersViewController.h
//  MobileDashboard
//
//  Created by james whetsell on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"   


@interface LayersViewController : UITableViewController {

	NSMutableArray *urls;
	
	IBOutlet UITableView *layerView;
	
	NSArray *states;
	NSArray *capitals;
	
	NSMutableArray *urlData;
	
	FirstViewController *mapLayer;
}

@property (nonatomic, retain) UITableView *layerView;
@property (nonatomic, retain) NSMutableArray *urls;
@property (nonatomic, retain) NSMutableArray *urlData;
@property (nonatomic, retain) FirstViewController *mapLayer;


- (IBAction) flip: (id) sender;

@end
