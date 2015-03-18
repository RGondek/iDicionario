//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetraVC.h"
#import "Model.h"

@implementation LetraVC{
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
    btnNext.enabled = NO;
    btnPrev.enabled = NO;
    [lblWord setAlpha:0];
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:2 animations:^{
        img.transform = CGAffineTransformMakeScale(1, 1);
        img.transform = CGAffineTransformMakeRotation(M_PI);
        img.transform = CGAffineTransformMakeRotation(0);
        [lblWord setAlpha:1];
    } completion:^(BOOL finished) {
        btnNext.enabled = YES;
        btnPrev.enabled = YES;
    }];
}

-(void)next:(id)sender {
    LetraVC *nextPage = [[LetraVC alloc]init];
//    NSMutableArray *views = [[NSMutableArray alloc] initWithObjects:[self.navigationController.viewControllers objectAtIndex:1], [self.navigationController.viewControllers objectAtIndex:2], nil, nil];
//    [views replaceObjectAtIndex:2 withObject:nextPage];
    [self.navigationController pushViewController:nextPage animated:YES];
    if (md.index == ([md.words count]-1)) {
        md.index = 0;
    }
    else { md.index++; }
}

-(void)prev:(id)sender {
    if (md.index == 0) {
        LetraVC *prevPage = [[LetraVC alloc] initWithNibName:nil bundle:NULL];
        [self.navigationController pushViewController:prevPage animated:YES];
        md.index = (int)([md.words count]-1);
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
        md.index--;
    }
}

@end
