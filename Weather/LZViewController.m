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
@interface LZViewController ()

@end

@implementation LZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    if ([self didDatabaseExist]) {
        LZWeatherItem *item1 = [self getItemFromDatabase];
        [self setDisplay:item1];
    }
    NSString *code = [self getLocationCode];
    NSDictionary *weatherDic = [self getWeatherWithCityCode:code];
    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
    [self saveDataToDatabaseWithWeatherInfo:weatherInfo];
    LZWeatherItem *item2 = [self getItemFromDatabase];
    [self setDisplay:item2];

}

- (NSString *)getLocationCode{
    NSURLRequest *requestToGetLocationCode = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://61.4.185.48:81/g/"]];
    NSData *responseWithLocationCode = [NSURLConnection sendSynchronousRequest:requestToGetLocationCode returningResponse:nil error:nil];
    NSString *locationString = [[NSString alloc]initWithData:responseWithLocationCode encoding:NSUTF8StringEncoding];
    NSString *codeid = @"var id=";
    NSRange range = [locationString rangeOfString:codeid];
    range.location += 7;
    range.length = 9;
    NSString *code = [locationString substringWithRange:range];
    NSLog(@"get citycode successfully");
    return code;
    
}
- (NSDictionary *)getWeatherWithCityCode:(NSString *)code{
    NSError *error;
    NSMutableString *weatherURL = [[NSMutableString alloc]initWithString:@"http://m.weather.com.cn/data/"];
    [weatherURL appendString:code];
    [weatherURL appendString:@".html"];
    NSURLRequest *requestWeatherinfo = [NSURLRequest requestWithURL:[NSURL URLWithString:weatherURL]];
    NSData *responseWithWeatherInfo = [NSURLConnection sendSynchronousRequest:requestWeatherinfo returningResponse:nil error:nil];
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:responseWithWeatherInfo options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"get weatherInfo with citycode successfully");
    return weatherDic;
    
}

- (void)saveDataToDatabaseWithWeatherInfo:(NSDictionary *)weatherInfo{
        
    LZWeatherItem *item = [self setWeatherItemWithWeatherInfo:weatherInfo];
    NSString *dbPath = [self getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return;
    }
    if (![self didTableExist:db :@"WeatherInfo"]) {
        [db executeUpdate:@"CREATE TABLE WeatherInfo (cityname,citycode,temp,wind,weather,date_y,week,fchh)"];
        NSLog(@"creat TABLE WeatherInfo");
    }
    [db executeUpdate:@"INSERT INTO WeatherInfo (cityname,citycode,temp,wind,weather,date_y,week,fchh) VALUES (?,?,?,?,?,?,?,?)",item.cityname,item.citycode,item.temp,item.wind,item.weather,item.date_y,item.week,item.fchh];
    [db close];
    NSLog(@"save date to database successfullly");
}

- (LZWeatherItem *)getItemFromDatabase{
    NSString *dbPath = [self getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return 0;
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM WeatherInfo"];
    LZWeatherItem *item = [LZWeatherItem new];
    while ([rs next]) {
        
        item.cityname = [rs stringForColumn:@"cityname"];
        item.citycode = [rs stringForColumn:@"citycode"];
        item.temp = [rs stringForColumn:@"temp"];
        item.wind = [rs stringForColumn:@"wind"];
        item.weather = [rs stringForColumn:@"weather"];
        item.date_y = [rs stringForColumn:@"date_y"];
        item.week = [rs stringForColumn:@"week"];
        item.fchh = [rs stringForColumn:@"fchh"];
    }
    [db close];
    NSLog(@"get item from database successfully");

    return item;
    }

- (void)setDisplay:(LZWeatherItem *)item{
    self.citylabel.text = item.cityname;
    self.templabel.text = item.temp;
    self.date_ylabel.text = item.date_y;
    self.fchhlabel.text = item.fchh;
    NSLog(@"Display has been Set/Reset");
}

- (LZWeatherItem *)setWeatherItemWithWeatherInfo:(NSDictionary *)weatherInfo{
    LZWeatherItem *item = [LZWeatherItem new];
    item.cityname = [weatherInfo objectForKey:@"city"];
    item.citycode = [weatherInfo objectForKey:@"cityid"];
    item.temp = [weatherInfo objectForKey:@"temp1"];
    item.wind = [weatherInfo objectForKey:@"wind1"];
    item.weather = [weatherInfo objectForKey:@"weather1"];
    item.date_y = [weatherInfo objectForKey:@"date_y"];
    item.week = [weatherInfo objectForKey:@"week"];
    item.fchh = [weatherInfo objectForKey:@"fchh"];
    NSLog(@"set weather item with weatherInfo finished");
    return item;
    
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

- (BOOL)didTableExist:(FMDatabase *)db:(NSString *)tableName{
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
