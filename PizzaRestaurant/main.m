//
//  main.m
//  PizzaRestaurant
//
//  Created by Steven Masuch on 2014-07-19.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Kitchen.h"
#import "Pizza.h"
#import "Manager.h"
#import "MicroManager.h"

// String to PizzaSize
PizzaSize stringToPizzaSize(NSString *sizeString) {
    if ([sizeString.lowercaseString isEqualToString:@"small"]) {
        return PizzaSizeSmall;
    } else if ([sizeString.lowercaseString isEqualToString:@"medium"]) {
        return PizzaSizeMedium;
    } else {
        // default size
        return PizzaSizeLarge;
    }
}

// PizzaSize to String
NSString * sizeToString(PizzaSize size) {
    switch (size) {
        case PizzaSizeSmall:
            return @"small";
        case PizzaSizeMedium:
            return @"medium";
        case PizzaSizeLarge:
            return @"large";
    }
}


int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        Kitchen *restaurantKitchen = [Kitchen new];
        
        //MicroManager *microManager = [MicroManager new];
        //Manager *manager = [Manager new];
        
        MicroManager *microManager;
        Manager *manager;

        //restaurantKitchen.delegate = microManager;
        //restaurantKitchen.delegate = manager;
        
        while (YES) {

            NSLog(@"\nChoose manager:\n 1 - manager \n 2 - micromanager \n 3 - no manager");
            
            char managerInputString[5];
      
            NSString *managerString = [[NSString alloc] initWithUTF8String:fgets(managerInputString, 5, stdin)];
            
            managerString = [managerString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

            NSLog(@"Input was %@", managerString);

            int managerNumber = [managerString intValue];
            
            switch (managerNumber) {
                case 1:
                    if (!manager) {
                        manager = [Manager new];
                    }
                    restaurantKitchen.delegate = manager;
                    break;
                case 2:
                    if (!microManager) {
                        microManager = [MicroManager new];
                    }
                    restaurantKitchen.delegate = microManager;
                    break;
                default:
                    restaurantKitchen.delegate = nil;
                    break;
            }
            
            
            NSLog(@"Please pick your pizza size and toppings:");

            char pizzaInputString[100];
            
            NSString *pizzaString = [[NSString alloc] initWithUTF8String:fgets(pizzaInputString, 100, stdin)];

            pizzaString = [pizzaString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

            NSLog(@"Input was %@", pizzaString);
            
            
            
            // Take the first word of the command as the size, and the rest as the toppings
            NSArray *commandWords = [pizzaString componentsSeparatedByString:@" "];

            //NSDictionary *sizeDictionary = @{@"small": @0, @"medium": @1, @"large": @2};
            //NSNumber *sizeNumber = [sizeDictionary objectForKey:commandWords[0]];
            //PizzaSize size = (PizzaSize)sizeNumber;

            PizzaSize size = stringToPizzaSize(commandWords[0]);
            
            NSArray *toppings = [commandWords subarrayWithRange:NSMakeRange(1, commandWords.count-1)];
            
            // And then send some message to the kitchen...
            Pizza *pizza = [restaurantKitchen makePizzaWithSize:size toppings: toppings];
            
            if (pizza) {
                NSLog(@"Pizza size: %@", sizeToString(pizza.size));
                
                NSMutableString *toppingsString = [[NSMutableString alloc] initWithString:@"Pizza toppings:"];
                
                for (int i = 0; i < pizza.toppings.count; i++) {
                    NSString *topping = [NSString stringWithFormat:@" %@", pizza.toppings[i]];
                    [toppingsString appendString:topping];
                }
                NSLog(@"%@", toppingsString);
            } else {
                NSLog(@"Pizza FAIL");
            }
        }
    }
    return 0;
}

