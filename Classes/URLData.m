//
//  URLData.m
//  MobileDashboard
//
//  Created by james whetsell on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "URLData.h"


@implementation URLData

@synthesize url, labelName, displayed, kml, imageName;


-(void)dealloc {
	[url release];
	[labelName release];
	//[displayed release];
	[super dealloc];
}

@end
