//
//  PJ_ChecklistModel.h
//  cmypic
//
//  Created by Poojan Jhaveri on 6/26/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PJ_ChecklistModel : NSObject

@property(nonatomic,strong)NSMutableArray *thingstodo;
@property(nonatomic,strong)NSMutableArray *thingsdone;


+ (instancetype)sharedModel;
@end
