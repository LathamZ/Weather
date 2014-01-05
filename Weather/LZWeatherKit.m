//
//  LZWeatherKit.m
//  Weather
//
//  Created by Latham Zhao on 1/5/14.
//  Copyright (c) 2014 Latham Zhao. All rights reserved.
//

#import "LZWeatherKit.h"

@implementation LZWeatherKit
- (NSDictionary *)getWeatherInfoFromWeatherUnderground:(NSString *)features settings:(NSString *)settings query:(NSString *)query format:(NSString *)format apiKey:(NSString *)apiKey{
    
    NSError *error;
    NSMutableString *weatherURL = [[NSMutableString alloc]initWithString:@"http://api.wunderground.com/api/"];
    [weatherURL appendString:[NSString stringWithFormat:@"%@/",apiKey]];
    [weatherURL appendString:[NSString stringWithFormat:@"%@/",features]];
    [weatherURL appendString:[NSString stringWithFormat:@"%@/",settings]];
    [weatherURL appendString:@"q/"];
    [weatherURL appendString:[NSString stringWithFormat:@"%@.",query]];
    [weatherURL appendString:format];
   
    NSURLRequest *requestWeatherinfo = [NSURLRequest requestWithURL:[NSURL URLWithString:weatherURL]];
    NSData *responseWithWeatherInfo = [NSURLConnection sendSynchronousRequest:requestWeatherinfo returningResponse:nil error:nil];
    NSDictionary *weatherInfo = [NSJSONSerialization JSONObjectWithData:responseWithWeatherInfo options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"get weatherInfo from WeatherUnderground successfully");
    return weatherInfo;
}
@end
