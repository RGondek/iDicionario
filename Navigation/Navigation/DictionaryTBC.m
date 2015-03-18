//
//  DictionaryTBC.m
//  Navigation
//
//  Created by Rubens Gondek on 3/18/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "DictionaryTBC.h"
#import "LetraVC.h"
#import "LetrasTbVC.h"

@interface DictionaryTBC ()

@end

@implementation DictionaryTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LetraVC *letra = [[LetraVC alloc] init];
    LetrasTbVC *tbLetras = [[LetrasTbVC alloc] init];
    UINavigationController *letraNC = [[UINavigationController alloc] initWithRootViewController:letra];
    
    NSArray *tabViews = [[NSArray alloc] initWithObjects:letraNC, tbLetras, nil];
    
    [self setViewControllers:tabViews];
    
    letra.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Lista" image:[UIImage imageWithContentsOfFile:@"item1"] tag:1];
    tbLetras.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Letras" image:[UIImage imageWithContentsOfFile:@"item2"] tag:2];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
