//
//  Service.h
//  Background-Service-OBJC
//
//  Created by Raúl on 11/3/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ServiceDelegate <NSObject>

- (void)drawServiceRepeats;

@end

@interface Service : NSObject

@property (nonatomic,weak)      id <ServiceDelegate>         delegate;
@property (nonatomic)           UIBackgroundTaskIdentifier   backgroundTask;
@property (nonatomic)           NSInteger                    frequency;
@property (nonatomic, strong)   NSTimer *updateTimer;

- (id)   initWithFrequency:(NSInteger)seconds;
- (void) startService;
- (void) stopService;

@end
