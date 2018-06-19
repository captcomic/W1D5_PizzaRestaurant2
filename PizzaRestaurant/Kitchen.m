//
//  Kitchen.m
//  PizzaRestaurant
//
//  Created by Steven Masuch on 2014-07-19.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "Kitchen.h"

@implementation Kitchen


- (Pizza *)makePizzaWithSize:(PizzaSize)size toppings:(NSArray *)toppings {

    if (self.delegate) {
        
        if (![self.delegate kitchen:self shouldMakePizzaOfSize:size andToppings:toppings]) {
            return nil;
        }
        
        if ([self.delegate kitchenShouldUpgradeOrder:self]) {
            size = PizzaSizeLarge;
        }
        
    }
    
    Pizza *pizza;
    
    if ((toppings.count == 1) && [toppings[0] isEqualToString:@"meatlovers"]) {
        pizza = [Pizza meatLoversWithSize:size];
    } else {
        pizza = [[Pizza alloc] initWithSize:size toppings:toppings];
    }

    if ([self.delegate respondsToSelector:@selector(kitchenDidMakePizza:)]) {
        [self.delegate performSelector:@selector(kitchenDidMakePizza:) withObject:pizza];
    }
    
    return pizza;
    
}

@end
