#include <Foundation/Foundation.h>
#include <MobileCoreServices/MobileCoreServices.h>
#include <CoreLocation/CoreLocation.h>
#include "location.h"


@interface Locator : NSObject<CLLocationManagerDelegate> {
    Location *m_object;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@end

@implementation Locator

- (id) initWithObject:(Location *)obj
{
    self = [super init];
    if (self) {
        m_object = obj;
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    DEBUG;
    //    currentLocation = [locations objectAtIndex:0];
    NSLog(@"locations %@", locations);
    //NSLog(@"%d, %d", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    [manager stopUpdatingLocation];
    if([locations count] == 0) return;
    CLLocation *_location = locations[0];
    m_object->setLatitude(_location.coordinate.latitude);
    m_object->setLongitude(_location.coordinate.longitude);
    __block NSString *cityName = @"";
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:locations[0] completionHandler:^(NSArray *placemarks, NSError *error) {
        DEBUG << error.description;
        cityName = ([placemarks count] > 0) ? [[placemarks objectAtIndex:0] locality] : @"";
        DEBUG << cityName;
        m_object->setCityName(QString::fromNSString(cityName));
    }];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    DEBUG;
    Q_UNUSED(manager);
    Q_UNUSED(error);
}

@end

Location::Location(QQuickItem *parent) :
QQuickItem(parent),
m_delegate([[Locator alloc] initWithObject:this])
{
    DEBUG;
    
}

void Location::requestAlwaysAuthorization()
{
    DEBUG;
    CLLocationManager *mgr = [[CLLocationManager alloc] init];
    [mgr requestAlwaysAuthorization];
    [mgr setDelegate:(id)m_delegate];
    [mgr setDistanceFilter:kCLDistanceFilterNone];
    [mgr setDesiredAccuracy:kCLLocationAccuracyBest];
    [mgr startUpdatingLocation];
}

void Location::requestWhenInUseAuthorization()
{
    DEBUG;
    CLLocationManager *mgr = [[CLLocationManager alloc] init];
    [mgr requestWhenInUseAuthorization];
}
