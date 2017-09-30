//
//  FileModel.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property (nonatomic, copy)NSString* bucket;
@property (nonatomic,copy)NSString* createdAt;
@property (nonatomic, copy)NSString* name;
@property (nonatomic,copy)NSString* objectId;
@property (nonatomic, copy)NSString* size;
@property (nonatomic,copy)NSString* url;

@end
