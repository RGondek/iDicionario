//
//  Model.m
//  Navigation
//
//  Created by Rubens Gondek on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize words, index, letter, img;

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
        words = [[NSMutableArray alloc] initWithObjects:@"Ametista", @"Berilo", @"Citrino", @"Diamante", @"Esmeralda", @"Fluorita", @"Granada", @"Hematita", @"iRock", @"Jade", @"Kunzita", @"Lapis Lázuli", @"Moon Stone", @"Nitrino", @"Ônix", @"Pirita", @"Quartzo", @"Rubi", @"Safira", @"Turmalina", @"Unakita", nil];
        letter = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", nil];
        img = [[NSMutableArray alloc] initWithObjects:@"Ametista", @"Berilo", @"Citrino", @"Diamante", @"Esmeralda", @"Fluorita", @"Granada", @"Hematita", @"iRock", @"Jade", @"Kunzita", @"Lapis Lázuli", @"Moon Stone", @"Nitrino", @"Ônix", @"Pirita", @"Quartzo", @"Rubi", @"Safira", @"Turmalina", @"Unakita", nil];
    }
    return self;
}

-(id)initPokemon{
    self = [super init];
    if (self) {
        index = 0;
        words = [[NSMutableArray alloc] initWithObjects:@"Arcanine", @"Bulbasaur", @"Charmander", nil];
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
