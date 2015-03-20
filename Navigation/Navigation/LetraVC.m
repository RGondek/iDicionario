//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetraVC.h"
#import "Model.h"
#import "Letra.h"

@implementation LetraVC{
    Model *md;
    Letra *lt;
    UILabel *lblWord;
    UITextField *txtWord;
    
    UIBarButtonItem *btnNext;
    UIBarButtonItem *btnPrev;
    UIBarButtonItem *btnEdit;
    UIBarButtonItem *btnDone;
    
    UIImageView *img;
    
    NSArray *letras;
    
    CGPoint firstP;
    float xd, yd;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    // Singleton
    md = [Model instance];
    letras = [[NSArray alloc] initWithArray:[md getAllObjs]];
    
    // Navigation
    btnNext = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    btnPrev = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(prev:)];
    self.navigationItem.rightBarButtonItem=btnNext;
    self.navigationItem.leftBarButtonItem=btnPrev;
    
    // Gesture Recognizer
    UIPanGestureRecognizer *panTouch = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imgMove:)];
    UILongPressGestureRecognizer *longPressTouch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imgZoom:)];
    
    // -------- View
    // ToolBar
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 75, self.view.bounds.size.width, 44)];
    
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    
    btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style:UIBarButtonItemStylePlain target:self action:@selector(editar:)];
    btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(salvar:)];
    btnDone.enabled = NO;
    [btnEdit setTintColor:[UIColor whiteColor]];
    [btnDone setTintColor:[UIColor whiteColor]];
    
    NSArray *tools = [[NSArray alloc] initWithObjects:btnEdit, btnDone, nil];
    
    [toolBar setItems:tools];
    
    // Imagem
    img = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.view.center.y - 75, self.view.bounds.size.width - 40, 250)];
    [img setUserInteractionEnabled:YES];
    img.layer.cornerRadius = 100;
    img.layer.masksToBounds = YES;
    [img addGestureRecognizer:panTouch];
    [img addGestureRecognizer:longPressTouch];
    
    // TextField
    txtWord = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, self.view.bounds.size.width - 40, 50)];
    [txtWord setTintColor:[UIColor blackColor]];
    [txtWord setTextAlignment:NSTextAlignmentCenter];
    [txtWord setFont:[UIFont fontWithName:@"Avenir" size:25]];
    
    
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
    [txtWord setAlpha:0];
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:0.5 animations:^{
        img.transform = CGAffineTransformMakeScale(1, 1);
        img.transform = CGAffineTransformMakeRotation(M_PI);
        img.transform = CGAffineTransformMakeRotation(0);
        [txtWord setAlpha:1];
    } completion:^(BOOL finished) {
        btnNext.enabled = YES;
        btnPrev.enabled = YES;
    }];
}

#pragma mark Navigation

-(void)next:(id)sender {
    if (md.index == ([letras count]-1)) {
        md.index = 0;
    }
    else { md.index++; }
    
    LetraVC *nextPage = [[LetraVC alloc]init];
    [self.navigationController pushViewController:nextPage animated:YES];
}

-(void)prev:(id)sender {
    if (md.index == 0) {
        md.index = (int)([letras count]-1);
    }
    else{ md.index--; }
    
    LetraVC *prevPage = [[LetraVC alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController pushViewController:prevPage animated:NO];
    
}

#pragma mark Methods

-(void)atualizar{
    letras = [md getAllObjs];
    lt = [letras objectAtIndex:md.index];
    self.navigationItem.title = lt.letter;
    [txtWord setText:lt.word];
    [img setImage:[UIImage imageNamed:lt.img]];
}

-(IBAction)editar:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        [txtWord setTextColor:[UIColor redColor]];
    }];
    [txtWord becomeFirstResponder];
    [btnEdit setEnabled:NO];
    [btnDone setEnabled:YES];
}

-(IBAction)salvar:(id)sender{
    [txtWord endEditing:YES];
    [md saveObjWord:txtWord.text atIndex:md.index];
    [self atualizar];
    [UIView animateWithDuration:0.75 animations:^{
        [txtWord setTextColor:[UIColor blackColor]];
    }];
    [btnEdit setEnabled:YES];
    [btnDone setEnabled:NO];
}

#pragma mark Touch Methods

-(void)imgMove:(UIPanGestureRecognizer*)pG{
    CGPoint p = [pG translationInView:[self view]];
    pG.view.center = CGPointMake(pG.view.center.x + p.x, pG.view.center.y + p.y);
    [pG setTranslation:CGPointMake(0, 0) inView:[self view]];
}

-(void)imgZoom:(UILongPressGestureRecognizer*)pG{
    if (pG.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.25 animations:^{
            img.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
    }
    else if (pG.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.25 animations:^{
            img.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }
}

@end
