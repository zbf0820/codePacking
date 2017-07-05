//
//  BFFTPUpload.h
//  codePackage
//
//  Created by 周冰烽 on 2017/7/5.
//  Copyright © 2017年 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>
enum {
    kSendBufferSize = 32678
};

@interface BFFTPUpload : NSObject<NSStreamDelegate>{
    uint8_t _buffer[kSendBufferSize];
}
/*必须填写*/

/*ftp服务器地址*/
@property(nonatomic,strong)NSURL *url;
/*账号*/
@property(nonatomic,copy)NSString *account;
/*密码*/
@property(nonatomic,copy)NSString *password;
/*文件路径*/
@property(nonatomic,copy)NSString *filePath;

/*上传方法*/
-(void)uploadFtp;

@end
