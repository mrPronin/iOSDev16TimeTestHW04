//
//  RITAppDelegate.m
//  16TimeTestHW04
//
//  Created by Pronin Alexander on 19.02.14.
//  Copyright (c) 2014 Pronin Alexander. All rights reserved.
//

#import "RITAppDelegate.h"

@implementation RITAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Initialization
    NSCalendar* calendar        = [NSCalendar currentCalendar];
    NSDate* today               = [NSDate date];
    NSUInteger thisYear         = [[calendar components:NSCalendarUnitYear fromDate:today] year];
    NSDateFormatter*    dateFormatter   = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy EEEE"];
    
    // 13. Weekday for every first day and every month in current year
    NSLog(@"--------------------------------------------------------");
    NSLog(@"Weekday for every first day and every month in current year");
    NSLog(@"--------------------------------------------------------");
    NSDateComponents* comp      = [calendar
                               components:NSCalendarUnitYear
                               fromDate:today];
    comp.day                = 1;

    for (int i = 1; i <= 12; i++) {
        
        comp.month              = i;
        NSDate* firstDayOfMonth = [calendar dateFromComponents:comp];
        
        NSUInteger weekDay      = [[calendar components:NSCalendarUnitWeekday fromDate:firstDayOfMonth] weekday];
        NSLog(@"date = %@ weekday = %d", [dateFormatter stringFromDate:firstDayOfMonth], weekDay);
    }
    
    // 14. Date for every sunday in this year
    NSLog(@"--------------------------------------------------------");
    NSLog(@"Date for every sunday in this year");
    NSLog(@"--------------------------------------------------------");
    NSDateComponents* comp02    = [[NSDateComponents alloc] init];
    [comp02 setYear:thisYear];
    [comp02 setMonth:1];
    [comp02 setWeekday:1];
    [comp02 setWeekdayOrdinal:1];
    
    NSDate* enumDay             = [calendar dateFromComponents:comp02];
    
    while ([[calendar components:NSCalendarUnitYear fromDate:enumDay] year] == thisYear) {
        
        NSLog(@"%@", [dateFormatter stringFromDate:enumDay]);
        
        comp02.weekdayOrdinal++;
        
        enumDay                 = [calendar dateFromComponents:comp02];
    }
    
    // 15. Working day count for every month in this year
    NSLog(@"--------------------------------------------------------");
    NSLog(@"Working day count for every month in this year");
    NSLog(@"--------------------------------------------------------");
    NSDateComponents* comp03    = [calendar
                                   components:NSCalendarUnitYear
                                   fromDate:today];
    NSUInteger weekDay;
    NSUInteger workingDay;
    [dateFormatter setDateFormat:@"MMMM"];
    
    
    for (int month = 1; month <= 12; month++) {
        
        comp03.month            = month;
        comp03.day              = 1;
        NSDate* enumDay02       = [calendar dateFromComponents:comp03];
        weekDay      = 0;
        workingDay   = 0;
        NSString* stringMonth   = [dateFormatter stringFromDate:enumDay02];
        
        while ([[calendar components:NSCalendarUnitMonth fromDate:enumDay02] month] == month) {
            
            weekDay = [[calendar components:NSCalendarUnitWeekday fromDate:enumDay02] weekday];
            
            if (!((weekDay == 1) | (weekDay == 7))) {
                workingDay++;
            }
            
            comp03.day++;
            enumDay02           = [calendar dateFromComponents:comp03];
            
        }
        
        NSLog(@"Working days in %@: %d", stringMonth, workingDay);
        
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
