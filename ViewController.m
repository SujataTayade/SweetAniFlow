//
//  ViewController.m
//  MapLocation
//
//  Created by Sujata Tayade on 05/07/16.
//  Copyright © 2016 Sujata Tayade. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@import GoogleMaps;
@interface ViewController () <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    GMSMapView *mapView_;
    GMSMarker *marker;
}


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    else
    {
        [locationManager startUpdatingLocation]; //Will update location immediately
    }
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:18.53
                                                            longitude:73.84
                                                                 zoom:5];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    marker = [[GMSMarker alloc] init];
    
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"User still thinking..");
        }break;
        case kCLAuthorizationStatusDenied:
        {
            NSLog(@"User hates you");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
        {
//              [locationManager performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:10.0];
            [locationManager startUpdatingLocation];
        } break;
        default:
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location = [locations lastObject];
    marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    marker.title = @"Shivaji Nagar";
    marker.snippet = @"India";
    marker.map = mapView_;
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
