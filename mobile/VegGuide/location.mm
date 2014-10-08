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
    NSLog(@"loactions %@", locations);
    //NSLog(@"%d, %d", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    [manager stopUpdatingLocation];
}

    - (void)locationManager:(CLLocationManager *)manager
           didFailWithError:(NSError *)error {

        DEBUG;
    }

@end

Location::Location(QQuickItem *parent) :
    QQuickItem(parent),
    m_delegate([[Locator alloc] initWithObject:this])
{
    DEBUG;
//    [m_delegate startUpdating];

}

void Location::requestAlwaysAuthorization()
{
    DEBUG;
    CLLocationManager *mgr = [[CLLocationManager alloc] init];
    [mgr requestAlwaysAuthorization];
//    [mgr setDelegate:(id)m_delegate];
//    [mgr setDistanceFilter:kCLDistanceFilterNone];
//    [mgr setDesiredAccuracy:kCLLocationAccuracyBest];
    //    [mgr startUpdatingLocation];
}

void Location::requestWhenInUseAuthorization()
{
    DEBUG;
    CLLocationManager *mgr = [[CLLocationManager alloc] init];
    [mgr requestWhenInUseAuthorization];
}
