//
//  Album.m
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "Album.h"

@implementation Album
- (id)initWithTitle:(NSString *)title artist:(NSString *)artist  coverUrl:(NSString *)coverUrl year:(NSString *)year {

    self =  [super init];
    if (self) {
        _title = title;
        _artist = artist;
        _converUrl = coverUrl;
        _year = year;
        _genre = @"Pop";
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.year forKey:@"year"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.artist forKey:@"artist"];
    [aCoder encodeObject:self.converUrl forKey:@"converUrl"];
    [aCoder encodeObject:self.genre forKey:@"genre"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super init]) {
        _year = [aDecoder decodeObjectForKey:@"year"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _artist = [aDecoder decodeObjectForKey:@"artist"];
        _converUrl = [aDecoder decodeObjectForKey:@"converUrl"];
        _genre = [aDecoder decodeObjectForKey:@"genre"];
    }
    return self;
}
@end
