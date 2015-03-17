//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetraAViewController.h"
#import "Model.h"

@implementation LetraAViewController{
    Model *md;
    UILabel *lblWord;
    UIBarButtonItem *btnNext;
    UIBarButtonItem *btnPrev;
    UIImageView *img;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.title = @"A";
    btnNext = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem=btnNext;
    btnPrev = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(prev:)];
    self.navigationItem.leftBarButtonItem=btnPrev;
    
    md = [Model instance];
    
//    UIButton *botao = [UIButton buttonWithType:UIButtonTypeSystem];
//    [botao setTitle:@"Texto menor" forState:UIControlStateNormal];
//    [botao sizeToFit];
//    botao.center = self.view.center;
//    btnNext = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    btnNext.center = self.view.center;
//    [self.view addSubview:botao];
//    [self.view addSubview:btnNext];
    
    img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, (self.view.bounds.size.width / 1.15), 250)];
    img.center = self.view.center;
    
    
    
    lblWord = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.view.center.y + 150), self.view.bounds.size.width, 50)];
    [lblWord setTintColor:[UIColor blackColor]];
    [lblWord setTextAlignment:NSTextAlignmentCenter];
    [lblWord setFont:[UIFont fontWithName:@"Avenir" size:60]];
    
    [self.view addSubview:lblWord];
    [self.view addSubview:img];
    [self.view setBackgroundColor:[UIColor grayColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    img.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.navigationItem.title = [NSString stringWithFormat:@"%c",[[md.words objectAtIndex:md.index] characterAtIndex:0]];
    [lblWord setText:[md.words objectAtIndex:md.index]];
    [img setImage:[UIImage imageNamed:@"heart"]];
    if (md.index == ([md.words count]-1)) {
        [btnNext setEnabled:NO];
    }
    else if (md.index == 0) {
        [btnPrev setEnabled:NO];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:1 animations:^{
        img.transform = CGAffineTransformMakeScale(1, 1);
        img.transform = CGAffineTransformMakeRotation(M_PI);
        img.transform = CGAffineTransformMakeRotation(0);
    }];
}

-(void)next:(id)sender {
    if (md.index < [md.words count]) {
        LetraAViewController *nextPage = [[LetraAViewController alloc] initWithNibName:nil bundle:NULL];
        [self.navigationController pushViewController:nextPage animated:YES];
        md.index++;
    }
}

-(void)prev:(id)sender {
    if (md.index > 0) {
        [self.navigationController popViewControllerAnimated:YES];
        md.index--;
    }
}

@end
