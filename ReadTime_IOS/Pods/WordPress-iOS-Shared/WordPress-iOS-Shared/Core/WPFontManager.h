#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface WPFontManager : NSObject

+ (UIFont *)systemLightFontOfSize:(CGFloat)size;
+ (UIFont *)systemItalicFontOfSize:(CGFloat)size;
+ (UIFont *)systemBoldFontOfSize:(CGFloat)size;
+ (UIFont *)systemSemiBoldFontOfSize:(CGFloat)size;
+ (UIFont *)systemRegularFontOfSize:(CGFloat)size;

/// Loads the Noto font family for the life of the current process.
/// This effectively makes it possible to look this font up using font descriptors.
///
+ (void)loadNotoFontFamily;
+ (UIFont *)notoBoldFontOfSize:(CGFloat)size;
+ (UIFont *)notoBoldItalicFontOfSize:(CGFloat)size;
+ (UIFont *)notoItalicFontOfSize:(CGFloat)size;
+ (UIFont *)notoRegularFontOfSize:(CGFloat)size;

+ (UIFont *)merriweatherBoldFontOfSize:(CGFloat)size;
+ (UIFont *)merriweatherBoldItalicFontOfSize:(CGFloat)size;
+ (UIFont *)merriweatherItalicFontOfSize:(CGFloat)size;
+ (UIFont *)merriweatherLightFontOfSize:(CGFloat)size;
+ (UIFont *)merriweatherLightItalicFontOfSize:(CGFloat)size;
+ (UIFont *)merriweatherRegularFontOfSize:(CGFloat)size;


+ (UIFont *)openSansLightFontOfSize:(CGFloat)size __deprecated_msg("Use systemLightFontOfSize instead");
+ (UIFont *)openSansItalicFontOfSize:(CGFloat)size __deprecated_msg("Use systemItalicFontOfSize instead");
+ (UIFont *)openSansLightItalicFontOfSize:(CGFloat)size __deprecated_msg("Use systemLightItalicFontOfSize instead");
+ (UIFont *)openSansBoldFontOfSize:(CGFloat)size __deprecated_msg("Use systemBoldFontOfSize instead");
+ (UIFont *)openSansBoldItalicFontOfSize:(CGFloat)size __deprecated_msg("Use systemBoldItalicFontOfSize instead");
+ (UIFont *)openSansSemiBoldFontOfSize:(CGFloat)size __deprecated_msg("Use systemSemiBoldFontOfSize instead");
+ (UIFont *)openSansSemiBoldItalicFontOfSize:(CGFloat)size __deprecated_msg("Use systemSemiBoldItalicFontOfSize instead");
+ (UIFont *)openSansRegularFontOfSize:(CGFloat)size __deprecated_msg("Use systemRegularFontOfSize instead");
@end

NS_ASSUME_NONNULL_END
