//
//  Letra.h
//  Navigation
//
//  Created by Rubens Gondek on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

@interface Letra : RLMObject

@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *letter;
@property int index;

@end
