//
//  AppDelegate.m
//  ShakeMe
//
//  Created by Ahmad Bushnaq on 11/3/13.
//  Copyright (c) 2013 Ahmad Bushnaq. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import <sqlite3.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    sqlite3 *database;
    NSString *dbPath =@"phrases.sqlite";
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [documentsPaths objectAtIndex:0];
    
    NSString *_databasePath = [documentDir stringByAppendingPathComponent:dbPath];
    
    int res = sqlite3_open_v2([_databasePath UTF8String], &database, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE, NULL);

    NSString *statement = @"CREATE TABLE PHRASES(id INTEGER PRIMARY KEY autoincrement, PHRASE TEXT, SEQUENCE INT)";
    res = sqlite3_exec(database, [statement UTF8String], NULL, NULL, NULL);
    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(1,'Want to know?', 1)" UTF8String], NULL, NULL, NULL);
    const char *bleh = sqlite3_errmsg(database);
    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(2,'Are you sure?', 1)" UTF8String], NULL, NULL, NULL);
    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(3,'Knowing is not for everyone you know?', 1)" UTF8String], NULL, NULL, NULL);
        res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(4,'It may be too much for some?', 1)" UTF8String], NULL, NULL, NULL);
            res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(5,'Are you strong enough?', 1)" UTF8String], NULL, NULL, NULL);
            res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(6,'I&amp;m not sure you're strong enough', 1)" UTF8String], NULL, NULL, NULL);
            res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(7,'Sure, you may think knowing the future will make you happy', 2)" UTF8String], NULL, NULL, NULL);
            res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(8,'But sometimes knowing the future it is just sad', 2)" UTF8String], NULL, NULL, NULL);
            res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(9,'And sometimes knowing what is coming makes you mad', 2)" UTF8String], NULL, NULL, NULL);
           res = sqlite3_exec(database, [ @"INSERT INTO PHRASES VALUES(10,'Do you want your future to make you mad?', 2)" UTF8String], NULL, NULL, NULL);
            res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(11,'Isn&amp;t it more exciting not knowing?', 2)" UTF8String], NULL, NULL, NULL);
            res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(12,'See, I worry about what would happen if I told you', 2)" UTF8String], NULL, NULL, NULL);
                res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(13,'Some people have gotten angry and thrown their ipad when I told them their future', 3)" UTF8String], NULL, NULL, NULL);
                res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(14,'Are you an angry ipad thrower?', 3)" UTF8String], NULL, NULL, NULL);
                res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(15,'The future is a very intense place, full of things that haven&amp;t happened yet', 3)" UTF8String], NULL, NULL, NULL);
                res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(16,'Sometimes, the future happens, and then it is in the past', 3)" UTF8String], NULL, NULL, NULL);
                res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(17,'The first letter in your future..... is F.', 3)" UTF8String], NULL, NULL, NULL);
                res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(18,'Ok, ok, I&amp;ve messed with you enough, do you want to know your future for sure?',  4)" UTF8String], NULL, NULL, NULL);
                res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(19,'Everything comes to pass, even the future. Why are you in such a hurry?', 4)" UTF8String], NULL, NULL, NULL);
                res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(20,'If I tell you the future, and I&amp;m wrong, will you be mad?',  4)" UTF8String], NULL, NULL, NULL);

    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    application.applicationSupportsShakeToEdit = YES;
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
