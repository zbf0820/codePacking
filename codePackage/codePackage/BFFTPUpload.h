//
//  BFFTPUpload.h
//  codePackage
//
//  Created by 周冰烽 on 2017/7/5.
//  Copyright © 2017年 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

static int i = 0;

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
///*文件路径*/
//@property(nonatomic,copy)NSString *filePath;
/*文件路劲数组*/
@property(nonatomic,copy)NSArray *filePaths;

/*
 上传方法
 单次上传:必须填写url,account,password和filePath

 
 */
-(void)uploadFtp:(NSString *)filePath;
/* 多次上传:必须填写url,account,password和filePaths,并且调用名称为ftp的通知 */
-(void)uploadFtpMoreFiles;

@end
