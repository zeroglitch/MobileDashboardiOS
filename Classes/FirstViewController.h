//
//  FirstViewController.h
//  MobileDashboard
//
//  Created by james whetsell on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationController.h"
#import "KMLParser.h"
#import <MapKit/MapKit.h>


@interface FirstViewController : UIViewController <LocationControllerDelegate> {
	LocationController *CLController;
	
	NSString *deviceId;
	
	IBOutlet MKMapView *map;
    KMLParser *kml;
	
	IBOutlet UILabel *bearingLabel;
	IBOutlet UILabel *altitudeLabel;
	
	NSMutableArray *urlData;
}

@property (nonatomic, retain) LocationController *CLController;
@property (nonatomic, retain) NSMutableArray *urlData;
//@property (nonatomic, retain) MKMapView *map;

//-(void) setLabel:(NSString*)aString;
//-(void) loadLayer: (URLData *)data;
-(void) setUrlDataArray:(NSMutableArray *)newData;
-(void) loadDisplayLayers;
@end
