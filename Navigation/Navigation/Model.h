//
//  Model.h
//  Navigation
//
//  Created by Rubens Gondek on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property NSMutableArray *words;
@property int index;

+(Model*) instance;
+(Model*) pokemon;
-(instancetype)initPokemon;

@end
