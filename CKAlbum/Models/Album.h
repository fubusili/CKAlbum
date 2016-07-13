//
//  Album.h
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject <NSCoding>
@property (nonatomic, copy, readonly) NSString *title, *artist, *genre, *converUrl, *year;
- (id)initWithTitle:(NSString *)title artist:(NSString *)artist  coverUrl:(NSString *)coverUrl year:(NSString *)year;
@end
