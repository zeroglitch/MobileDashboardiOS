//
//  URLData.h
//  MobileDashboard
//
//  Created by james whetsell on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMLParser.h"


@interface URLData : NSObject {
	NSString *labelName;
	BOOL displayed;
	NSURL *url;
	NSString *imageName;
	
	KMLParser *kml;

}
@property (nonatomic, retain) KMLParser *kml;
@property (nonatomic, retain) NSString *labelName;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic) BOOL displayed;

@end
