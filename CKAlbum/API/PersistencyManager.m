//
//  PersistencyManager.m
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "PersistencyManager.h"

@interface PersistencyManager ()
{
    // an array of all albums
    NSMutableArray *albums;
}
@end

@implementation PersistencyManager

- (id)init {

    if (self = [super init]) {
        // adummy list of albums
        NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Document/albums.bin"]];
        albums = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (albums == nil) {
            
            NSArray *array = @[@[@"Best of Bowie", @"It's My Life", @"Nothing Like The Sun", @"Staring at the Sun", @"American Pie"], @[@"David Bowie", @"No Doubt", @"Sting", @"U2", @"Madonna"], @[@"http://b.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=34df70af2e34349b600b66d7a8837eab/94cad1c8a786c9176eccc38ccf3d70cf3ac757b3.jpg", @"http://tu.23356.com/pic/m300/album/2012/12/07/63490491125991604709476450.jpg", @"http://www.coversproject.com/static/thumbs/album/album_sting_nothing%20like%20the%20sun.png", @"http://www.coversproject.com/static/thumbs/album/album_u2_staring%20at%20the%20sun.png", @"http://g.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=86d4df6952e736d14c1e845afa3924a7/9f510fb30f2442a7e7e96c10d743ad4bd013029b.jpg"], @[@"2009", @"2013", @"2015", @"2016"]];
            albums = [NSMutableArray arrayWithObjects:[self getStringWithArray:array atIndex:0], [self getStringWithArray:array atIndex:1], [self getStringWithArray:array atIndex:2], [self getStringWithArray:array atIndex:3], nil];
        }
        /*
        albums = [NSMutableArray arrayWithArray:@[[[Album alloc] initWithTitle:@"Best of Bowie" artist:@"David Bowie" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_david%20bowie_best%20of%20bowie.png" year:@"1992"],
                                                  [[Album alloc] initWithTitle:@"It's My Life" artist:@"No Doubt" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_no%20doubt_its%20my%20life%20%20bathwater.png" year:@"2003"],
                                                  [[Album alloc] initWithTitle:@"Nothing Like The Sun" artist:@"Sting" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_sting_nothing%20like%20the%20sun.png" year:@"1999"],
                                                  [[Album alloc] initWithTitle:@"Staring at the Sun" artist:@"U2" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_u2_staring%20at%20the%20sun.png" year:@"2000"],
                                                  [[Album alloc] initWithTitle:@"American Pie" artist:@"Madonna" coverUrl:@"http://b.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=34df70af2e34349b600b66d7a8837eab/94cad1c8a786c9176eccc38ccf3d70cf3ac757b3.jpg" year:@"2000"]]];
         */
    }
    return self;
}

#pragma mark - public methods 

- (NSArray *)getAlbums {

    return albums;
}

- (void)addAlbum:(Album *)album atIndex:(int)index {

    if (albums.count >= index) {
        [albums insertObject:albums atIndex:index];
    } else {
    
        [albums addObject:album];
    }
}

- (void)deleteAlbumAtIndex:(int)index {

    [albums removeObjectAtIndex:index];
}

#pragma mark - private methods

- (NSString *)getStringWithArray:(NSArray *)array atIndex:(int)index {

    return (NSString *)[[Album alloc] initWithTitle:array[0][index] artist:array[1][index] coverUrl:array[2][index] year:array[3][index]];
}

- (void)saveImage:(UIImage *)image filename:(NSString *)filename {

    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",filename];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [data writeToFile:filename atomically:YES];
    
}

- (UIImage *)getImage:(NSString *)filename {

    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}

- (void)saveAlbums {

    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Document/albums.bin"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:albums];
    NSError *error;
    BOOL success = [data writeToFile:filename options:0 error:&error];
    if (!success) {
        NSLog(@"writeToFile failed with error %@", error);
    }
}

@end
