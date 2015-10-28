//
//  Utils.m
//  ImageViewer2
//
//  Created by Ni Yan on 10/27/15.
//  Copyright © 2015 Ni Yan. All rights reserved.
//

#import "Utils.h"
#import <Foundation/Foundation.h>

@implementation Utils

+ (NSMutableArray *) getImages
{
    NSMutableArray * images = [NSMutableArray new];
    
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/9c/0f/e1/9c0fe176ef1f226b24731eb146a3dbac.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/e1/88/c6/e188c6f590a8efec480a89aa43a0fcc5.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/df/16/14/df1614ff36e7a2e8074edc289f183079.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/35/c8/c3/35c8c38bc204c5a4b120e860b00931e6.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/77/cc/a6/77cca60231114f05314c985f1a837f78.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/06/20/90/0620905d435affd71631d65d83e258ae.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/72/0a/db/720adb486511f15ebbd709e56bb5e78c.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/fa/47/7a/fa477a4ecb40aabebb0e4ec1f68c235a.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/d9/f9/59/d9f95927b520d97315e06d318a8d9aad.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/a9/43/e1/a943e14e62ee54a80304c522d13c3c32.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/da/cf/c2/dacfc26accb61c9bcb38ccd8385a606a.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/1f/e3/bf/1fe3bfb69634587faecdf7491d897692.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/9a/8a/51/9a8a51e1ecc2c671169b4ddfc6412cca.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/56/b5/cf/56b5cf7705c32b711ad4098185a1a8a2.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/bb/83/39/bb83391215023c097a39d25394f53e10.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/10/90/9e/10909e8be81baa477803eb37b26a2576.jpg"]];
    [images addObject: [self getImageByUrl: @"http://media-cache-ec2.pinimg.com/550x/ac/35/70/ac3570ec141074f7ab1f1ef03e385082.jpg"]];

    return images;
}

+ (UIImage *) getImageByUrl: (NSString *) url
{
    url = [url stringByReplacingOccurrencesOfString: @"http://" withString: @"https://"];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    
    UIImage * image;
    if (imageData.length > 0)
    {
        image = [UIImage imageWithData: imageData];
    }
    else
    {
        image = [UIImage imageNamed: @"placeholder.png"];
    }
    return image;
}

+ (void)addBorderToImage: (UIImageView *) imageView withColor: (UIColor *) color borderWidth: (float) width
{
    
    //add border
    [imageView.layer setBorderColor: [color CGColor]];
    [imageView.layer setBorderWidth: width];
    
}

+ (NSInteger) findClosestCellIndex: (CGPoint) touchPoint to: (NSArray *) attributesArray
{
    float minDistance = 500.0; //set it to a big number
    NSInteger cellIndex = 0;
    
    for (UICollectionViewLayoutAttributes * attributes in attributesArray)
    {
        CGPoint centerOfAttributes =  CGPointMake(attributes.frame.origin.x + (attributes.frame.size.width / 2), attributes.frame.origin.y + (attributes.frame.size.height / 2));
        
        float distance = sqrt((touchPoint.x - centerOfAttributes.x) * (touchPoint.x - centerOfAttributes.x) + (touchPoint.y - centerOfAttributes.y) * (touchPoint.y - centerOfAttributes.y));
        
        if (distance <= minDistance)
        {
            minDistance = distance;
            cellIndex = attributes.indexPath.row;
        }
        
    }
    return cellIndex;
}


@end
