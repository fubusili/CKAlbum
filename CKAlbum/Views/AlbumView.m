//
//  AlbumView.m
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "AlbumView.h"

@implementation AlbumView
{
    UIImageView *coverImage;
    UIActivityIndicatorView *indicator;

}

- (id)initWithFrame:(CGRect)frame albumCover:(NSString *)albumCover {

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // the coverImage has a 5 pixels margin from its frame
        coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10)];
        [self addSubview:coverImage];
        
        indicator = [[UIActivityIndicatorView alloc] init];
        indicator.center = self.center;
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [indicator startAnimating];
        [self addSubview:indicator];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CKDownloadImageNotification" object:nil userInfo:@{@"imageView":coverImage,@"coverUrl":albumCover}];
    }
    return self;
}

@end
