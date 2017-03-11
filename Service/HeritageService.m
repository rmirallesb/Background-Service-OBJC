//
//  HeritageService.m
//  Background-Service-OBJC
//
//  Created by Raúl on 11/3/17.
//

#import "HeritageService.h"

@implementation HeritageService

- (void) doInBackground{
    NSLog(@"Service execute");
    [self.delegate drawServiceRepeats];
}

@end
