//
//  Model.m
//  Navigation
//
//  Created by Rubens Gondek on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize imgs, words, index;

static Model *_instance = nil;

+(Model*) instance{
    if (_instance == nil) {
        _instance = [[Model alloc] init];
    }
    return _instance;
}

-(id)init{
    self = [super init];
    if (self) {
        index = 0;
        words = @[@"Ametista", @"Berilo", @"Citrino", @"Diamante", @"Esmeralda", @"Fluorita", @"Granada", @"Hematita", @"iRock", @"Jade", @"Kunzita", @"Lapis Lázuli", @"Moon Stone", @"Nitrino", @"Ônix", @"Pirita", @"Quartzo", @"Rubi", @"Safira", @"Turmalina", @"Unakita"];
        imgs = @[@"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart", @"heart"];
    }
    return self;
}

-(id)initPokemon{
    self = [super init];
    if (self) {
        index = 0;
        words = @[@"Arcanine", @"Bulbassaur", @"Charmander"];
    }
    return self;
}

+(Model*) pokemon{
    if (_instance == nil) {
        _instance = [[Model alloc] initPokemon];
    }
    return _instance;
}

@end
