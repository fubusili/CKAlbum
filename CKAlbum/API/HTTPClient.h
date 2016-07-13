//
//  HTTPClient.h
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTTPClient : NSObject
- (id)getRequest:(NSString *)url;
- (id)postRequest:(NSString *)url body:(NSString *)body;
- (UIImage *)downloadImage:(NSString *)url;
@end
