//
//  HTTPClient.m
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient
- (id)getRequest:(NSString *)url {

    return nil;
}

- (id)postRequest:(NSString *)url body:(NSString *)body {

    return nil;
}

- (UIImage *)downloadImage:(NSString *)url {

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [UIImage imageWithData:data];
}
@end
