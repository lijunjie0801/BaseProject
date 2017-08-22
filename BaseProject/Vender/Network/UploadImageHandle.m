////
////  UploadImageHandle.m
////
////  Created by mac on 16/3/7.
////  Copyright © 2016年 DingGouBai. All rights reserved.
////
//
//#import "UploadImageHandle.h"
////#import "ZYQAssetPickerController.h"
//#import <UIKit/UIKit.h>
//@interface UploadImageHandle()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate>
//@property (nonatomic,strong) UIImagePickerController *imagePicker;
//@property (nonatomic,strong) SuccessBlock successBlock;
//@property (nonatomic,strong) FailureBlock failureBlock;
//@property (nonatomic,assign) NSInteger maxUploadNumber;
//@end
//
//@implementation UploadImageHandle
//DEFINE_SINGLETON_FOR_CLASS(UploadImageHandle)
//
//
//
//- (UIImagePickerController *)imagePicker
//{
//    if (!_imagePicker) {
//        _imagePicker = [[UIImagePickerController alloc] init];
//        _imagePicker.allowsEditing = YES;
//        _imagePicker.delegate = self;
//    }
//    
//    return _imagePicker;
//}
//
//
//- (void)uploadImageWithMaxSelectNumber:(NSInteger)number Sucess:(SuccessBlock)sucess Failure:(FailureBlock)failure
//{
//    if (number) {
//        self.maxUploadNumber =number;
//    }else{
//        self.maxUploadNumber = 1;
//    }
//    if (sucess) {
//        self.successBlock = sucess;
//    }
//    
//    if (failure) {
//        self.failureBlock = failure;
//    }
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
//    [sheet showInView:[[UIApplication sharedApplication] keyWindow]];
//    
//    
//}
//
//#pragma mark - UIActionSheetDelegate
//
//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    
//    switch (buttonIndex) {
//        case 0:
//            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])//相机
//            {
//                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//                self.imagePicker.allowsEditing = NO;
//                [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:self.imagePicker animated:YES completion:nil];
//            }else{
//                
//                
//                if (self.failureBlock) {
//                    self.failureBlock(@"该设备不支持相机!");
//                }
//                [CToast showWithText:@"该设备不支持相机!" duration:3];
//            }
//            break;
//        case 1:
//            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
//            {
//                
//                
//                    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
//                    picker.maximumNumberOfSelection = self.maxUploadNumber;
//                    picker.assetsFilter = [ALAssetsFilter allPhotos];
//                    picker.showEmptyGroups = NO;
//                    picker.delegate = self;
//                    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
//                        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
//                            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
//                            return duration >= 5;
//                        } else {
//                            return YES;
//                        }
//                    }];
//                    
//                    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:picker animated:YES completion:NULL];
//                
//            }else{
//                if (self.failureBlock) {
//                    self.failureBlock(@"该设备不支持相册选择!");
//                }
//                [CToast showWithText:@"该设备不支持相册选择!" duration:3];
//            }
//            break;
//            
//        default:
//            break;
//    }
//
//    
//}
//
//
//#pragma mark - UIImagePickerControllerDelegate
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//    UIImage *image = [self fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]];
//   // UIImage *image = info[UIImagePickerControllerOriginalImage];
//    image = [self fixOrientation:image];
//    if (self.successBlock) {
//        self.successBlock(@[image]);
//    }
//
//}
//
//#pragma mark - ZYQAssetPickerController Delegate
//-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
//    
//
//    if (assets.count) {
//        
//        NSMutableArray *imageArrayM = [NSMutableArray array];
//        
//        for (int i=0; i<assets.count; i++) {
//            ALAsset *asset=assets[i];
//            
//            UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//             tempImg = [self fixOrientation:tempImg];
//            if (tempImg) {
//                [imageArrayM addObject:tempImg];
//            }
//        }
//        
//        if (imageArrayM.count) {
//            if (self.successBlock) {
//                self.successBlock(imageArrayM);
//            }
//        }
//    }
//
//    
//}
//
//-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker
//{
//
//    [CToast showWithText:[NSString stringWithFormat:@"最多可以选择%ld张!",(long)self.maxUploadNumber] duration:3];
//
//}
//- (UIImage *)fixOrientation:(UIImage *)aImage {
//    
//    // No-op if the orientation is already correct
//    if (aImage.imageOrientation == UIImageOrientationUp)
//        return aImage;
//    
//    // We need to calculate the proper transformation to make the image upright.
//    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    
//    switch (aImage.imageOrientation) {
//        case UIImageOrientationDown:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
//            transform = CGAffineTransformRotate(transform, M_PI);
//            break;
//            
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
//            transform = CGAffineTransformRotate(transform, M_PI_2);
//            break;
//            
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
//            transform = CGAffineTransformRotate(transform, -M_PI_2);
//            break;
//        default:
//            break;
//    }
//    
//    switch (aImage.imageOrientation) {
//        case UIImageOrientationUpMirrored:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//            
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//        default:
//            break;
//    }
//    
//    // Now we draw the underlying CGImage into a new context, applying the transform
//    // calculated above.
//    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
//                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
//                                             CGImageGetColorSpace(aImage.CGImage),
//                                             CGImageGetBitmapInfo(aImage.CGImage));
//    CGContextConcatCTM(ctx, transform);
//    switch (aImage.imageOrientation) {
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            // Grr...
//            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
//            break;
//            
//        default:
//            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
//            break;
//    }
//    
//    // And now we just create a new UIImage from the drawing context
//    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
//    UIImage *img = [UIImage imageWithCGImage:cgimg];
//    CGContextRelease(ctx);
//    CGImageRelease(cgimg);
//    return img;
//}
//
//
//
//
//@end
