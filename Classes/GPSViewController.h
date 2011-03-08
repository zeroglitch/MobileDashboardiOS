//
//  GPSViewController.h
//  MobileDashboard
//
//  Created by james whetsell on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//  *******   Equates to My list in the controller
//

#import <UIKit/UIKit.h>
#import "LocationController.h"
@interface GPSViewController : UITableViewController <LocationControllerDelegate, UITextFieldDelegate> {
	LocationController *CLController;
	IBOutlet UILabel *statusLabel;
	
	
	IBOutlet UILabel *latitudeLabel;
	IBOutlet UILabel *longitudeLabel;
	IBOutlet UILabel *speedLabel;
	IBOutlet UILabel *bearingLabel;
	IBOutlet UILabel *altitudeLabel;
	
	IBOutlet UILabel *deviceIdField;
	IBOutlet UIButton *changeDeviceIdButton;
	
	NSString *deviceId;
		
	NSMutableArray *labels;
    NSMutableArray *values;
	
	float distanceToMove;
	
	
	IBOutlet UITableView *gpsDataView;
	
	CLLocation *lastLocation;
	
	NSMutableArray *urlData;
	
		
}

@property (nonatomic, retain) LocationController *CLController;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) UITableView *gpsDataView;

@property (nonatomic, retain) NSMutableArray *urlData;


- (id)init;
- (void)loadView;
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation ;

@end
