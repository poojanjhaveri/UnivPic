//
//  PJ_ChecklistModel.h
//  cmypic
//
//  Created by Poojan Jhaveri on 6/26/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PJ_ChecklistModel : NSObject

@property(nonatomic,strong)NSMutableArray *thingstodo;
@property(nonatomic,strong)NSMutableArray *thingsdone;
@property(strong,nonatomic) PFObject *myPFArray;

- (NSUInteger) addAnswer: (NSString *)answerText;
-(void) deleteAnswer:(NSString *)deleteitem;
+ (instancetype)sharedModel;
-(void)savetoserver: (NSString *)item;
-(void)pullfromserver;
@end
