//
//  Position Manager.h
//  Places
//
//  Created by Ana on 7/10/15.
//  Copyright (c) 2015 StamatiuAna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationProtocol;


@interface Position_Manager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) id<LocationProtocol> delegate;
- (void)requestLocation;
+ (Position_Manager *)sharedInstance;
@end

@protocol LocationProtocol
- (void) getCurrentLocation: (CLLocation *) currentLocation;
@end