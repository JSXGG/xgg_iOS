//
//  Kwpicturemodel.h
//  KinWind
//
//  Created by Baird-weng on 16/6/29.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Kwpicturemodel : NSObject
@property(nonatomic,strong)id Picassets;
@property(nonatomic,strong)NSString *AssetIdentifier;
@property(nonatomic,strong)UIImage *photo;
@property(nonatomic,strong)NSDictionary *exifInfo;
@property(nonatomic,strong)NSString *original_time;//照片的创建时间。
@end
