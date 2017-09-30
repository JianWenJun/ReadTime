#import "WPFontManager.h"
#import "WPSharedLoggingPrivate.h"
#import <CoreText/CoreText.h>

@implementation WPFontManager

static NSString * const SharedBundle = @"WordPress-iOS-Shared.bundle";
static NSString * const FontTypeTTF = @"ttf";
static NSString * const FontTypeOTF = @"otf";

#pragma mark - System Fonts

+ (UIFont *)systemLightFontOfSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightLight];
}

+ (UIFont *)systemItalicFontOfSize:(CGFloat)size
{
    return [UIFont italicSystemFontOfSize:size];
}

+ (UIFont *)systemBoldFontOfSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightBold];
}

+ (UIFont *)systemSemiBoldFontOfSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightSemibold];
}

+ (UIFont *)systemRegularFontOfSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
}

#pragma mark - Noto Fonts

static NSString* const NotoBoldFontName = @"NotoSerif-Bold";
static NSString* const NotoBoldFileName = @"NotoSerif-Bold";
static NSString* const NotoBoldItalicFontName = @"NotoSerif-BoldItalic";
static NSString* const NotoBoldItalicFileName = @"NotoSerif-BoldItalic";
static NSString* const NotoItalicFontName = @"NotoSerif-Italic";
static NSString* const NotoItalicFileName = @"NotoSerif-Italic";
static NSString* const NotoRegularFontName = @"NotoSerif";
static NSString* const NotoRegularFileName = @"NotoSerif-Regular";

+ (void)loadNotoFontFamily
{
    [self loadFontResourceNamed:NotoBoldFontName withExtension:FontTypeTTF];
    [self loadFontResourceNamed:NotoBoldItalicFontName withExtension:FontTypeTTF];
    [self loadFontResourceNamed:NotoItalicFontName withExtension:FontTypeTTF];
    [self loadFontResourceNamed:NotoRegularFontName withExtension:FontTypeTTF];
}

+ (UIFont *)notoBoldFontOfSize:(CGFloat)size
{
    return [self fontNamed:NotoBoldFontName resourceName:NotoBoldFileName fontType:FontTypeTTF size:size];
}

+ (UIFont *)notoBoldItalicFontOfSize:(CGFloat)size;
{
    return [self fontNamed:NotoBoldItalicFontName resourceName:NotoBoldItalicFileName fontType:FontTypeTTF size:size];
}

+ (UIFont *)notoItalicFontOfSize:(CGFloat)size;
{
    return [self fontNamed:NotoItalicFontName resourceName:NotoItalicFileName fontType:FontTypeTTF size:size];
}

+ (UIFont *)notoRegularFontOfSize:(CGFloat)size
{
    return [self fontNamed:NotoRegularFontName resourceName:NotoRegularFileName fontType:FontTypeTTF size:size];
}

#pragma mark - Merryweather Fonts

+ (UIFont *)merriweatherBoldFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"Merriweather-Bold";
    NSString *fontName = @"Merriweather-Bold";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)merriweatherBoldItalicFontOfSize:(CGFloat)size;
{
    NSString *resourceName = @"Merriweather-BoldItalic";
    NSString *fontName = @"Merriweather-BoldItalic";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)merriweatherItalicFontOfSize:(CGFloat)size;
{
    NSString *resourceName = @"Merriweather-Italic";
    NSString *fontName = @"Merriweather-Italic";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)merriweatherLightFontOfSize:(CGFloat)size;
{
    NSString *resourceName = @"Merriweather-Light";
    NSString *fontName = @"Merriweather-Light";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)merriweatherLightItalicFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"Merriweather-LightItalic";
    NSString *fontName = @"Merriweather-LightItalic";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)merriweatherRegularFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"Merriweather-Regular";
    NSString *fontName = @"Merriweather";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}
#pragma mark - Open Sans Fonts

+ (UIFont *)openSansLightFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"OpenSans-Light";
    NSString *fontName = @"OpenSans-Light";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)openSansItalicFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"OpenSans-Italic";
    NSString *fontName = @"OpenSans-Italic";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)openSansLightItalicFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"OpenSans-LightItalic";
    NSString *fontName = @"OpenSans-LightItalic";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)openSansBoldFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"OpenSans-Bold";
    NSString *fontName = @"OpenSans-Bold";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)openSansBoldItalicFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"OpenSans-BoldItalic";
    NSString *fontName = @"OpenSans-BoldItalic";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)openSansSemiBoldFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"OpenSans-Semibold";
    NSString *fontName = @"OpenSans-Semibold";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)openSansSemiBoldItalicFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"OpenSans-SemiboldItalic";
    NSString *fontName = @"OpenSans-SemiboldItalic";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}

+ (UIFont *)openSansRegularFontOfSize:(CGFloat)size
{
    NSString *resourceName = @"OpenSans-Regular";
    NSString *fontName = @"OpenSans";
    return [self fontNamed:fontName resourceName:resourceName fontType:FontTypeTTF size:size];
}


#pragma mark - Private Methods

+ (UIFont *)fontNamed:(NSString *)fontName resourceName:(NSString *)resourceName fontType:(NSString *)fontType size:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (!font) {
        [[self class] loadFontResourceNamed:resourceName withExtension:fontType];
        font = [UIFont fontWithName:fontName size:size];

        // safe fallback
        if (!font) {
            font = [UIFont systemFontOfSize:size];
        }
    }

    return font;
}

+ (void)loadFontResourceNamed:(NSString *)name withExtension:(NSString *)extension
{
    NSString *resourceName = [NSString stringWithFormat:@"%@/%@", SharedBundle, name];
    NSURL *url = [[NSBundle bundleForClass:self] URLForResource:resourceName withExtension:extension];

    CFErrorRef error;
    if (!CTFontManagerRegisterFontsForURL((CFURLRef)url, kCTFontManagerScopeProcess, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        DDLogError(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
    }

    return;
}

@end
