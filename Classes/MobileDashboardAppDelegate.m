//
//  MobileDashboardAppDelegate.m
//  MobileDashboard
//
//  Created by james whetsell on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MobileDashboardAppDelegate.h"
#import "URLData.h"


@implementation MobileDashboardAppDelegate

@synthesize window;
@synthesize tabBarController, rootViewContrller, layersViewController, urlData;



#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	urlData = [[NSMutableArray alloc] init]; 
	[self loadDataSet];
	[self printData:urlData];
    // Override point for customization after application launch.
    rootViewContrller=[[FirstViewController alloc] initWithNibName:@"FirstView"
															bundle:nil];
	rootViewContrller.title=@"Map";
	NSLog(@"sending count... %d", [urlData count]);
	[rootViewContrller setUrlDataArray:urlData];
	NSLog(@"after set url data");
	[rootViewContrller loadDisplayLayers];
	
	//tableViewController=[[GPSViewController alloc] initWithNibName:@"GPSViewController"
	//														   bundle:nil];
	tableViewController=[[GPSViewController alloc] init];
	//tableViewController = [[GPSViewController alloc] initWithStyle:UITableViewStyleGrouped];
	tableViewController.title=@"GPSViewController";
	
	layersViewController=[[LayersViewController alloc] init];
	//tableViewController = [[layersViewController alloc] initWithStyle:UITableViewStyleGrouped];
	layersViewController.title=@"Layers";
	
	layersViewController.urlData = urlData;
	layersViewController.mapLayer = rootViewContrller;
	
	tabBarController=[[UITabBarController alloc] init] ;
	tabBarController.viewControllers=[NSArray arrayWithObjects:rootViewContrller,tableViewController,layersViewController,nil];
	[window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

-(void) loadDataSet {
	//urlData = [NSMutableArray init];
	URLData *data = [URLData alloc];
	
	data.url =  [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/1/query?where=1%3D1%26f=kmz"];	
;
	data.labelName = @"Hospitals";
	data.displayed = NO;//[NSNumber numberWithBool:YES];
	data.imageName = @"ems.operations.emergencyMedical.hospital.png";
	[urlData addObject:data];
	[data release];

	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/2/query?where=1%3D1%26f=kmz"];
	data.labelName = @"Schools";
	data.displayed = NO;
	data.imageName = @"ems.infrastructure.education.school.png";
	[urlData addObject:data];
	[data release];

	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/jaxrs/devicelocation"];
	data.labelName = @"People";
	data.displayed = NO;
	data.imageName = @"";
	[urlData addObject:data];
	[data release];
	
	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/3/query?where=1%3D1%26f=kmz"];
	data.labelName = @"Fire Departments";
	data.displayed = NO;
	data.imageName = @"ems.operations.emergencyFire.fireStation.png";
	[urlData addObject:data];
	[data release];
	
	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/4/query?where=1%3D1%26f=kmz"];
	data.labelName = @"EMS";
	data.displayed = NO;
	data.imageName = @"ems.operations.emergency.emergencyOperationsCenter.png";
	[urlData addObject:data];
	[data release];
	
	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/5/query?where=1%3D1%26f=kmz"];
	data.labelName = @"Police";
	data.displayed = NO;
	data.imageName = @"ems.operations.lawEnforcement.policeStation.png";
	[urlData addObject:data];
	[data release];
	
//	data = [URLData alloc];
//	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/6/query?where=1%3D1%26f=kmz"];
//	data.labelName = @"Don't Know";
//	data.displayed = NO;
	
//	[urlData addObject:data];
//	[data release];
	
	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/7/query?where=1%3D1%26f=kmz"];
	data.labelName = @"Pipelines";
	data.displayed = NO;
	data.imageName = @"ems.infrastructure.water.publicWaterSupplyIntake.png";
	[urlData addObject:data];
	[data release];
//	
//	data = [URLData alloc];
//	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/8/query?where=1%3D1%26f=kmz"];
//	data.labelName = @"8";
//	data.displayed = NO;
//	
//	[urlData addObject:data];
//	[data release];
//	
	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/10/query?where=1%3D1%26f=kmz"];
	data.labelName = @"Fire Districts";
	data.displayed = NO;
	
	[urlData addObject:data];
	[data release];
	
	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/weather.kml"];
	data.labelName = @"Weather";
	data.displayed = NO;
	
	[urlData addObject:data];
	[data release];
}

-(void) printData:(NSMutableArray *) dataSet {
	unsigned count = [dataSet count];
	while (count--) {
		//URLData *data = (URLData *)[dataSet objectAtIndex:count];
		//NSLog(@" url %@, label %s, displayed %d", data.url, data.labelName, data.displayed);

	}	
	
}



- (void)dealloc {
	
  //  [rootViewContrller release];
  //  [tableViewController release];
   // [tabBarController release];
	//[urlData release];
    [window release];
    [super dealloc];
}

@end