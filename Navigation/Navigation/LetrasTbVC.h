//
//  LetrasTbVC.h
//  Navigation
//
//  Created by Rubens Gondek on 3/18/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetrasTbVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
