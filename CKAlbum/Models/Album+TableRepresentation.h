//
//  Album+TableRepresentation.h
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "Album.h"

@interface Album (TableRepresentation)
- (NSDictionary *)tr_tableRepresentation;
@end
