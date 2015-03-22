//
//  LetrasTbVC.m
//  Navigation
//
//  Created by Rubens Gondek on 3/18/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetrasTbVC.h"
#import "Model.h"
#import "Letra.h"

@interface LetrasTbVC (){
    Model *md;
    Letra *lt;
    NSArray *letras;
}

@end

@implementation LetrasTbVC

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, self.view.bounds.size.width, self.view.bounds.size.height - 60)];
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    md = [Model instance];
    
    letras = [[NSArray alloc] initWithArray:[md getAllObjs]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self.view addSubview:tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return letras.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LetraCell"];
    
    lt = [letras objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:lt.word];
    [cell.detailTextLabel setText:lt.date];
    [cell.imageView setImage:[UIImage imageNamed:lt.img]];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    md.index = (int)indexPath.row;
    [[super tabBarController] setSelectedIndex:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
