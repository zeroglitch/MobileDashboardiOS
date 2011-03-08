//
//  LocationPost.m
//  MobileDashboard
//
//  Created by james whetsell on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationPost.h"
#import "ASIHTTPRequest.h";
#import "ASIFormDataRequest.h";

@implementation LocationPost


- (void)locationUpdate:(CLLocation *)location:(NSString *)deviceId {

	// deviceId, latitude, longitude, altitude, bearing, speed, vehicletype
	NSString *values = [NSString stringWithFormat:@"iOS %@,%f,%f,%f,%f,%f,1", 
						deviceId, location.coordinate.longitude, 
						location.coordinate.latitude,[location altitude],
						[location course], [location speed] ];
	
	//NSString *values = [NSString stringWithFormat:@" values %f", [location speed]];
	NSLog(values);
	
	NSURL *url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/jaxrs/devicelocation"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request addPostValue:values forKey:@"data"];
	
	[request startSynchronous];
	NSError *error = [request error];
	
	int responseCode = [request responseStatusCode];
	NSLog(@"test %d ", responseCode);
	if (responseCode <= 200 && responseCode >= 300) {
		//NSString *response = [request responseString];
		NSLog(@"Error trasmitting Data %s..", error);
	//	statusLabel.text = [NSString stringWithFormat:@"Error Sending Information %s", error];
	} else {
		//statusLabel.text = [NSString stringWithFormat:@"Success Sending Information"];
	}
	
	NSLog([request responseString]);
}	



@end
