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
    UIBarButtonItem *space;
    UIBarButtonItem *btnImgCam;
    
    UIDatePicker *dtPicker;
    
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
    UIPinchGestureRecognizer *pinchTouch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(imgPinch:)];
    
    // -------- View
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.6 alpha:1]];
    
    // ToolBar
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 75, self.view.bounds.size.width, 44)];
    
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    
    space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style:UIBarButtonItemStylePlain target:self action:@selector(editar:)];
    [btnEdit setTintColor:[UIColor whiteColor]];

    btnImgCam = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(editarImg:)];
    [btnImgCam setTintColor:[UIColor whiteColor]];
    [btnImgCam setEnabled:NO];
    
    NSArray *tools = [[NSArray alloc] initWithObjects:space, space, btnImgCam, space, btnEdit, nil];
    
    [toolBar setItems:tools];
    
    // Date Picker
    dtPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 50)];
    [dtPicker setCalendar:[NSCalendar currentCalendar]];
    [dtPicker setDatePickerMode:UIDatePickerModeDate];
    [dtPicker setAlpha:0];
    [dtPicker setTintColor:[UIColor whiteColor]];
    
    // Imagem
    img = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.view.center.y - 75, self.view.bounds.size.width - 40, 250)];
    img.layer.cornerRadius = 100;
    img.layer.masksToBounds = YES;
    [img setUserInteractionEnabled:YES];
    [img addGestureRecognizer:panTouch];
    [img addGestureRecognizer:longPressTouch];
    [img addGestureRecognizer:pinchTouch];
    
    // TextField
    txtWord = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, self.view.bounds.size.width - 40, 50)];
    [txtWord setTintColor:[UIColor blackColor]];
    [txtWord setTextAlignment:NSTextAlignmentCenter];
    [txtWord setFont:[UIFont fontWithName:@"Avenir" size:25]];
    [txtWord setUserInteractionEnabled:NO];
    
    
    [self.view addSubview:dtPicker];
    [self.view addSubview:toolBar];
    [self.view addSubview:lblWord];
    [self.view addSubview:txtWord];
    [self.view addSubview:img];
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
    [self.navigationController pushViewController:nextPage animated:NO];
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
    if(lt.img.length <= 1){
        [img setImage:[UIImage imageNamed:lt.img]];
    }
    else{
        [img setImage:[UIImage imageWithContentsOfFile:lt.img]];
    }
}

-(IBAction)editar:(id)sender{
    if ([btnEdit.title isEqualToString:@"Editar"]) {
        [UIView animateWithDuration:0.5 animations:^{
            [txtWord setTextColor:[UIColor redColor]];
            txtWord.transform = CGAffineTransformMakeTranslation(0, -25);
            img.transform = CGAffineTransformMakeTranslation(0, 150);
            [dtPicker setAlpha:1];
        }];
        [txtWord setUserInteractionEnabled:YES];
        [txtWord becomeFirstResponder];
        [btnEdit setTitle:@"Salvar"];
        [btnImgCam setEnabled:YES];
    }
    else if ([btnEdit.title isEqualToString:@"Salvar"]){
        [txtWord endEditing:YES];
        [txtWord setUserInteractionEnabled:NO];
        [md saveObjWord:txtWord.text andDate:[NSString stringWithFormat:@"%@", dtPicker.date] atIndex:md.index];
        [self atualizar];
        [UIView animateWithDuration:0.75 animations:^{
            [txtWord setTextColor:[UIColor blackColor]];
            txtWord.transform = CGAffineTransformMakeTranslation(0, 0);
            img.transform = CGAffineTransformMakeTranslation(0, 0);

            [dtPicker setAlpha:0];
        }];
        [btnEdit setTitle:@"Editar"];
        [btnImgCam setEnabled:NO];
    }
}

-(IBAction)editarImg:(id)sender{
    [txtWord endEditing:YES];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary   ;
    }
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark ImagePicker Methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    NSArray *local = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [local objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"latest_photo.png"];
    
    NSData *webData = UIImagePNGRepresentation(chosenImage);
    [webData writeToFile:imagePath atomically:YES];
    
    [md saveObjImage:imagePath atIndex:md.index];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtWord resignFirstResponder];
}

-(void)imgMove:(UIPanGestureRecognizer*)pG{
    CGPoint p = [pG translationInView:[self view]];
    pG.view.center = CGPointMake(pG.view.center.x + p.x, pG.view.center.y + p.y);
    [pG setTranslation:CGPointMake(0, 0) inView:[self view]];
}

-(void)imgPinch:(UIPinchGestureRecognizer*)pG{
    img.transform = CGAffineTransformMakeScale([pG scale], [pG scale]);
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
