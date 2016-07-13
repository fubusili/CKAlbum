//
//  LibraryAPI.m
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "LibraryAPI.h"
#import "PersistencyManager.h"
#import "HTTPClient.h"

@interface LibraryAPI ()
{
    PersistencyManager *persistercyManager;
    HTTPClient *httpClient;
    BOOL isOnline;
}
@end

@implementation LibraryAPI


#pragma mark - life cycle

- (id)init {

    if (self = [super init]) {
        persistercyManager = [[PersistencyManager alloc] init];
        httpClient = [[HTTPClient alloc] init];
        isOnline = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"CKDownloadImageNotification" object:nil];
    }
    return self;
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

#pragma mark - public methods

+ (LibraryAPI *)sharedInstance {

    // 1
    static LibraryAPI *sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[LibraryAPI alloc] init];
    });
    return sharedInstance;
}

- (void)downloadImage:(NSNotification *)notification {

    // 1
    UIImageView  *imageView = notification.userInfo[@"imageView"];
    NSString *coverUrl = notification.userInfo[@"coverUrl"];
    
    // 2
    imageView.image = [persistercyManager getImage:[coverUrl lastPathComponent]];
    
    // 3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [httpClient downloadImage:coverUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
           
            imageView.image = image;
            [persistercyManager saveImage:image filename:[coverUrl lastPathComponent]];
        });
    });
    
}

- (NSArray *)getAlbums {

    return [persistercyManager getAlbums];
}

- (void)addAlbum:(Album *)album atIndex:(int)index {

    [persistercyManager addAlbum:album atIndex:index];
    if (isOnline) {
        [httpClient postRequest:@"/api/addAlbum" body:[album description]];
    }
}

- (void)deleteAlbumAtIndex:(int)index {

    [persistercyManager deleteAlbumAtIndex:index];
    if (isOnline) {
        [httpClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
    }
}
- (void)saveAlbums {

    [persistercyManager saveAlbums];
}

@end
