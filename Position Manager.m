//
//  Position Manager.m
//  Places
//
//  Created by Ana on 7/10/15.
//  Copyright (c) 2015 StamatiuAna. All rights reserved.
//

#import "Position Manager.h"

@implementation Position_Manager

+ (Position_Manager *)sharedInstance
{
    static Position_Manager *_sharedInstance = nil;
    
    if(_sharedInstance == nil)
    {
        _sharedInstance = [[Position_Manager alloc] init];
    }
    return _sharedInstance;
}

- (void)requestLocation
{
    if(self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
    }

    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    [self.delegate getCurrentLocation:locations.lastObject];
}

@end
