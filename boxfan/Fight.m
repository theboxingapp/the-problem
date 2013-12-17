//
//  Fight.m
//  boxfan
//
//  Created by Chris Tibbs on 12/15/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "Fight.h"
#import "Boxer.h"

@interface Fight() {
    NSDictionary *_dictionary;
}

@end

@implementation Fight

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _dictionary = dictionary;
        
        _date = [dictionary objectForKey:@"date"];
        _weight = [dictionary objectForKey:@"weight"];
        _location = [dictionary objectForKey:@"location"];
        
        NSArray *boxers = [dictionary objectForKey:@"boxers"];
        
        _boxers = boxers;
        _rounds = [dictionary objectForKey:@"rounds"];
        
    }
    return self;
}

-(NSString *)titleForScheduleView
{
    NSString *title = [[NSString alloc] init];
    
    Boxer *aSide = [self.boxers objectAtIndex:0];
    Boxer *bSide = [self.boxers objectAtIndex:1];
    
     // we want "<A-side boxer> - <B-side boxer>"
    title = [NSString stringWithFormat:@"%@ %@ - %@",self.date, [aSide lastName],[bSide lastName]];
    
    return title;
}

@end