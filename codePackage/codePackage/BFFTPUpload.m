//
//  BFFTPUpload.m
//  codePackage
//
//  Created by 周冰烽 on 2017/7/5.
//  Copyright © 2017年 周冰烽. All rights reserved.
//

#import "BFFTPUpload.h"

@interface BFFTPUpload()

/*内部变量*/
@property(nonatomic, readonly) BOOL isSending;
@property(nonatomic,retain)NSOutputStream *networkStream;
@property(nonatomic,retain)NSInputStream *fileStream;
@property(nonatomic,readonly)uint8_t *buffer;
@property(nonatomic,assign)size_t bufferOffset;
@property(nonatomic,assign)size_t bufferLimit;

@end



@implementation BFFTPUpload
-(uint8_t *)buffer{
    return self->_buffer;
}
-(void)uploadFtp{
    
}

@end
