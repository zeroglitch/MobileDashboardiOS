//
//  DetailViewController.h
//  TableViewApp
//
//  Created by Vladimir Olexa on 7/2/09.
//  Copyright 2009 Vladimir Olexa. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UITableViewController {
    NSMutableArray *labels;
    NSMutableArray *values;
}

- (id)initWithStyle:(UITableViewStyle)style andDvdData:(NSDictionary *)dvdData;

@end
