//
//  MobileDashboardAppDelegate.h
//  MobileDashboard
//
//  Created by james whetsell on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSViewController.h"
#import "FirstViewController.h"
#import "LayersViewController.h"
#import "URLData.h"

@interface MobileDashboardAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	// Table stuff
	FirstViewController *rootViewContrller;//Normal UViewController for first Tab
	GPSViewController *tableViewController;//TableviewController for second
	LayersViewController *layersViewController;//TableviewController for second
	
	NSMutableArray *urlData;


}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet FirstViewController *rootViewContrller;
@property (nonatomic, retain) IBOutlet LayersViewController *layersViewController;
@property (nonatomic, retain) NSMutableArray *urlData;

-(void) loadDataSet;

@end
