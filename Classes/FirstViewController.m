//
//  FirstViewController.m
//  MobileDashboard
//
//  Created by james whetsell on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
//#import "LocationPost.h"
#import "ASIHTTPRequest.h";
#import "ASIFormDataRequest.h";
#import "URLData.h";


@implementation FirstViewController

@synthesize CLController, urlData;//, map;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	CLController = [[LocationController alloc] init];
	CLController.delegate = self;
	[CLController.locMgr startUpdatingLocation];
	
	[CLController.locMgr startMonitoringSignificantLocationChanges];
	
	
	CLController.locMgr.desiredAccuracy = kCLLocationAccuracyBest;
	
	CLController.locMgr.distanceFilter = 100.0f;
	
	// Mapping Methods
	
	// Locate the path to the route.kml file in the application's bundle
    // and parse it with the KMLParser.
  //  NSString *path = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"kml"];
	NSURL *url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/jaxrs/devicelocation"];

	// Hospital Data
	
	//NSURL *url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/1/query?where=1%3D1%26f=kmz"];	
	//[self loadLayer:url];
	
	// 2nd set of data
//	url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/2/query?where=1%3D1%26f=kmz"];	
//	//[self loadLayer:url];
//	NSArray *overlays = [kml overlays];
//    [map addOverlays:overlays];
//    
//    // Add all of the MKAnnotation objects parsed from the KML file to the map.
//    NSArray *annotations = [kml points];
//    [map addAnnotations:annotations];
	[self loadDisplayLayers ];
	
}

- (void) loadDisplayLayers {
	unsigned count = [urlData count];
	//[map removeAnnotations:map.annotations];
	//[map removeOverlays:map.overlays];

	while (count--) {
		URLData *data = (URLData *)[urlData objectAtIndex:count];
		//NSLog(@"url %@ ", data.url);
		KMLParser *kmlData = data.kml;
		
	
		if (data.displayed == YES) {
		//	[map removeAnnotations:[kmlData points]];
		//	[map removeOverlays:[kmlData overlays]];
		//if (1==1) {
			[self loadLayer:data];
			NSLog(@"displayed = yes");
			
		} else {
			// TODO: keep tracking of the layers and remove
			NSLog(@"displayed = no");
			
			//if (kmlData != nil) {
			NSLog(@"removing layers");
			[map removeAnnotations:[kmlData points]];
			[map removeOverlays:[kmlData overlays]];
			data.kml = NULL;
				
			//}
		}
		NSLog(@"loadDisplayLayers: kml annotations count %d", [data.kml.points count]);
	}
}

- (void)loadLayer:(URLData *)data {
	
	NSURL *url = data.url;
	
	NSLog(@"url: %@", url);
	
	if (data.kml == NULL) {
	} else {
		NSLog(@"don't reload");
		return;
	}
	
	kml = [[KMLParser parseKMLAtURL:url] retain];
	kml.image = data.imageName;
	
	// store the url back into the data
	
    
    // Add all of the MKOverlay objects parsed from the KML file to the map.
	NSLog(@"number of overlays %d points %d", [[kml overlays] count], [[kml points] count]);
    NSArray *overlays = [kml overlays];
    [map addOverlays:overlays];
    
    // Add all of the MKAnnotation objects parsed from the KML file to the map.
    NSArray *annotations = [kml points];
    [map addAnnotations:annotations];
	
	
	// Walk the list of overlays and annotations and create a MKMapRect that
    // bounds all of them and store it into flyTo.
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKOverlay> overlay in overlays) {
        if (MKMapRectIsNull(flyTo)) {
            flyTo = [overlay boundingMapRect];
        } else {
            flyTo = MKMapRectUnion(flyTo, [overlay boundingMapRect]);
        }
    }
    
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    // Position the map so that all overlays and annotations are visible on screen.
    map.visibleMapRect = flyTo;
	data.kml = kml;


	NSLog(@"loadLayer: kml annotations count %d", [data.kml.points count]);

}

-(void)setUrlDataArray:(NSMutableArray *) newData {
	self.urlData = newData;
}
//**  Mapping Methods

#pragma mark MKMapViewDelegate

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    return [kml viewForOverlay:overlay];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    return [kml viewForAnnotation:annotation];
}


//**  End Mapping Methods


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


//***  Locaiton Methods ***
- (void)locationUpdate:(CLLocation *)location {

		//LocationPost *post = [LocationPost alloc];
	NSLog(@"FirstViewController.locationUpdate");
		
	[self submitData:location];

}	

- (void)locationError:(NSError *)error {
	NSLog([error description]);
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
	
	
    NSLog(@" FirewViewController.Location: %@, old %@", [newLocation description], [oldLocation description]);
}

//** end location methods

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


- (void)submitData:(CLLocation *)location{
	
	NSString *exeName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"deviceId"];
	deviceId = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceId"];
	
	// deviceId, latitude, longitude, altitude, bearing, speed, vehicletype
	NSString *values = [NSString stringWithFormat:@"iOS %@,%f,%f,%f,%f,%f,1", 
						deviceId, location.coordinate.longitude, 
						location.coordinate.latitude,[location altitude],
						[location course], [location speed] ];
	
	//NSString *values = [NSString stringWithFormat:@" values %f", [location speed]];
	
	NSURL *url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/jaxrs/devicelocation"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request addPostValue:values forKey:@"data"];
	
	[request startSynchronous];
	NSError *error = [request error];
	
	int responseCode = [request responseStatusCode];
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
