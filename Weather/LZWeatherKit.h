//
//  LZWeatherKit.h
//  Weather
//
//  Created by Latham Zhao on 1/5/14.
//  Copyright (c) 2014 Latham Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZWeatherKit : NSObject
@property (copy, nonatomic)NSString *features;
@property (copy, nonatomic)NSString *settings;
@property (copy, nonatomic)NSString *query;
@property (copy, nonatomic)NSString *format;

- (NSDictionary *)getWeatherInfoFromWeatherUnderground:(NSString *)features settings:(NSString *)settings query:(NSString *)query format:(NSString *)format apiKey:(NSString *)apiKey;
@end
