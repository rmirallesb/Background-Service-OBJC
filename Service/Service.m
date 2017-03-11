//
//  Service.m
//  Background-Service-OBJC
//
//  Created by Raúl on 11/3/17.
//

#import "Service.h"

@implementation Service
@synthesize     frequency;

- (id)initWithFrequency: (NSInteger) seconds {
    if (self            = [super init]) {
        self.frequency  = seconds;
        return self;
    }
    return nil;
}

- (void)startService {
    [self startBackgroundTask];
}

- (void)stopService {
    [self.updateTimer invalidate];
    self.updateTimer    = nil;
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTask];
    self.backgroundTask = UIBackgroundTaskInvalid;
}

- (void)startBackgroundTask {
    self.updateTimer    = [NSTimer scheduledTimerWithTimeInterval:frequency
                                                           target:self
                                                         selector:@selector(doInBackground)
                                                         userInfo:nil
                                                          repeats:YES];
    self.backgroundTask = [[UIApplication sharedApplication]
                           beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundTask];
    }];
}

- (void)endBackgroundTask {
    [self.updateTimer invalidate];
    self.updateTimer    = nil;
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTask];
    self.backgroundTask = UIBackgroundTaskInvalid;
    [self startBackgroundTask];
}

@end
