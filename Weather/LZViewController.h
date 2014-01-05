//
//  LZViewController.h
//  Weather
//
//  Created by Latham Zhao on 1/4/14.
//  Copyright (c) 2014 Latham Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *temp_c;
@property (weak, nonatomic) IBOutlet UILabel *temp_h0;
@property (weak, nonatomic) IBOutlet UILabel *temp_l0;

@property (weak, nonatomic) IBOutlet UILabel *temp_h1;
@property (weak, nonatomic) IBOutlet UILabel *temp_l1;

@property (weak, nonatomic) IBOutlet UILabel *temp_h2;
@property (weak, nonatomic) IBOutlet UILabel *temp_l2;



@property (weak, nonatomic) IBOutlet UILabel *temp_h3;
@property (weak, nonatomic) IBOutlet UILabel *temp_l3;


@property (weak, nonatomic) IBOutlet UILabel *weather;
@property (weak, nonatomic) IBOutlet UILabel *relative_humidity;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *wind_dir;
@property (weak, nonatomic) IBOutlet UILabel *wind_kph;
@property (weak, nonatomic) IBOutlet UILabel *visibility_km;
@property (weak, nonatomic) IBOutlet UILabel *weekday0;
@property (weak, nonatomic) IBOutlet UILabel *weekday1;
@property (weak, nonatomic) IBOutlet UILabel *weekday2;
@property (weak, nonatomic) IBOutlet UILabel *weekday3;
@property (weak, nonatomic) IBOutlet UIImageView *weather_icon0;
@property (weak, nonatomic) IBOutlet UIImageView *weather_icon1;
@property (weak, nonatomic) IBOutlet UIImageView *weather_icon2;
@property (weak, nonatomic) IBOutlet UIImageView *weather_icon3;

@end
