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
-(void)uploadFtp:(NSString *)filePath{
    //为url添加后缀
    self.url = CFBridgingRelease(CFURLCreateCopyAppendingPathComponent(NULL, (CFURLRef)self.url, (CFStringRef)[filePath lastPathComponent], false));
    //读取文件转化为输入流
    self.fileStream = [NSInputStream inputStreamWithFileAtPath:filePath];
    [self.fileStream open];
    //为url开启CFFTPStream输出流
    CFWriteStreamRef ftpStream = CFWriteStreamCreateWithFTPURL(NULL, (__bridge CFURLRef)self.url);
    self.networkStream = (__bridge NSOutputStream * )ftpStream;
    //设置ftp账号,密码
    [self.networkStream setProperty:self.account forKey:(id)kCFStreamPropertyFTPUserName];
    [self.networkStream setProperty:self.password forKey:(id)kCFStreamPropertyFTPPassword];
    //设置network流代理,任何关于networkStream的时间都会调用代理方法
    self.networkStream.delegate = self;
    //设置runloop
    [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.networkStream open];
}
-(void)uploadFtpMoreFiles{
    [self uploadFtp:self.filePaths[0]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"ftp" object:nil];
}
- (void)InfoNotificationAction:(NSNotification *)notification{
    i++;
    [self uploadFtp:self.filePaths[i]];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    //aStream 即为设置为代理的networkStream
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            NSLog(@"NSStreamEventOpenCompleted");
            //            [aStream open];
        } break;
        case NSStreamEventHasBytesAvailable: {
            NSLog(@"NSStreamEventHasBytesAvailable");
            assert(NO);     // 在上传的时候不会调用
        } break;
        case NSStreamEventHasSpaceAvailable: {
            NSLog(@"NSStreamEventHasSpaceAvailable");
            NSLog(@"bufferOffset is %zd",self.bufferOffset);
            NSLog(@"bufferLimit is %zu",self.bufferLimit);
            if (self.bufferOffset == self.bufferLimit) {
                NSInteger   bytesRead;
                bytesRead = [self.fileStream read:self.buffer maxLength:kSendBufferSize];
                
                if (bytesRead == -1) {
                    //读取文件错误
                    [self _stopSendWithStatus:@"读取文件错误"];
                } else if (bytesRead == 0) {
                    //文件读取完成 上传完成
                    [self _stopSendWithStatus:nil];
                } else {
                    self.bufferOffset = 0;
                    self.bufferLimit  = bytesRead;
                }
            }
            
            if (self.bufferOffset != self.bufferLimit) {
                //写入数据
                NSInteger bytesWritten;//bytesWritten为成功写入的数据
                bytesWritten = [self.networkStream write:&self.buffer[self.bufferOffset] maxLength:self.bufferLimit - self.bufferOffset];
                assert(bytesWritten != 0);
                if (bytesWritten == -1) {
                    [self _stopSendWithStatus:@"网络写入错误"];
                } else {
                    self.bufferOffset += bytesWritten;
                }
            }
        }
            break;
        case NSStreamEventErrorOccurred: {
            [self _stopSendWithStatus:@"Stream打开错误"];
            assert(NO);
        } break;
        case NSStreamEventEndEncountered: {
            // 忽略
        } break;
        default: {
            assert(NO);
        } break;
    }
}
//结果处理
- (void)_stopSendWithStatus:(NSString *)statusString
{
    if (self.networkStream != nil) {
        [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.networkStream.delegate = nil;
        [self.networkStream close];
        self.networkStream = nil;
    }
    if (self.fileStream != nil) {
        [self.fileStream close];
        self.fileStream = nil;
    }
    [self _sendDidStopWithStatus:statusString];
}

- (void)_sendDidStopWithStatus:(NSString *)statusString
{
    if (statusString == nil) {
        statusString = @"上传成功";
        //发送上传成功的通知
        NSNotification *notification = [NSNotification notificationWithName:@"ftp" object:nil];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
    }
    NSLog(@"%@",statusString);
    
}

















@end
