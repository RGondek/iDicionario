//
//  Model.h
//  Navigation
//
//  Created by Rubens Gondek on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Letra.h"

@interface Model : NSObject

@property RLMRealm *pseudoBD;

@property NSMutableArray *words;
@property NSMutableArray *letter;
@property NSMutableArray *img;
@property int index;

-(void) burnData;
-(void) saveObjWord:(NSString*)w atIndex:(int)i;

+(Model*) instance;
-(NSArray*) getAllObjs;

@end
