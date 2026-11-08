#import <UIKit/UIKit.h>
#import <sys/utsname.h>

static NSString * const kRYUMAEndpoint = @"https://ryuma-verify.ieuhehhehehehhrh.workers.dev";
static NSString * const kRYUMASasukeBase64 = @"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";

static UIWindow *gRYUMAWindow;
static BOOL gRYUMAShown = NO;
static BOOL gRYUMAValid = NO;
static BOOL gRYUMAVerifying = NO;

static NSString *RYUMADeviceName(void) {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machine = [NSString stringWithUTF8String:systemInfo.machine];
    NSDictionary *names = @{
        @"iPhone10,3":@"iPhone X", @"iPhone10,6":@"iPhone X",
        @"iPhone11,2":@"iPhone XS", @"iPhone11,4":@"iPhone XS Max",
        @"iPhone11,6":@"iPhone XS Max", @"iPhone11,8":@"iPhone XR",
        @"iPhone12,1":@"iPhone 11", @"iPhone12,3":@"iPhone 11 Pro",
        @"iPhone12,5":@"iPhone 11 Pro Max", @"iPhone13,2":@"iPhone 12",
        @"iPhone13,3":@"iPhone 12 Pro", @"iPhone13,4":@"iPhone 12 Pro Max",
        @"iPhone14,5":@"iPhone 13", @"iPhone14,2":@"iPhone 13 Pro",
        @"iPhone14,3":@"iPhone 13 Pro Max", @"iPhone14,7":@"iPhone 14",
        @"iPhone14,8":@"iPhone 14 Plus", @"iPhone15,2":@"iPhone 14 Pro",
        @"iPhone15,3":@"iPhone 14 Pro Max", @"iPhone15,4":@"iPhone 15",
        @"iPhone15,5":@"iPhone 15 Plus", @"iPhone16,1":@"iPhone 15 Pro",
        @"iPhone16,2":@"iPhone 15 Pro Max"
    };
    return names[machine] ?: UIDevice.currentDevice.model;
}

@interface RYUMAScreen : UIViewController
@property(nonatomic,strong) UIVisualEffectView *blurView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *subtitleLabel;
@property(nonatomic,strong) UILabel *detailLabel;
@property(nonatomic,strong) UIActivityIndicatorView *spinner;
@property(nonatomic,strong) UITextField *keyField;
@property(nonatomic,strong) UIButton *submitButton;
@property(nonatomic,strong) UIButton *pasteButton;
@property(nonatomic,strong) UILabel *statusLabel;
@property(nonatomic,strong) UIView *contentPanel;
- (void)showInitializing;
- (void)showWelcome;
- (void)showLogin;
- (void)showVerifiedWithStatus:(NSString *)status plan:(NSString *)plan expiresAt:(id)expiresAt;
@end

@implementation RYUMAScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.055 green:0.06 blue:0.065 alpha:1];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    self.blurView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.blurView];
    [NSLayoutConstraint activateConstraints:@[
        [self.blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.blurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.blurView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.blurView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];

    UIView *glow = [UIView new];
    glow.translatesAutoresizingMaskIntoConstraints = NO;
    glow.backgroundColor = [UIColor colorWithRed:0.12 green:0.22 blue:0.20 alpha:0.28];
    glow.layer.cornerRadius = 180;
    glow.layer.shadowColor = [UIColor colorWithRed:0.1 green:0.5 blue:0.35 alpha:1].CGColor;
    glow.layer.shadowRadius = 90;
    glow.layer.shadowOpacity = 0.45;
    [self.view addSubview:glow];
    [NSLayoutConstraint activateConstraints:@[
        [glow.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [glow.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [glow.widthAnchor constraintEqualToConstant:280],
        [glow.heightAnchor constraintEqualToConstant:280]
    ]];
}

- (UILabel *)label:(NSString *)text size:(CGFloat)size weight:(UIFontWeight)weight color:(UIColor *)color {
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size weight:weight];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    return label;
}


- (UIImage *)ryumaAutomaticAppIcon {
    NSDictionary *info = NSBundle.mainBundle.infoDictionary ?: @{};

    // Read the icon names declared by the IPA being injected.
    NSArray *iconFiles = nil;
    NSDictionary *icons = info[@"CFBundleIcons"];
    NSDictionary *primary = [icons[@"CFBundlePrimaryIcon"] isKindOfClass:NSDictionary.class]
        ? icons[@"CFBundlePrimaryIcon"] : nil;
    if ([primary[@"CFBundleIconFiles"] isKindOfClass:NSArray.class]) {
        iconFiles = primary[@"CFBundleIconFiles"];
    }

    // iPad-specific and legacy declarations are useful fallbacks.
    if (!iconFiles.count) {
        NSDictionary *ipadIcons = info[@"CFBundleIcons~ipad"];
        NSDictionary *ipadPrimary = [ipadIcons[@"CFBundlePrimaryIcon"] isKindOfClass:NSDictionary.class]
            ? ipadIcons[@"CFBundlePrimaryIcon"] : nil;
        if ([ipadPrimary[@"CFBundleIconFiles"] isKindOfClass:NSArray.class]) {
            iconFiles = ipadPrimary[@"CFBundleIconFiles"];
        }
    }
    if (!iconFiles.count && [info[@"CFBundleIconFiles"] isKindOfClass:NSArray.class]) {
        iconFiles = info[@"CFBundleIconFiles"];
    }

    // Try largest declared icon first. imageNamed also supports asset-catalog names.
    for (NSString *name in [iconFiles reverseObjectEnumerator]) {
        if (![name isKindOfClass:NSString.class] || name.length == 0) continue;
        UIImage *image = [UIImage imageNamed:name inBundle:NSBundle.mainBundle compatibleWithTraitCollection:nil];
        if (!image) {
            NSString *filePath = [NSBundle.mainBundle pathForResource:name ofType:nil];
            if (filePath) image = [UIImage imageWithContentsOfFile:filePath];
        }
        if (image) return image;
    }

    // Keep a visible fallback for IPA packages that do not declare icon files
    // in their Info.plist in a form UIKit can load.
    NSData *fallbackData = [[NSData alloc] initWithBase64EncodedString:kRYUMASasukeBase64 options:0];
    return fallbackData ? [UIImage imageWithData:fallbackData] : nil;
}

- (UIImageView *)ryumaLogoView {
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:kRYUMASasukeBase64 options:0];
    UIImage *image = imageData ? [UIImage imageWithData:imageData] : nil;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 24;
    imageView.layer.borderWidth = 2;
    imageView.layer.borderColor = [UIColor colorWithRed:0.18 green:0.48 blue:0.88 alpha:1].CGColor;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [imageView.widthAnchor constraintEqualToConstant:82],
        [imageView.heightAnchor constraintEqualToConstant:82]
    ]];
    return imageView;
}


- (UIImageView *)ryumaInjectedAppIconView {
    UIImage *icon = [self ryumaAutomaticAppIcon];
    UIImageView *view = [[UIImageView alloc] initWithImage:icon];
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 22;
    view.layer.borderWidth = 2;
    view.layer.borderColor = [UIColor colorWithRed:0.18 green:0.48 blue:0.88 alpha:1].CGColor;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [view.widthAnchor constraintEqualToConstant:92],
        [view.heightAnchor constraintEqualToConstant:92]
    ]];
    return view;
}

- (UIView *)ryumaInfoRowWithValue:(NSString *)value title:(NSString *)title valueColor:(UIColor *)valueColor {
    UIView *row = [UIView new];
    row.translatesAutoresizingMaskIntoConstraints = NO;
    UILabel *valueLabel = [self label:value size:18 weight:UIFontWeightSemibold color:valueColor];
    UILabel *titleLabel = [self label:title size:17 weight:UIFontWeightRegular color:[UIColor colorWithRed:0.72 green:0.78 blue:0.86 alpha:1]];
    valueLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textAlignment = NSTextAlignmentRight;
    [row addSubview:valueLabel];
    [row addSubview:titleLabel];
    [NSLayoutConstraint activateConstraints:@[
        [valueLabel.leadingAnchor constraintEqualToAnchor:row.leadingAnchor],
        [valueLabel.centerYAnchor constraintEqualToAnchor:row.centerYAnchor],
        [titleLabel.trailingAnchor constraintEqualToAnchor:row.trailingAnchor],
        [titleLabel.centerYAnchor constraintEqualToAnchor:row.centerYAnchor],
        [valueLabel.trailingAnchor constraintLessThanOrEqualToAnchor:titleLabel.leadingAnchor constant:-12],
        [row.heightAnchor constraintGreaterThanOrEqualToConstant:34]
    ]];
    return row;
}

- (UIButton *)button:(NSString *)title color:(UIColor *)color {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:19 weight:UIFontWeightSemibold];
    button.backgroundColor = color;
    button.layer.cornerRadius = 27;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    return button;
}

- (void)clearScreen {
    for (UIView *v in self.view.subviews) {
        if (v != self.blurView && ![v.backgroundColor isEqual:[UIColor colorWithRed:0.12 green:0.22 blue:0.20 alpha:0.28]]) [v removeFromSuperview];
    }
}

- (void)showInitializing {
    [self clearScreen];
    UIStackView *stack = [[UIStackView alloc] init];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.alignment = UIStackViewAlignmentCenter;
    stack.spacing = 24;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stack];

    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner startAnimating];
    UILabel *title = [self label:@"Package initializing" size:25 weight:UIFontWeightSemibold color:UIColor.whiteColor];
    [stack addArrangedSubview:spinner];
    [stack addArrangedSubview:title];
    [NSLayoutConstraint activateConstraints:@[
        [stack.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stack.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

- (void)showWelcome {
    [self clearScreen];
    UIStackView *stack = [UIStackView new];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.alignment = UIStackViewAlignmentCenter;
    stack.spacing = 17;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stack];

    UIImageView *appIcon = [self ryumaInjectedAppIconView];
    UILabel *brand = [self label:@"RYUMA" size:36 weight:UIFontWeightBold color:UIColor.whiteColor];
    UILabel *check = [self label:@"✓" size:76 weight:UIFontWeightLight color:[UIColor colorWithRed:0.22 green:0.82 blue:0.40 alpha:1]];
    UILabel *hi = [self label:@"Hi iPhone" size:25 weight:UIFontWeightSemibold color:[UIColor colorWithRed:0.22 green:0.82 blue:0.40 alpha:1]];
    NSString *details = [NSString stringWithFormat:@"Device: %@  |  iOS: %@\nRYUMA License System", RYUMADeviceName(), UIDevice.currentDevice.systemVersion];
    UILabel *info = [self label:details size:15 weight:UIFontWeightRegular color:[UIColor colorWithWhite:0.72 alpha:1]];
    [stack addArrangedSubview:appIcon];
    [stack addArrangedSubview:brand];
    [stack addArrangedSubview:check];
    [stack addArrangedSubview:hi];
    [stack addArrangedSubview:info];
    [NSLayoutConstraint activateConstraints:@[
        [stack.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stack.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [stack.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor constant:22],
        [stack.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-22]
    ]];
}

- (void)showLogin {
    [self clearScreen];

    UIColor *panelColor = [UIColor colorWithRed:0.055 green:0.075 blue:0.12 alpha:1];
    UIColor *blue = [UIColor colorWithRed:0.13 green:0.46 blue:0.91 alpha:1];
    UIColor *muted = [UIColor colorWithRed:0.66 green:0.72 blue:0.82 alpha:1];

    self.view.backgroundColor = UIColor.blackColor;

    UIScrollView *scroll = [UIScrollView new];
    scroll.translatesAutoresizingMaskIntoConstraints = NO;
    scroll.alwaysBounceVertical = YES;
    [self.view addSubview:scroll];
    [NSLayoutConstraint activateConstraints:@[
        [scroll.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:8],
        [scroll.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-8],
        [scroll.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:14],
        [scroll.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-14]
    ]];

    UIView *panel = [UIView new];
    panel.translatesAutoresizingMaskIntoConstraints = NO;
    panel.backgroundColor = panelColor;
    panel.layer.cornerRadius = 30;
    panel.layer.borderWidth = 1.5;
    panel.layer.borderColor = [UIColor colorWithRed:0.19 green:0.25 blue:0.36 alpha:1].CGColor;
    [scroll addSubview:panel];

    [NSLayoutConstraint activateConstraints:@[
        [panel.topAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.topAnchor constant:8],
        [panel.bottomAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.bottomAnchor constant:-8],
        [panel.leadingAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.leadingAnchor],
        [panel.trailingAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.trailingAnchor],
        [panel.widthAnchor constraintEqualToAnchor:scroll.frameLayoutGuide.widthAnchor]
    ]];

    UIStackView *stack = [UIStackView new];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.alignment = UIStackViewAlignmentFill;
    BOOL compactLayout = (self.view.bounds.size.height < 760 || self.view.bounds.size.width > self.view.bounds.size.height);
    stack.spacing = compactLayout ? 11 : 15;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [panel addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[
        [stack.topAnchor constraintEqualToAnchor:panel.topAnchor constant:(compactLayout ? 14 : 18)],
        [stack.bottomAnchor constraintEqualToAnchor:panel.bottomAnchor constant:(compactLayout ? -14 : -18)],
        [stack.leadingAnchor constraintEqualToAnchor:panel.leadingAnchor constant:(compactLayout ? 15 : 20)],
        [stack.trailingAnchor constraintEqualToAnchor:panel.trailingAnchor constant:(compactLayout ? -15 : -20)]
    ]];

    // Header: Sasuke replaces the R emblem; the complete RYUMA name remains visible.
    UIStackView *header = [UIStackView new];
    header.axis = UILayoutConstraintAxisHorizontal;
    header.alignment = UIStackViewAlignmentCenter;
    header.distribution = UIStackViewDistributionFill;
    header.spacing = compactLayout ? 10 : 13;
    header.translatesAutoresizingMaskIntoConstraints = NO;

    UIStackView *brandText = [UIStackView new];
    brandText.axis = UILayoutConstraintAxisVertical;
    brandText.alignment = UIStackViewAlignmentTrailing;
    brandText.spacing = 3;
    UILabel *brand = [self label:@"RYUMA" size:(compactLayout ? 25 : 28) weight:UIFontWeightBold color:UIColor.whiteColor];
    brand.textAlignment = NSTextAlignmentRight;
    UILabel *premium = [self label:@"PREMIUM iOS" size:(compactLayout ? 14 : 16) weight:UIFontWeightRegular color:muted];
    premium.textAlignment = NSTextAlignmentRight;
    [brandText addArrangedSubview:brand];
    [brandText addArrangedSubview:premium];
    [header addArrangedSubview:brandText];
    [header addArrangedSubview:[self ryumaLogoView]];

    UILabel *online = [self label:@"ONLINE" size:15 weight:UIFontWeightSemibold color:[UIColor colorWithRed:0.12 green:0.82 blue:0.43 alpha:1]];
    online.backgroundColor = [UIColor colorWithRed:0.04 green:0.20 blue:0.16 alpha:1];
    online.layer.cornerRadius = 18;
    online.clipsToBounds = YES;
    online.textAlignment = NSTextAlignmentCenter;
    [NSLayoutConstraint activateConstraints:@[
        [online.heightAnchor constraintEqualToConstant:38],
        [online.widthAnchor constraintGreaterThanOrEqualToConstant:112]
    ]];

    UIView *separator = [UIView new];
    separator.translatesAutoresizingMaskIntoConstraints = NO;
    separator.backgroundColor = [UIColor colorWithRed:0.20 green:0.27 blue:0.39 alpha:1];
    [NSLayoutConstraint activateConstraints:@[[separator.heightAnchor constraintEqualToConstant:1]]];

    UILabel *heading = [self label:@"License Center" size:(compactLayout ? 22 : 25) weight:UIFontWeightBold color:UIColor.whiteColor];
    heading.textAlignment = NSTextAlignmentRight;
    UILabel *instruction = [self label:@"Welcome to RYUMA. Verify your license to continue." size:(compactLayout ? 13 : 15) weight:UIFontWeightRegular color:muted];
    instruction.textAlignment = NSTextAlignmentRight;

    self.keyField = [UITextField new];
    self.keyField.placeholder = @"LICENSE KEY";
    self.keyField.textColor = UIColor.whiteColor;
    self.keyField.tintColor = blue;
    self.keyField.font = [UIFont systemFontOfSize:(compactLayout ? 16 : 18) weight:UIFontWeightMedium];
    self.keyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.keyField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.keyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.keyField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,15,1)];
    self.keyField.leftViewMode = UITextFieldViewModeAlways;
    self.keyField.backgroundColor = [UIColor colorWithRed:0.10 green:0.15 blue:0.23 alpha:1];
    self.keyField.layer.cornerRadius = 19;
    self.keyField.layer.borderWidth = 1.5;
    self.keyField.layer.borderColor = [UIColor colorWithRed:0.20 green:0.29 blue:0.42 alpha:1].CGColor;
    self.keyField.translatesAutoresizingMaskIntoConstraints = NO;
    self.keyField.returnKeyType = UIReturnKeyGo;
    [self.keyField addTarget:self action:@selector(keyFieldReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];

    UIToolbar *keyboardBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 48)];
    keyboardBar.barStyle = UIBarStyleBlack;
    keyboardBar.translucent = YES;
    UIBarButtonItem *pasteItem = [[UIBarButtonItem alloc] initWithTitle:@"Paste" style:UIBarButtonItemStylePlain target:self action:@selector(pasteTapped)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *submitItem = [[UIBarButtonItem alloc] initWithTitle:@"Continue" style:UIBarButtonItemStyleDone target:self action:@selector(submitTapped)];
    keyboardBar.items = @[pasteItem, flexItem, submitItem];
    self.keyField.inputAccessoryView = keyboardBar;

    self.submitButton = [self button:@"VERIFY LICENSE" color:blue];
    self.submitButton.titleLabel.font = [UIFont systemFontOfSize:(compactLayout ? 16 : 18) weight:UIFontWeightSemibold];
    [self.submitButton addTarget:self action:@selector(submitTapped) forControlEvents:UIControlEventTouchUpInside];

    UIStackView *licenseInfo = [UIStackView new];
    licenseInfo.axis = UILayoutConstraintAxisVertical;
    licenseInfo.alignment = UIStackViewAlignmentFill;
    licenseInfo.spacing = compactLayout ? 6 : 9;
    licenseInfo.layoutMargins = compactLayout ? UIEdgeInsetsMake(10, 12, 10, 12) : UIEdgeInsetsMake(13, 15, 13, 15);
    licenseInfo.layoutMarginsRelativeArrangement = YES;
    licenseInfo.backgroundColor = [UIColor colorWithRed:0.055 green:0.17 blue:0.15 alpha:1];
    licenseInfo.layer.cornerRadius = 22;
    [licenseInfo addArrangedSubview:[self ryumaInfoRowWithValue:@"ACTIVE" title:@"Status" valueColor:[UIColor colorWithRed:0.22 green:0.85 blue:0.58 alpha:1]]];
    [licenseInfo addArrangedSubview:[self ryumaInfoRowWithValue:@"Lifetime" title:@"Plan" valueColor:UIColor.whiteColor]];
    [licenseInfo addArrangedSubview:[self ryumaInfoRowWithValue:@"Never" title:@"Expires" valueColor:UIColor.whiteColor]];

    self.statusLabel = [self label:@"" size:14 weight:UIFontWeightRegular color:muted];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;

    UILabel *copyright = [self label:@"copyright : @ryumax1" size:(compactLayout ? 12 : 14) weight:UIFontWeightMedium color:[UIColor colorWithRed:0.36 green:0.64 blue:1 alpha:1]];

    [stack addArrangedSubview:header];
    [stack addArrangedSubview:online];
    [stack addArrangedSubview:separator];
    [stack addArrangedSubview:heading];
    [stack addArrangedSubview:instruction];
    [stack addArrangedSubview:self.keyField];
    [stack addArrangedSubview:self.submitButton];
    [stack addArrangedSubview:licenseInfo];
    [stack addArrangedSubview:self.statusLabel];
    [stack addArrangedSubview:copyright];

    [NSLayoutConstraint activateConstraints:@[
        [header.heightAnchor constraintGreaterThanOrEqualToConstant:(compactLayout ? 58 : 68)],
        [self.keyField.heightAnchor constraintEqualToConstant:(compactLayout ? 54 : 64)],
        [self.submitButton.heightAnchor constraintEqualToConstant:(compactLayout ? 48 : 54)]
    ]];
}

- (void)keyFieldReturn:(UITextField *)field {
    [field resignFirstResponder];
    [self submitTapped];
}

- (void)pasteTapped {
    NSString *paste = UIPasteboard.generalPasteboard.string ?: @"";
    if (paste.length) self.keyField.text = paste;
    else self.statusLabel.text = @"Clipboard is empty.";
}

- (void)submitTapped {
    NSString *key = [self.keyField.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (!key.length || gRYUMAVerifying) {
        self.statusLabel.text = key.length ? @"Checking license..." : @"Please enter your license key.";
        return;
    }
    gRYUMAVerifying = YES;
    self.submitButton.enabled = NO;
    self.statusLabel.text = @"Checking license...";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kRYUMAEndpoint]];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 15;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:@{@"key":key} options:0 error:nil];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            gRYUMAVerifying = NO;
            self.submitButton.enabled = YES;
            NSDictionary *json = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : nil;
            BOOL httpOK = !error && [(NSHTTPURLResponse *)response statusCode] == 200;
            BOOL serverValid = [json[@"valid"] boolValue];
            NSString *licenseStatus = [json[@"status"] isKindOfClass:NSString.class] ? json[@"status"] : @"";
            NSString *licensePlan = [json[@"plan"] isKindOfClass:NSString.class] ? json[@"plan"] : @"";
            id expiresAt = json[@"expiresAt"];
            BOOL metadataOK = [licenseStatus.lowercaseString isEqualToString:@"active"] && licensePlan.length > 0;
            if (httpOK && serverValid && metadataOK) {
                gRYUMAValid = YES;
                [self showVerifiedWithStatus:licenseStatus plan:licensePlan expiresAt:expiresAt];
            } else if (error) {
                self.statusLabel.text = @"Connection failed. Try again.";
            } else if (httpOK && serverValid && !metadataOK) {
                self.statusLabel.text = @"License response incomplete. Please contact support.";
            } else {
                self.statusLabel.text = @"Invalid license key. Please try again.";
            }
        });
    }] resume];
}

- (void)showVerifiedWithStatus:(NSString *)status plan:(NSString *)plan expiresAt:(id)expiresAt {
    [self clearScreen];
    UIStackView *stack = [UIStackView new];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.alignment = UIStackViewAlignmentCenter;
    stack.spacing = 16;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stack];
    [stack addArrangedSubview:[self ryumaInjectedAppIconView]];
    [stack addArrangedSubview:[self label:@"RYUMA" size:35 weight:UIFontWeightBold color:UIColor.whiteColor]];
    [stack addArrangedSubview:[self label:@"✓" size:78 weight:UIFontWeightLight color:[UIColor colorWithRed:0.22 green:0.82 blue:0.40 alpha:1]]];
    [stack addArrangedSubview:[self label:@"License verified" size:24 weight:UIFontWeightSemibold color:[UIColor colorWithRed:0.22 green:0.82 blue:0.40 alpha:1]]];
    [stack addArrangedSubview:[self label:@"Welcome to RYUMA!" size:18 weight:UIFontWeightRegular color:UIColor.whiteColor]];
    NSString *expiryText = @"Never";
    if ([expiresAt isKindOfClass:NSString.class] && [expiresAt length] > 0) {
        expiryText = expiresAt;
    } else if (expiresAt && expiresAt != [NSNull null]) {
        expiryText = [expiresAt description];
    }
    NSString *statusText = [NSString stringWithFormat:@"Status: %@", status.uppercaseString];
    NSString *planText = [NSString stringWithFormat:@"Plan: %@", plan];
    NSString *expiryLabelText = [NSString stringWithFormat:@"Expires: %@", expiryText];
    UIColor *metaColor = [UIColor colorWithWhite:0.78 alpha:1];
    [stack addArrangedSubview:[self label:statusText size:16 weight:UIFontWeightSemibold color:[UIColor colorWithRed:0.22 green:0.82 blue:0.40 alpha:1]]];
    [stack addArrangedSubview:[self label:planText size:16 weight:UIFontWeightMedium color:metaColor]];
    [stack addArrangedSubview:[self label:expiryLabelText size:15 weight:UIFontWeightRegular color:metaColor]];
    UIButton *done = [self button:@"Continue" color:[UIColor colorWithRed:0.20 green:0.48 blue:0.88 alpha:1]];
    [done addTarget:self action:@selector(closeGate) forControlEvents:UIControlEventTouchUpInside];
    [stack addArrangedSubview:done];
    [NSLayoutConstraint activateConstraints:@[
        [stack.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stack.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [stack.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor constant:24],
        [stack.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-24],
        [done.widthAnchor constraintEqualToConstant:210],
        [done.heightAnchor constraintEqualToConstant:54]
    ]];
}

- (void)closeGate {
    gRYUMAWindow.hidden = YES;
    gRYUMAWindow = nil;
}

@end

static void RYUMAPresent(void) {
    if (gRYUMAShown || gRYUMAValid) return;
    gRYUMAShown = YES;
    RYUMAScreen *screen = [RYUMAScreen new];
    if (@available(iOS 13.0, *)) {
        UIWindowScene *activeScene = nil;
        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:UIWindowScene.class]) {
                activeScene = (UIWindowScene *)scene; break;
            }
        }
        if (activeScene) gRYUMAWindow = [[UIWindow alloc] initWithWindowScene:activeScene];
    }
    if (!gRYUMAWindow) gRYUMAWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    gRYUMAWindow.windowLevel = UIWindowLevelAlert + 1;
    gRYUMAWindow.rootViewController = screen;
    [gRYUMAWindow makeKeyAndVisible];
    [screen showInitializing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!gRYUMAWindow) return;
        [screen showWelcome];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!gRYUMAWindow || gRYUMAValid) return;
            [screen showLogin];
        });
    });
}

%ctor {
    @autoreleasepool {
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ RYUMAPresent(); });
        });
    }
}