//
//  MicroManager.m
//  PizzaRestaurant
//
//  Created by Fariha on 6/8/18.
//  Copyright © 2018 Lighthouse Labs. All rights reserved.
//

#import "MicroManager.h"

@implementation MicroManager

- (BOOL)kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize)size andToppings:(NSArray *)toppings {
    
    if ([toppings containsObject:@"anchovies"]) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)kitchenShouldUpgradeOrder:(Kitchen *)kitchen {
    return NO;
}

@end
