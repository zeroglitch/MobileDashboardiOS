//
//  GPSViewController.m
//  MobileDashboard
//
//  Created by james whetsell on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GPSViewController.h"
#import "ASIHTTPRequest.h";
#import "ASIFormDataRequest.h"
#import "LocationPost.h"
#import "DetailViewController.h"
#import "URLData.h"


@implementation GPSViewController

@synthesize CLController;
@synthesize listOfItems;
@synthesize gpsDataView, urlData;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	//self = [super initWithStyle:UITableViewStyleGrouped];
	//self.nibName = nibNameOrNil;
    if (self) {
        // Custom initialization.	
		self.title = @"PLEASE DO SOMETHING";
    }
    return self;
}


- (id)init {
	NSLog(@"init called");
	self = [super initWithStyle:UITableViewStyleGrouped];
	//self = [super initWithNibName:@"GPSViewController" bundle:nil];
	

	if (self != nil) {
		// Initialisation code
		self.title = @"GPS Code";
	}
	return self;
}

- (void)loadView {
    [super loadView];
	[[NSBundle mainBundle] loadNibNamed:@"GPSViewController" owner:self options:nil];
    // Your implementation here
}

//***  Locaiton Methods ***
- (void)locationUpdate:(CLLocation *)location {
//NSString *exeName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"deviceId"];
	deviceId = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceId"];
		
	NSLog(@"called locatoinUpdate");
	speedLabel.text = [NSString stringWithFormat:@"SPEED: %f", [location speed]];
	latitudeLabel.text = [NSString stringWithFormat:@"LATITUDE: %f", location.coordinate.latitude];
	longitudeLabel.text = [NSString stringWithFormat:@"LONGITUDE: %f", location.coordinate.longitude];
	altitudeLabel.text = [NSString stringWithFormat:@"ALTITUDE: %f", [location altitude]];
	bearingLabel.text = [NSString stringWithFormat:@"BEARING: %f", [location course]];
	
	// Add now the values that correspond to each label
	
	values = nil;
	values = [NSMutableArray new];
	
	[values addObject:[NSString stringWithFormat:@"%f", location.coordinate.latitude]]; 
	[values addObject:[NSString stringWithFormat:@"%f", location.coordinate.longitude]];
	[values addObject:[NSString stringWithFormat:@"%f", [location speed]]];  
	[values addObject:[NSString stringWithFormat:@"%f", [location altitude]]]; 
	[values addObject:[NSString stringWithFormat:@"%f", [location course]]]; 
	
	NSLog(@"reloading data");
	NSLog([NSString stringWithFormat:@" count %d ", [values count]]);
	[gpsDataView reloadData];

	//[self reloadInputViews];
	//LocationPost *post = [[LocationPost alloc]init];
	[self submitData:location];

}	

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
	
	
    NSLog(@"Location: %@, old %@", [newLocation description], [oldLocation description]);
}

- (void)locationError:(NSError *)error {
	statusLabel.text = [error description];
}

//** end location methods



- (void)viewDidLoad {

		
	[super viewDidLoad];
	
	deviceId = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceId"];
	
	NSLog([NSString stringWithFormat:@"%s", deviceId]);
	deviceIdField.text = deviceId;
	
	NSString *distance = [[NSUserDefaults standardUserDefaults] stringForKey:@"distanceToMove"];
	
	distanceToMove = [distance floatValue];
	
	NSLog([NSString stringWithFormat:@"distance %f", distanceToMove]);
	
	CLController = [[LocationController alloc] init];
	CLController.delegate = self;
	[CLController.locMgr startUpdatingLocation];
	
	[CLController.locMgr startMonitoringSignificantLocationChanges];
	
	//CLController.locMgr.desiredAccuracy = kCLLocationAccuracyBest;

	CLController.locMgr.distanceFilter = distanceToMove;
	//		UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTouch)];
	//		[self.view addGestureRecognizer:gestureRecognizer];
	
	//NSString *exeName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"deviceId"];

	
	statusLabel.text = @"tester11";
	
	// Table stuff
	//self.navigationController.navigationBar.barStyle = UIBarStyleBlack;.
	
	//Initialize the array.
	//		listOfItems = [[NSMutableArray alloc] init];
	//		
	//		NSArray *labels = [NSArray arrayWithObjects:@"Iceland", @"Greenland", @"Switzerland", @"Norway", @"New Zealand", @"Greece", @"Rome", @"Ireland", nil];
	//		NSDictionary *labelsDict = [NSDictionary dictionaryWithObject:labels forKey:@"Labels"];
	
	//		[listOfItems addObject:labelsDict];
	
	labels = nil;
	values = nil;
	
	labels = [NSMutableArray new];
	values = [NSMutableArray new];
	
	// Set up labels which will become header titles
	[labels addObject:@"Latitude & Longitude"];
	//[labels addObject:@"Longitude"];
	[labels addObject:@"Speed"];
	[labels addObject:@"Altitude"];
	[labels addObject:@"Bearing"];
	
	// Add now the values that correspond to each label
	[values addObject:@"test"];
	// We're faking formatting of date and length here simply dumping them as objects. 
	// We should really convert the values to proper data types and then display them as strings.
	[values addObject:@""];     
	[values addObject:@""]; 
	[values addObject:@""]; 
	[values addObject:[NSString stringWithFormat:@"%@ minutes", @"5.00"]];  
		
		//Set the title
	//self.navigationItem.title = @"Labels";
		
		// end table stuff
	
	[self.tableView setSeparatorColor:[UIColor blackColor]];	
	//[self.tableView.style:UITableViewStyleGrouped];
	
	NSLog([NSString stringWithFormat:@"the style %@ ", self.tableView.style]);
	self.title = @"GPS Information";
}


// Override to support row selection in the table view.
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // UITableViewStyleGrouped table view style will cause the table have a textured background 
//    // and each section will be separated from the other ones.
//    DetailViewController *controller = [[DetailViewController alloc] 
//                                        initWithStyle:UITableViewStyleGrouped];
//    controller.title = @"title";
//    [self.tabBarController pushViewController:controller animated:YES];
//    [controller release];
//}


// Table view methods


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
		return 2;
	} else {
		return 1;
	}
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
	return [labels objectAtIndex:section];
    //return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [labels count];
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *CellIdentifier = @"LibraryListingCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
//                                       reuseIdentifier:CellIdentifier] autorelease];
//    }
//    
//	cell.textLabel.text = @"jamie"; //[[dao libraryItemAtIndex:indexPath.row] valueForKey:@"title"];
//	
//    return cell;
	
	
    static NSString *CellIdentifier = @"DetailViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSLog([NSString stringWithFormat:@"row %d section %d", [indexPath row], indexPath.section]);
	if (indexPath.section == 0) {
		if ([indexPath row] == 0) {
			cell.textLabel.text = [values objectAtIndex:0];

		} else {
			cell.textLabel.text = [values objectAtIndex:1];
		}
	} else {
		cell.textLabel.text = [values objectAtIndex:indexPath.section+1];

	}
	
    return cell;
}

- (id) initWithCoder: (NSCoder *) coder {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    }
    return self;
}


// end table view methods

// Transmit the GPS Data
- (void)submitData:(CLLocation *)location{
	
	NSString *exeName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"deviceId"];
	deviceId = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceId"];
	
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


- (void)dealloc {
    [super dealloc];
    [labels release];
    [values release];
	[urlData release];
	[CLController release];
}

@end
