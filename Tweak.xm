#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

%ctor {
    //Get the process name
    NSString *processName = NSProcessInfo.processInfo.processName;
    if (![processName isEqualToString:@"SpringBoard"]) {
        
        //Listen for when an application opens 
        [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *notification) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                UIApplication *application = notification.object;

                __weak UIViewController *rootViewController = application.keyWindow.rootViewController;
                if ([rootViewController isKindOfClass:UINavigationController.class]) {
                    rootViewController = ((UINavigationController *)rootViewController).viewControllers.firstObject;
                } else if ([rootViewController isKindOfClass:UITabBarController.class]) {
                    rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
                } else if (rootViewController.presentedViewController) {
                    rootViewController = rootViewController.presentedViewController;
                }
                
                //Get UserDefaults for the running process
                NSString *userDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] description];

                //Display an alert message when the app opens, but not when AirDrop is present
                //Reason: its annoying to have this pop up when trying to share, but there might
                //be a reason why would want to know Airdrops Userdefaults..
                if (![processName isEqualToString:@"AirDrop"]) {
                    NSString *alertMessage = [NSString stringWithFormat:@"Would you like to view NSUserDefaults for %@?", processName];
                    UIAlertController *alert = [%c(UIAlertController) alertControllerWithTitle:@"" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                        
                        //Share a .txt file, converting to a .json file requres writing data to the file system 
                        UIActivityViewController *activityCtr = [[UIActivityViewController alloc] initWithActivityItems:@[userDefaults] applicationActivities:nil];
                        [rootViewController presentViewController:activityCtr animated:YES completion:nil];
                    }]];

                    [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
                    [rootViewController presentViewController:alert animated:YES completion:nil];
                }
            });
        }];
    }
}