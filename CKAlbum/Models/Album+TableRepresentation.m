//
//  Album+TableRepresentation.m
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "Album+TableRepresentation.h"

@implementation Album (TableRepresentation)
- (NSDictionary *)tr_tableRepresentation {

    return @{@"titles":@[@"Artist", @"Album", @"Genre", @"Year"], @"values":@[self.artist, self.title, self.genre, self.year]};
}
@end
