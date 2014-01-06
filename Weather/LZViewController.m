//
//  LZViewController.m
//  Weather
//
//  Created by Latham Zhao on 1/4/14.
//  Copyright (c) 2014 Latham Zhao. All rights reserved.
//

#import "LZViewController.h"
#import "FMDatabase.h"
#import "LZWeatherItem.h"
#import "LZWeatherKit.h"
@interface LZViewController ()

@end

@implementation LZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//    if ([self didDatabaseExist]) {
//        LZWeatherItem *item1 = [self getItemFromDatabase];
//        [self setDisplay:item1];
//    }else{
//        NSString *code = [self getLocationCode];
//        NSDictionary *weatherDic = [self getWeatherWithCityCode:code];
//        NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
//        [self saveDataToDatabaseWithWeatherInfo:weatherInfo];
//        LZWeatherItem *item2 = [self getItemFromDatabase];
//        [self setDisplay:item2];
//    }
  


}

- (void)viewDidAppear:(BOOL)animated{
    NSDictionary *weatherInfo = [self getWeatherFromWeatherUnderground];
    LZWeatherItem *item = [self setWeatherItemWithWeatherInfo:weatherInfo];
    [self setDisplay:item];
    
}

//- (NSString *)getLocationCode{
//    NSURLRequest *requestToGetLocationCode = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://61.4.185.48:81/g/"]];
//    NSData *responseWithLocationCode = [NSURLConnection sendSynchronousRequest:requestToGetLocationCode returningResponse:nil error:nil];
//    NSString *locationString = [[NSString alloc]initWithData:responseWithLocationCode encoding:NSUTF8StringEncoding];
//    NSString *codeid = @"var id=";
//    NSRange range = [locationString rangeOfString:codeid];
//    range.location += 7;
//    range.length = 9;
//    NSString *code = [locationString substringWithRange:range];
//    NSLog(@"get citycode successfully");
//    return code;
//    
//}
- (NSDictionary *)getWeatherFromWeatherUnderground{
     NSDictionary *weatherUnderground = [[LZWeatherKit alloc] getWeatherInfoFromWeatherUnderground:@"conditions/forecast" settings:@"lang:CN" query:@"autoip" format:@"json" apiKey:@"004778d36906ef56"];
    return weatherUnderground;
}

//- (void)saveDataToDatabaseWithWeatherInfo:(NSDictionary *)weatherInfo{
//        
//    LZWeatherItem *item = [self setWeatherItemWithWeatherInfo:weatherInfo];
//    NSString *dbPath = [self getDatabasePath];
//    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
//    if (![db open]) {
//        return;
//    }
//    if (![self didTableExist:db tableName:@"WeatherInfo"]) {
//        [db executeUpdate:@"CREATE TABLE WeatherInfo (cityname,citycode,temp,wind,weather,date_y,week,fchh)"];
//        NSLog(@"creat TABLE WeatherInfo");
//    }
//    [db executeUpdate:@"INSERT INTO WeatherInfo (cityname,citycode,temp,wind,weather,date_y,week,fchh) VALUES (?,?,?,?,?,?,?,?)",item.cityname,item.citycode,item.temp,item.wind,item.weather,item.date_y,item.week,item.fchh];
//    [db close];
//    NSLog(@"save date to database successfullly");
//}

//- (LZWeatherItem *)getItemFromDatabase{
//    NSString *dbPath = [self getDatabasePath];
//    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
//    if (![db open]) {
//        return 0;
//    }
//    FMResultSet *rs = [db executeQuery:@"SELECT * FROM WeatherInfo"];
//    LZWeatherItem *item = [LZWeatherItem new];
//    while ([rs next]) {
//        
//        item.cityname = [rs stringForColumn:@"cityname"];
//        item.citycode = [rs stringForColumn:@"citycode"];
//        item.temp = [rs stringForColumn:@"temp"];
//        item.wind = [rs stringForColumn:@"wind"];
//        item.weather = [rs stringForColumn:@"weather"];
//        item.date_y = [rs stringForColumn:@"date_y"];
//        item.week = [rs stringForColumn:@"week"];
//        item.fchh = [rs stringForColumn:@"fchh"];
//    }
//    [db close];
//    NSLog(@"get item from database successfully");
//
//    return item;
//    }

- (void)setDisplay:(LZWeatherItem *)item{
    self.city.text = item.city;
    self.temp_c.text = item.temp_c;
    self.temp_h0.text = item.temp_h0;
    self.temp_l0.text = item.temp_l0;
    self.temp_h1.text = item.temp_h1;
    self.temp_l1.text = item.temp_l1;
    self.temp_h2.text = item.temp_h2;
    self.temp_l2.text = item.temp_l2;
    self.temp_h3.text = item.temp_h3;
    self.temp_l3.text = item.temp_l3;
    self.weekday0.text = item.weekday0;
    self.weekday1.text = item.weekday1;
    self.weekday2.text = item.weekday2;
    self.weekday3.text = item.weekday3;
    self.weather.text = item.weather;
    self.date.text = item.date;
    self.wind_dir.text = item.wind_dir;
    self.wind_kph.text = item.wind_kph;
    self.visibility_km.text = item.visibility_km;
    self.relative_humidity.text = item.relative_humidity;
    self.weather_icon0.image = [self getImageFromURL:item.icon_url0];
    self.weather_icon1.image = [self getImageFromURL:item.icon_url1];
    self.weather_icon2.image = [self getImageFromURL:item.icon_url2];
    self.weather_icon3.image = [self getImageFromURL:item.icon_url3];
    
    NSLog(@"Display has been Set/Reset");
}

- (LZWeatherItem *)setWeatherItemWithWeatherInfo:(NSDictionary *)weatherInfo{
    LZWeatherItem *item = [LZWeatherItem new];

    NSDictionary *current_observation = [weatherInfo objectForKey:@"current_observation"];
    NSDictionary *display_location = [current_observation objectForKey:@"display_location"];
    NSDictionary *forecast = [weatherInfo objectForKey:@"forecast"];
    NSDictionary *simpleforecast = [forecast objectForKey:@"simpleforecast"];
    NSArray *forecastday = [simpleforecast objectForKey:@"forecastday"];

    NSDictionary *day0 = [forecastday objectAtIndex:0];
    NSDictionary *day1 = [forecastday objectAtIndex:1];
    NSDictionary *day2 = [forecastday objectAtIndex:2];
    NSDictionary *day3 = [forecastday objectAtIndex:3];
    
    NSDictionary *datedic0 = [day0 objectForKey:@"date"];
    NSDictionary *datedic1 = [day1 objectForKey:@"date"];
    NSDictionary *datedic2 = [day2 objectForKey:@"date"];
    NSDictionary *datedic3 = [day3 objectForKey:@"date"];
    
    NSDictionary *high0 = [day0 objectForKey:@"high"];
    NSDictionary *low0  = [day0 objectForKey:@"low"];
    NSDictionary *high1 = [day1 objectForKey:@"high"];
    NSDictionary *low1  = [day1 objectForKey:@"low"];
    NSDictionary *high2 = [day2 objectForKey:@"high"];
    NSDictionary *low2  = [day2 objectForKey:@"low"];
    NSDictionary *high3 = [day3 objectForKey:@"high"];
    NSDictionary *low3  = [day3 objectForKey:@"low"];
    
    
 
    
    item.city = [display_location objectForKey:@"city"];
    item.weather = [current_observation objectForKey:@"weather"];
    item.temp_c = [NSString stringWithFormat:@"%@",[current_observation objectForKey:@"temp_c"]];

    

    item.relative_humidity = [current_observation objectForKey:@"relative_humidity"];
    item.wind_dir = [current_observation objectForKey:@"wind_dir"];
    item.wind_kph = [NSString stringWithFormat:@"%@",[current_observation objectForKey:@"wind_kph"]];
    item.visibility_km = [current_observation objectForKey:@"visibility_km"];
    
    item.year0 = [datedic0 objectForKey:@"year"];
    item.month0 = [datedic0 objectForKey:@"month"];
    item.date0 = [datedic0 objectForKey:@"day"];
    item.date = [NSString stringWithFormat:@"%@年%@月%@日",item.year0,item.month0,item.date0];


    item.temp_h0 = [high0 objectForKey:@"celsius"];
    item.temp_l0 = [low0 objectForKey:@"celsius"];
    item.temp_h1 = [high1 objectForKey:@"celsius"];
    item.temp_l1 = [low1 objectForKey:@"celsius"];
    item.temp_h2 = [high2 objectForKey:@"celsius"];
    item.temp_l2 = [low2 objectForKey:@"celsius"];
    item.temp_h3 = [high3 objectForKey:@"celsius"];
    item.temp_l3 = [low3 objectForKey:@"celsius"];
    
    item.icon_url0 = [current_observation objectForKey:@"icon_url"];
    item.icon_url1 = [day1 objectForKey:@"icon_url"];
    item.icon_url2 = [day2 objectForKey:@"icon_url"];
    item.icon_url3 = [day3 objectForKey:@"icon_url"];
    
    item.weekday0 = [datedic0 objectForKey:@"weekday"];
    item.weekday1 = [datedic1 objectForKey:@"weekday"];
    item.weekday2 = [datedic2 objectForKey:@"weekday"];
    item.weekday3 = [datedic3 objectForKey:@"weekday"];
    
    NSLog(@"set weather item with weatherInfo finished");
    return item;
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

- (NSString *)getDatabasePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"WeatherInfoDatabase.db"];
    NSLog(@"get dbPath successfully");
    return dbPath;
    
}

- (BOOL)didDatabaseExist{
    NSString *dbPath = [self getDatabasePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPath]){
        NSLog(@"Database isn't exist");
        return NO;
    }else{
        NSLog(@"Database exist");
        return YES;
    }
}

- (BOOL)didTableExist:(FMDatabase *)db tableName:(NSString *)tableName{
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        if (0 == count)
        {
            NSLog(@"Table %@ isn't exist",tableName);
            return NO;
        }
        else
        {
            NSLog(@"Table %@ is exist",tableName);
            return YES;
        }
    }
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
