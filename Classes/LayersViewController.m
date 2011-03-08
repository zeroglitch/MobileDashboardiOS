//
//  LayersViewController.m
//  MobileDashboard
//
//  Created by james whetsell on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LayersViewController.h"
#import "LayersCell.h"
#import "URLData.h"
#import "FirstViewController.h"


@implementation LayersViewController

@synthesize mapLayer, urlData;


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
	//self = [super initWithNibName:@"LayersViewcontroller" bundle:nil];
	
	
	if (self != nil) {
		// Initialisation code
		self.title = @"GPS Code";
	}
	return self;
}

- (void)loadView {
    [super loadView];
	[[NSBundle mainBundle] loadNibNamed:@"LayersViewController" owner:self options:nil];
    // Your implementation here
}



- (void)viewDidLoad {
    [super viewDidLoad];
	
	states = [[NSArray alloc] initWithObjects:@"Hospitals",@"Medical",@"Vehicles",nil];
	capitals = [[NSArray alloc] initWithObjects:@"1",@"1",@"0",nil];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"here ya go count %d", [urlData count]);

    return [urlData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSLog(@"here ya go");
    static NSString *CellIdentifier = @"LayersCell";
	
    LayersCell *cell = (LayersCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LayersCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (LayersCell *) currentObject;
				break;
			}
		}
	}
		
	//cell.capitalLabel.text = [states objectAtIndex:indexPath.row];
	//cell.stateLabel.text = [states objectAtIndex:indexPath.row];
	URLData *displayData = (URLData *)[urlData objectAtIndex:indexPath.row];
	cell.capitalLabel.text = displayData.labelName;
	

	//NSString *onOffString = [NSString stringWithFormat:@"%d", displayData.displayed];
	BOOL onOff = displayData.displayed; //[onOffString intValue];

	[cell.layerState setOn:onOff];
	
	cell.layerState.tag = indexPath.row;
	[cell.layerState addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
	
		
	return cell;
}

// SWITCH ACTIONS
- (IBAction) flip: (id) sender {
    UISwitch *onoff = (UISwitch *) sender;
   // NSLog(@"%@", onoff.on ? @"On" : @"Off");
	unsigned objIndex = 0;
	
	
	//unsigned count = [self.tableView count];
//	while (count--) {
		
	//	LayersCell *theCell = [self.tableView cellForRowAtIndexPath:count];
		URLData *data = (URLData *)[urlData objectAtIndex:onoff.tag];
	//	NSLog(@"flip.........switch %@ ", data.labelName);

	//	if (theCell.layerState == sender) {
			if (onoff.on == YES) {
				objIndex = onoff.tag;
				data.displayed = YES;
			} else {
				data.displayed = NO;
			}

	//	}
//	}
	//data = (URLData *)[urlData objectAtIndex:objIndex];
//	NSLog(@"flip........switch %@ , %d", data.labelName, data.displayed);

	mapLayer.loadDisplayLayers;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
    [super dealloc];
}


@end

