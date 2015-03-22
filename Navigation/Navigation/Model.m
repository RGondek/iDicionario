//
//  Model.m
//  Navigation
//
//  Created by Rubens Gondek on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize words, index, letter, imgs, pseudoBD;

static Model *_instance = nil;

+(Model*) instance{
    if (_instance == nil) {
        _instance = [[Model alloc] init];
    }
    return _instance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        pseudoBD = [RLMRealm defaultRealm];
        index = 0;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if ([user valueForKey:@"first"] == nil) {
            [self burnData];
            [user setValue:@"SECOND" forKey:@"first"];
        }
    }
    return self;
}

-(void) burnData{
    words = [[NSMutableArray alloc] initWithObjects:@"AC/DC", @"Black Sabbath", @"Creed", @"DragonForce", @"Eric Clapton", @"Foo Fighters", @"Gorillaz", @"HammerFall", @"Iron Maiden", @"Judas Priest", @"Korn", @"Linkin Park", @"Metallica", @"NightWish", @"Oasis", @"Pearl Jam", @"Queen", @"R.E.M", @"System of a Down", @"Tenacious D", @"U2", @"Van Hallen", @"Weezer", @"Xuxa", @"Yeah Yeah Yeahs", @"ZZ Top", nil];
    letter = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    imgs = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    for (int i=0; i < letter.count; i++) {
        Letra *l = [[Letra alloc] init];
        l.word = [words objectAtIndex:i];
        l.img = [imgs objectAtIndex:i];
        l.letter = [letter objectAtIndex:i];
        l.index = i;
        [pseudoBD beginWriteTransaction];
        [pseudoBD addObject:l];
        [pseudoBD commitWriteTransaction];
    }
}

-(NSArray*) getAllObjs{
    RLMResults *res = [Letra allObjects];
    NSMutableArray *mutVet = [[NSMutableArray alloc] init];
    for (Letra *l in res) {
        [mutVet addObject:l];
    }
    return mutVet;
}

-(Letra*) getObjAtIndex:(int)i{
    RLMResults *res = [Letra objectsWhere:[NSString stringWithFormat:@"index=%d", i]];
    for (Letra *l in res) {
        if (l.index == i) {
            return l;
        }
    }
    return nil;
}

-(void) saveObjWord:(NSString*)w atIndex:(int)i{
    Letra *l = [self getObjAtIndex:i];
    [pseudoBD beginWriteTransaction];
    l.word = w;
    [pseudoBD commitWriteTransaction];
}

-(void) saveObjImage:(NSString*)img atIndex:(int)i{
    Letra *l = [self getObjAtIndex:i];
    [pseudoBD beginWriteTransaction];
    l.img = img;
    [pseudoBD commitWriteTransaction];
}

@end
