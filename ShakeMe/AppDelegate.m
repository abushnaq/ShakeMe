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
    
//    sqlite3 *database;
//    NSString *dbPath =@"phrases.sqlite";
//    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString *documentDir = [documentsPaths objectAtIndex:0];
//    
//    NSString *_databasePath = [documentDir stringByAppendingPathComponent:dbPath];
//    
//    int res = sqlite3_open_v2([_databasePath UTF8String], &database, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE, NULL);
//
//    NSString *statement = @"CREATE TABLE PHRASES(id INTEGER PRIMARY KEY autoincrement, PHRASE TEXT)";
//    res = sqlite3_exec(database, [statement UTF8String], NULL, NULL, NULL);
//        res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(1,'The future is a very intense place, full of things that haven&amp;t happened yet')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(2, 'The first letter in your future..... is F.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(3, 'Your future ends with an e.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(4, 'Knowing the future is not for everyone you know.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(5, 'Some people have gotten angry and thrown their device when I told them their future, Are you an angry device thrower?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(6, 'Everything comes to pass, even the future. Why are you in such a hurry?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(7, 'If I tell you the future, and I&amp;m wrong, will you be mad?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(8, 'Are you strong enough to handle your future?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(9, 'Outlook for your future is uncertain')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(10, 'Shake me some more so that I can see that better')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(11, 'Sometimes, the future happens, and then it is in the past')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(12, 'I see an F, a U, a T, a U, an R, and an E as parts of your future.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(13, 'Ooof, you shook me too much! Now I&amp;m all wonky.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(14, 'Who needs a magic 8-ball when you&amp;ve got smiley-iPhone-guy?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(15, 'Are you sure you can handle knowing the future?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(16, 'See, I worry about your health. It may not be good for you to know your future.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(17, 'Ask me again in the future.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(18, 'You have a nice device here you know. Could use a few more fun apps though.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(19, 'If I look like I&amp;m frowning it&amp;s probably because you have me upside down.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(20, 'If you look at me closely my eyes look like bowling balls, or so I&amp;ve been told.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(21, 'Do you really think a silly little app like me can really tell you the future?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(22, 'If you had a newer device, I probably could have told you your future. But with what you have, there&amp;s nothing I can do.')" UTF8String], NULL, NULL, NULL);
//   res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(23, 'Turn me five times then shake me again for the truth about your future.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(24, 'Turn your head to the side, how does your future look now?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(25, 'Downloading future from server…. please wait.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(26, 'Error downloading future, please try again later.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(27, 'The future is an additional purchase. Can you afford it?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(28, 'The future is entirely in your hands. Haha! Made you look!')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(29, 'The future is entirely in your hands. Go wash your hands dude!')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(30, 'The future is entirely in your hands. Ewww, get your future-dirty hands off me!')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(31, 'The future is what you make of it. Even a simple little app like me knows it.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(32, 'I have some very complicated code that helps me peel back the fog of the future.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(33, 'Your future is not carved in stone. Wood? Maybe, Stone? No, not so much.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(34, 'I wonder if your future would look different if I was an iPad app instead of an iPhone. Maybe it would look bigger?')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(35, 'Your future looks very bright, might want to pack some shades.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(36, 'Su futuro se ve muy claro. Er, sorry, wrong continent!')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(37, 'Your future is very hot, might want to pack a bottle of water.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(38, 'In the past, your future was the present.')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(39, 'When you shake me, I tell you your future. You shake me harder, I tell you more. You shake me too hard, you break your iPad!')" UTF8String], NULL, NULL, NULL);
//    res = sqlite3_exec(database, [@"INSERT INTO PHRASES VALUES(40, 'You can change your future, just make sure to shake me often for it.')" UTF8String], NULL, NULL, NULL);
    
    
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
