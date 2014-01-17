//
//  Pick.m
//  boxfan
//
//  Created by Chris Tibbs on 12/16/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "Pick.h"

@implementation Pick

-(instancetype)initWithFightViewDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSLog (@"%@",[dictionary valueForKeyPath:@"fight.pick"]);
        if (![[dictionary valueForKeyPath:@"fight.pick"] isKindOfClass:[NSNull class]]) {
            NSMutableArray *boxerArray = [[NSMutableArray alloc] init];
            for (NSDictionary *boxerDict in [dictionary valueForKeyPath:@"fight.boxers"]) {
                Boxer *b = [[Boxer alloc] initWithDictionary:boxerDict[@"boxer"]];
                [boxerArray addObject:b];
            }
            
            _user = self.user;
            
            NSString *winnerID = [dictionary valueForKeyPath:@"fight.pick.winner_id"];
            Boxer *b = [boxerArray firstObject];
            
            if ([b.boxerID.description  isEqualToString:winnerID.description]) {
                _winner = b;
                _loser = [boxerArray lastObject];
            } else {
                _winner = [boxerArray lastObject];
                _loser = b;
            }
            
            NSString *koObj = [dictionary valueForKeyPath:@"fight.pick.ko"];
            NSString *ko = koObj.description;
            if ([ko isEqualToString:@"1"]) {
                _byStoppage = YES;
            } else if ([ko isEqualToString:@"0"]) {
                _byStoppage = NO;
            }
        } else {
            self = nil;
        }
    }
    return self;
}

-(instancetype)initWithFeedViewDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        User *user = [[User alloc] initWithDictionary:[dictionary valueForKeyPath:@"pick.user"]];
        _user = user;
        
        NSMutableArray *boxerArray = [[NSMutableArray alloc] init];
        for (NSDictionary *boxerDict in [dictionary valueForKeyPath:@"pick.fight.boxers"]) {
            Boxer *b = [[Boxer alloc] initWithDictionary:boxerDict[@"boxer"]];
            [boxerArray addObject:b];
        }
        
        NSString *winnerID = [dictionary valueForKeyPath:@"pick.winner_id"];

        Boxer *b = [boxerArray firstObject];
        
        if ([b.boxerID.description  isEqualToString:winnerID.description]) {
            _winner = b;
            _loser = [boxerArray lastObject];
        } else {
            _winner = [boxerArray lastObject];
            _loser = b;
        }
        
        Fight *fight = [[Fight alloc] initWithDictionary:[dictionary valueForKeyPath:@"pick.fight"]];
        _fight = fight;
    }
    return self;
}

-(NSString *)feedRepresentation
{
    NSString *byStoppageString = [[NSString alloc] init];
    if (!self.byStoppage) {
        byStoppageString = @"by decision";
    } else {
        byStoppageString = @"by KO";
    }
    
    NSString *feedRep = [NSString stringWithFormat:@"%@ picked %@ over %@ %@",self.user.name,self.winner.lastName,self.loser.lastName,byStoppageString];
    
    return feedRep;
}

-(instancetype)initWithScheduleViewDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        Fight *f = [[Fight alloc] init];
        f.fightID = [dictionary valueForKeyPath:@"pick.fight_id"];
        _fight = f;
        
        Boxer *w = [[Boxer alloc] init];
        w.boxerID = [dictionary valueForKeyPath:@"pick.winner_id"];
        _winner = w;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@, %@, %@,",self.user, self.fight, self.winner, self.loser];
}

@end
