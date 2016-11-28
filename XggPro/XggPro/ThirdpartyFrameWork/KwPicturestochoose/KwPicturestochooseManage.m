//
//  KwPicturestochooseManage.m
//  KinWind
//
//  Created by Baird-weng on 16/6/22.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "KwPicturestochooseManage.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "XGGHeader.h"
@interface KwPicturestochooseManage()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,CLLocationManagerDelegate>{
    NSMutableArray *_itemsArray;
    NSInteger _CurrentCont;
    BOOL _isFullimage;
    KWimageType _imageType;
    CLLocation *_currentLocation;
}
@property(nonatomic,strong)resultArray KWimageresultarray;
@property (nonatomic, strong)CLLocationManager  *locationManager;
@end
@implementation KwPicturestochooseManage
+ (instancetype)sharedManager{
    static KwPicturestochooseManage *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc]init];
    });
    return manager;
}
-(void)PickerControllerSourceTypeCamera:(KWimageType)type withTarget:(id)Target withEditor:(BOOL)editor withresult:(resultArray)result withError:(resultError)errorDic{
    _imageType = type;
    self.KWimageresultarray = result;
    if (![self isFrontCameraAvailable]) {
        errorDic(@{@"error":@"相机不可用"});
    }
    else{
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        [[controller navigationBar] setTintColor:[UIColor whiteColor]];
        NSDictionary * attriBute = @{NSForegroundColorAttributeName:NAVIGARIONBTITLECOLOR,NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:17]};
        [[controller navigationBar] setTitleTextAttributes:attriBute];
        controller.delegate = self;
        controller.allowsEditing = editor;
        UIViewController *ViewController = (UIViewController *)Target;
        [ViewController presentViewController:controller animated:YES completion:nil];
        //获取经纬度。
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10;
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0){
            //设置定位权限 仅ios8有意义
            [_locationManager requestAlwaysAuthorization];// 前后台同时定位
        }
        [self.locationManager startUpdatingLocation];
    }
}
#pragma mark 地理位置的错误信息。
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
        UIAlertView *AlertView = [[UIAlertView alloc]initWithTitle:@"未能获取定位授权" message:@"请打开设置-隐私-定位服务-亲云健康开启允许访问位置信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [AlertView show];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        UIAlertView *AlertView = [[UIAlertView alloc]initWithTitle:@"未能获取定位" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [AlertView show];
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    _currentLocation = [locations lastObject];
    [self.locationManager stopUpdatingLocation];
}
-(void)PickerControllerSourceTypePhotoLibrary:(KWimageType)type withTarget:(id)Target withEditor:(BOOL)editor withresult:(resultArray)result{
    self.KWimageresultarray = result;
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    [[controller navigationBar] setTintColor:[UIColor whiteColor]];
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:NAVIGARIONBTITLECOLOR,NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:17]};
    [[controller navigationBar] setTitleTextAttributes:attriBute];
    controller.delegate = self;
    controller.videoQuality=UIImagePickerControllerQualityTypeLow;
    controller.allowsEditing = editor;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIViewController *ViewController = (UIViewController *)Target;
    [ViewController presentViewController:controller animated:YES completion:nil];
}
-(void)PickerControllerSourceTypePhotoLibraryselectedAssets:(NSMutableArray *)Assets withTarget:(id)Target withresult:(resultArray)result{
    self.KWimageresultarray = result;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.selectedAssets = Assets;
    __weak typeof(self)WeakSelf = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto){
        if (_itemsArray == nil) {
            _itemsArray = [[NSMutableArray alloc]init];
        }
        [_itemsArray removeAllObjects];
        for (int i = 0; i<[assets count]; i++){
            NSString *AssetIdentifier = [[TZImageManager manager]getAssetIdentifier:assets[i]];
            Kwpicturemodel *picturemodel = [[Kwpicturemodel alloc]init];
            picturemodel.AssetIdentifier = AssetIdentifier;
            picturemodel.Picassets = assets[i];
            [_itemsArray addObject:picturemodel];
            //测试代码
            [self didLoadImagePicassets:picturemodel.Picassets];
        }
        WeakSelf.KWimageresultarray(_itemsArray);
    }];
    
    UIViewController *ViewController = (UIViewController *)Target;
    [ViewController presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *portraitImg = [info objectForKey:UIImagePickerControllerEditedImage];
    if (portraitImg == nil) {
        portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    portraitImg = [self fixOrientation:portraitImg];
    Kwpicturemodel *picturemodel = [[Kwpicturemodel alloc]init];
    picturemodel.photo = portraitImg;
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        NSDictionary *MediaMetadata = info[UIImagePickerControllerMediaMetadata];
        if (MediaMetadata){
            NSMutableDictionary *MediaMetadataExif =  [[NSMutableDictionary alloc]initWithDictionary:MediaMetadata[@"{Exif}"]];
            if (_currentLocation) {
                NSDictionary *GPS = @{@"Lat":[NSString stringWithFormat:@"%f",_currentLocation.coordinate.latitude],
                                      @"Lon":[NSString stringWithFormat:@"%f",_currentLocation.coordinate.longitude]};
                [MediaMetadataExif setObject:GPS forKey:@"GPS"];
            }
            picturemodel.exifInfo = MediaMetadataExif;
            picturemodel.original_time = [NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970]];
        }
    }
    if (picturemodel) {
        self.KWimageresultarray(@[picturemodel]);
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [[UINavigationBar appearance] setBarTintColor:NAVIGARIONBLACKCOLOR];
    }];
}
- (BOOL)isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
-(UIImage *)fixOrientation:(UIImage *)aImage{
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//测试代码
-(void)didLoadImagePicassets:(id)sset{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.networkAccessAllowed = YES;
    PHImageManager *manager = [PHImageManager defaultManager];
    option.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *infwo) {
    };
//    NSDate* date = [asset valueForProperty:ALAssetPropertyDate];
    
    [manager requestImageDataForAsset:sset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info){
        NSLog(@"info==================%@",info);

        CGImageSourceRef imgSource = CGImageSourceCreateWithData((CFDataRef)imageData, nil);
        CFDictionaryRef imageInfo = CGImageSourceCopyPropertiesAtIndex(imgSource, 0, NULL);
        NSLog(@"imageInfo==================%@",imageInfo);
    }];
}
@end
