//
//  MainVC.m
//  Navigation
//
//  Created by Rubens Gondek on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "MainVC.h"
#import "Model.h"
#import "Letra.h"

@interface MainVC ()

@end

@implementation MainVC{
    Model *md;
    NSArray *objs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    md = [Model instance];
    objs = [[NSArray alloc] initWithArray:[md getAllObjs]];

    // Search Bar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 25, self.view.bounds.size.width, 70)];
    [searchBar setDelegate:self];
    [searchBar setBarTintColor:[UIColor redColor]];
    [searchBar setPrompt:@"Buscar"];
    [searchBar setPlaceholder:@"Digite a palavra"];
    
    [self.view addSubview:searchBar];
    
    // Do any additional setup after loading the view.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    NSString *text = searchBar.text;
    int busca = [self searchObj:text];
    if (busca == -1){
        [UIView animateWithDuration:0.075 animations:^{
            searchBar.transform = CGAffineTransformMakeTranslation(15, 0);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.075 animations:^{
                searchBar.transform = CGAffineTransformMakeTranslation(-15, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.075 animations:^{
                    searchBar.transform = CGAffineTransformMakeTranslation(5, 0);
                }completion:^(BOOL finished) {
                    searchBar.transform = CGAffineTransformMakeTranslation(0, 0);
                }];
            }];
        }];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:[NSString stringWithFormat:@"A palavra %@ não foi encontrada no dicionário!", text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{
        md.index = busca;
        [self.tabBarController setSelectedIndex:1];
    }
}

-(int) searchObj:(NSString*)o{
    for (Letra *l in objs) {
        if ([[l.word lowercaseString] isEqualToString:[o lowercaseString]]) {
            return l.index;
        }
    }
    return -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
