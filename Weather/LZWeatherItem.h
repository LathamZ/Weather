//
//  LZWeatherItem.h
//  Weather
//
//  Created by Latham Zhao on 1/4/14.
//  Copyright (c) 2014 Latham Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZWeatherItem : NSObject
@property (copy,nonatomic) NSString *city;
@property (copy,nonatomic) NSString *temp_c;
@property (copy,nonatomic) NSString *temp_h0;
@property (copy,nonatomic) NSString *temp_l0;
@property (copy,nonatomic) NSString *temp_h1;
@property (copy,nonatomic) NSString *temp_l1;
@property (copy,nonatomic) NSString *temp_h2;
@property (copy,nonatomic) NSString *temp_l2;
@property (copy,nonatomic) NSString *temp_h3;
@property (copy,nonatomic) NSString *temp_l3;
@property (copy,nonatomic) NSString *wind_dir;
@property (copy,nonatomic) NSString *wind_kph;
@property (copy,nonatomic) NSString *weather;
@property (copy,nonatomic) NSString *weekday0;
@property (copy,nonatomic) NSString *weekday1;
@property (copy,nonatomic) NSString *weekday2;
@property (copy,nonatomic) NSString *weekday3;
@property (copy,nonatomic) NSString *date;
@property (copy,nonatomic) NSString *year0;
@property (copy,nonatomic) NSString *month0;
@property (copy,nonatomic) NSString *date0;
@property (copy,nonatomic) NSString *relative_humidity;
@property (copy,nonatomic) NSString *visibility_km;
@property (copy,nonatomic) NSString *icon_url0;
@property (copy,nonatomic) NSString *icon_url1;
@property (copy,nonatomic) NSString *icon_url2;
@property (copy,nonatomic) NSString *icon_url3;

@end
