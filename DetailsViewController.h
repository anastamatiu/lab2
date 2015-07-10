//
//  DetailsViewController.h
//  Places
//
//  Created by Ana on 7/10/15.
//  Copyright (c) 2015 StamatiuAna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@import GoogleMaps;

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) GMSPlace *place;

@end
