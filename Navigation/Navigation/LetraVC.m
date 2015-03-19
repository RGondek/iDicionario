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
    UITextField *txtWord;
    
    UIBarButtonItem *btnNext;
    UIBarButtonItem *btnPrev;
    UIBarButtonItem *btnEdit;
    UIBarButtonItem *btnDone;
    
    UIImageView *img;
    
    CGPoint firstP;
    float xd, yd;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    // Singleton
    md = [Model instance];
    
    // Navigation
    btnNext = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    btnPrev = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(prev:)];
    self.navigationItem.rightBarButtonItem=btnNext;
    self.navigationItem.leftBarButtonItem=btnPrev;
    
    // -------- View
    // ToolBar
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, 44)];
    
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    
    btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style:UIBarButtonItemStylePlain target:self action:@selector(editar:)];
    btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(salvar:)];
    btnDone.enabled = NO;
    [btnEdit setTintColor:[UIColor whiteColor]];
    [btnDone setTintColor:[UIColor whiteColor]];
    
    NSArray *tools = [[NSArray alloc] initWithObjects:btnEdit, btnDone, nil];
    
    [toolBar setItems:tools];
    
    // Imagem
    img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.view.bounds.size.width / 1.15), 250)];
    img.center = self.view.center;
    [img setUserInteractionEnabled:YES];
    
    // TextField
    txtWord = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, self.view.bounds.size.width - 40, 50)];
    txtWord.backgroundColor = [UIColor whiteColor];
    txtWord.alpha = 0;
    txtWord.placeholder = @"Digite aqui a nova palavra";
    
    
    // Label
    lblWord = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.view.center.y + 125), self.view.bounds.size.width, 100)];
    [lblWord setTintColor:[UIColor blackColor]];
    [lblWord setTextAlignment:NSTextAlignmentCenter];
    [lblWord setFont:[UIFont fontWithName:@"Avenir" size:60]];
    
    [self.view addSubview:toolBar];
    [self.view addSubview:lblWord];
    [self.view addSubview:txtWord];
    [self.view addSubview:img];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.3 green:1 blue:0.6 alpha:1]];
}

-(void)viewWillAppear:(BOOL)animated{
    img.transform = CGAffineTransformMakeScale(0.2, 0.2);
    [self atualizar];
    btnNext.enabled = NO;
    btnPrev.enabled = NO;
    [lblWord setAlpha:0];
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:0.5 animations:^{
        img.transform = CGAffineTransformMakeScale(1, 1);
        img.transform = CGAffineTransformMakeRotation(M_PI);
        img.transform = CGAffineTransformMakeRotation(0);
        [lblWord setAlpha:1];
    } completion:^(BOOL finished) {
        btnNext.enabled = YES;
        btnPrev.enabled = YES;
    }];
}

#pragma mark Navigation

-(void)next:(id)sender {
    if (md.index == ([md.words count]-1)) {
        md.index = 0;
    }
    else { md.index++; }
    
    LetraVC *nextPage = [[LetraVC alloc]init];
    [self.navigationController pushViewController:nextPage animated:YES];
}

-(void)prev:(id)sender {
    if (md.index == 0) {
        md.index = (int)([md.words count]-1);
    }
    else{ md.index--; }
    
    LetraVC *prevPage = [[LetraVC alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController pushViewController:prevPage animated:NO];
    
}

#pragma mark Methods

-(void)atualizar{
    self.navigationItem.title = [NSString stringWithFormat:@"%c",[[md.words objectAtIndex:md.index] characterAtIndex:0]];
    [lblWord setText:[md.words objectAtIndex:md.index]];
    [img setImage:[UIImage imageNamed:[md.words objectAtIndex:md.index]]];
}

-(IBAction)editar:(id)sender{
    [UIView animateWithDuration:0.75 animations:^{
        lblWord.alpha = 0;
        txtWord.alpha = 1;
    }];
    [btnEdit setEnabled:NO];
    [btnDone setEnabled:YES];
}

-(IBAction)salvar:(id)sender{
    [txtWord endEditing:YES];
    [md.words replaceObjectAtIndex:md.index withObject:txtWord.text];
    [self atualizar];
    [UIView animateWithDuration:0.75 animations:^{
        lblWord.alpha = 1;
        txtWord.alpha = 0;
    }];
    [btnEdit setEnabled:YES];
    [btnDone setEnabled:NO];
}

#pragma mark Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:img]) {
        firstP = [touch locationInView:[self view]];
        xd = firstP.x - [[touch view] center].x;
        yd = firstP.y - [[touch view] center].y;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:img]) {
        CGPoint p = [touch locationInView:[self view]];
        [[touch view] setCenter:CGPointMake(p.x - xd, p.y - yd)];
    }
}

@end
