//
//  LZWeatherItem.h
//  Weather
//
//  Created by Latham Zhao on 1/4/14.
//  Copyright (c) 2014 Latham Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZWeatherItem : NSObject
@property (copy,nonatomic) NSString *cityname;
@property (copy,nonatomic) NSString *citycode;
@property (copy,nonatomic) NSString *temp;
@property (copy,nonatomic) NSString *wind;
@property (copy,nonatomic) NSString *weather;
@property (copy,nonatomic) NSString *week;
@property (copy,nonatomic) NSString *date_y;
@property (copy,nonatomic) NSString *fchh;

@end
