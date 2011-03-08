//
//  LocationController.h
//  MobileDashboard
//
//  Created by james whetsell on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
	
	@protocol LocationControllerDelegate 
	@required
	- (void)locationUpdate:(CLLocation *)location; // Our location updates are sent here
	- (void)locationError:(NSError *)error; // Any errors are sent here
	@end
	
	@interface LocationController : NSObject<CLLocationManagerDelegate> {
		CLLocationManager *locMgr;
		id delegate;
	}
	
	@property (nonatomic, retain) CLLocationManager *locMgr;
	@property (nonatomic, assign) id delegate;
	
	@end