//
//  ToggleViewTableCell.m
//  MobileDashboard
//
//  Created by james whetsell on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ToggleViewTableCell.h"


@implementation ToggleViewTableCell

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
-(void) setLabel:(NSString*)aString {
	detailedTextLabel.text = aString;
}
-(void) setValue:(NSNumber*)aNum {
	value = aNum;
}
-(void) setTagOnToggle:(NSInteger)aTag {
}


-(IBAction)toggleValue:(id)sender {
    BOOL oldValue = [value boolValue];
    [value release];
    value = [[NSNumber numberWithBool:!oldValue] retain];
    [owner performSelector:@selector(someAction:) withObject:toggle];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
