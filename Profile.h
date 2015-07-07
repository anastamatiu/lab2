//
//  Profile.h
//  Places
//
//  Created by iOS4 on 07/07/15.
//  Copyright (c) 2015 StamatiuAna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Profile : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) UIImage *photo;

@end
