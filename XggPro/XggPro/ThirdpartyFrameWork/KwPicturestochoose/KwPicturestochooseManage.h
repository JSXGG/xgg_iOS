//
//  KwPicturestochooseManage.h
//  KinWind
//
//  Created by Baird-weng on 16/6/22.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "Kwpicturemodel.h"
typedef NS_ENUM(NSInteger, KWimageType) {
    KWimageTypeSingle = 0,//获取单张图片。
    KWimageTypeMore,//多张图片。
    KWimageTypeGetPHAsset,//返回相片PHAsset对象。
};
typedef void (^resultArray)(NSArray<Kwpicturemodel *> *picArray);

typedef void (^resultError)(NSDictionary *dic);

@interface KwPicturestochooseManage : NSObject
+(instancetype)sharedManager;
-(void)PickerControllerSourceTypeCamera:(KWimageType)type withTarget:(id)Target withEditor:(BOOL)editor withresult:(resultArray)result withError:(resultError)errorDic;
-(void)PickerControllerSourceTypePhotoLibrary:(KWimageType)type withTarget:(id)Target withEditor:(BOOL)editor withresult:(resultArray)result;
//图片多选。
-(void)PickerControllerSourceTypePhotoLibraryselectedAssets:(NSMutableArray *)Assets withTarget:(id)Target withresult:(resultArray)result;
//修复图片方向
-(UIImage *)fixOrientation:(UIImage *)aImage;
@end
