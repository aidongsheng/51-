//
//  GlobalUtil.m
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/8/29.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import "ZbCoreUtil.h"
#import "CommonCrypto/CommonDigest.h"
#import "sys/utsname.h"
#import "Masonry.h"


UIViewController *zbcore_topViewController(UIViewController *vc){
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return zbcore_topViewController([(UINavigationController *)vc topViewController]) ;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return zbcore_topViewController([(UITabBarController *)vc selectedViewController]);
    } else {
        return vc;
    }
    return nil;
}
/**
 获取当前正在显示的控制器
 */
UIViewController *zbcore_currentController(){
    UIViewController *resultVC;
    resultVC = zbcore_topViewController([[UIApplication sharedApplication].keyWindow rootViewController]);
    while (resultVC.presentedViewController) {
        resultVC = zbcore_topViewController(resultVC.presentedViewController);
    }
    return resultVC;
}




@implementation NSString (ZbCoreExpand)
#pragma mark 加密
+(NSString *)zbcore_md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];//转换成utf-8
    
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    
    /*
     
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     
     */
    
    return [NSString stringWithFormat:
            
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
    
    /*
     
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     
     debug_NSLog("%02X", 0x888);  //888
     
     debug_NSLog("%02X", 0x4); //04
     
     */
    
}

-(BOOL)zbcore_checkPhoneNumInput{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+(NSString *)zbcore_dictToString:(NSDictionary*)dict{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)zbcore_textFromBase64String:(NSString *)base64{
    
    if (base64 && ![base64 isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [NSData zbcore_dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return @"";
    }
}

@end

@implementation NSData (ZbCoreMD5)

+(NSData *)zbcore_MD5Digest:(NSData *)input {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(input.bytes, (unsigned int)input.length, result);
    return [[NSData alloc] initWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

-(NSData *)zbcore_MD5Digest {
    return [NSData zbcore_MD5Digest:self];
}

+(NSString *)zbcore_MD5HexDigest:(NSData *)input {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(input.bytes, (unsigned int)input.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

-(NSString *)zbcore_MD5HexDigest {
    return [NSData zbcore_MD5HexDigest:self];
}

@end

@implementation NSData (ZbCoreUtils)
- (NSString *)zbcore_detectImageSuffix
{
    uint8_t c;
    NSString *imageFormat = @"";
    [self getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            imageFormat = @".jpg";
            break;
        case 0x89:
            imageFormat = @".png";
            break;
        case 0x47:
            imageFormat = @".gif";
            break;
        case 0x49:
        case 0x4D:
            imageFormat = @".tiff";
            break;
        case 0x42:
            imageFormat = @".bmp";
            break;
        default:
            break;
    }
    return imageFormat;
}

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+ (NSData*)zbcore_dataWithBase64EncodedString:(NSString*)string{
    if (string == nil)
#pragma clang diagnostic push
        
#pragma clang diagnostic ignored"-Wnonnull"
        
        [NSException raise:NSInvalidArgumentException format:nil];
    
#pragma clang diagnostic pop
    
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

@end
#define HEXDIGEST_LENGTH(x)     (x * 2)

typedef unsigned char* (*CC_DIGEST)(const void*, CC_LONG, unsigned char*);

static NSData* digest(NSData *data, CC_DIGEST digest, CC_LONG digestLength)
{
    unsigned char md[digestLength];
    (void)digest([data bytes], (CC_LONG)[data length], md);
    return [NSData dataWithBytes:md length:digestLength];
}

@implementation NSData (ZbCoreSha256)

- (NSData *)sha256
{
    return digest(self, CC_SHA256, CC_SHA256_DIGEST_LENGTH);
}

- (NSString *)hex
{
    NSInteger len = [self length];
    char hex[HEXDIGEST_LENGTH(len) + 1];
    unsigned char *buf = (unsigned char *)[self bytes];
    
    for (int i = 0; i < len; i++) {
        sprintf(hex + i * 2, "%02x", buf[i]);
    }
    hex[HEXDIGEST_LENGTH(len)] = '\0';
    return [NSString stringWithCString:hex encoding:NSASCIIStringEncoding];
}

@end


@implementation NSString (ZbCoreSha256)
- (NSString *)sha256
{
    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    return [[data sha256] hex];
}

@end

#pragma mark UIView线条绘制
@implementation UIView (ZbCoreUtils)
/**
 画线
 
 @param lineColor 线条颜色
 @param block     mas设置
 */
- (UIView *)zbcore_drawLine: (UIColor *)lineColor
                   masBlock: (void(^)(MASConstraintMaker *make))block;{
    UIView *lineView = [UIView new];
    lineView.backgroundColor = lineColor;
    [self addSubview: lineView];
    [lineView mas_makeConstraints: block];
    return lineView;
}
/**
 画线
 
 @param lineColor 线条颜色
 @param superView 父视图
 @param block     mas设置
 */
+ (UIView *)zbcore_drawLine: (UIColor *)lineColor
                     inView: (UIView *)superView
                   masBlock: (void(^)(MASConstraintMaker *make))block;{
    return [superView zbcore_drawLine: lineColor masBlock: block];
}
@end
#pragma mark Util方法
@implementation ZbCoreUtil
+ (NSString*)zbcore_deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}

+(CGSize)zbcore_resolutionSize
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    //分辨率
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    width = width*scale_screen;
    height = height*scale_screen;
    return CGSizeMake(width, height);
}
/**
 *  过滤html标签
 *
 *  @param html 要过滤的html
 *
 *  @return 结果
 */
+ (NSString *)zbcore_filterHTML:(NSString *)html{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    
    /**
     *  过滤相关指定内容
     */
    NSString *regStr = @"(<STYLE>){1}([\\s\\S]*)(</STYLE>){1}";
    NSRange range = [html rangeOfString: regStr options: NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    while (range.location != NSNotFound) {
        html = [html stringByReplacingCharactersInRange: range withString: @""];
        range = [html rangeOfString: regStr options: NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    }
    
    /**
     *  设置换行
     */
    regStr = @"(<{1})(P){1}([^>]*)(>{1})";
    range = [html rangeOfString: regStr options: NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    while (range.location != NSNotFound) {
        html = [html stringByReplacingCharactersInRange: range withString: @""];
        range = [html rangeOfString: regStr options: NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    }
    regStr = @"(<{1}/{1})(P){1}([^>]*)(>{1})";
    range = [html rangeOfString: regStr options: NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    while (range.location != NSNotFound) {
        html = [html stringByReplacingCharactersInRange: range withString: @"<br />"];
        range = [html rangeOfString: regStr options: NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    }
    html = [html stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    
    while([scanner isAtEnd]==NO){
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString: [NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    html = [html stringByReplacingOccurrencesOfString: @"&nbsp;" withString: @" "];
    scanner = [NSScanner scannerWithString: html];
    text = nil;
    while([scanner isAtEnd]==NO){
        //找到标签的起始位置
        [scanner scanUpToString:@"&" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@";" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString: [NSString stringWithFormat:@"%@;",text] withString:@""];
    }
    
    //    return [html stringByReplacingOccurrencesOfString: @"&nbsp;" withString: @" "];
    return html;
}
@end
