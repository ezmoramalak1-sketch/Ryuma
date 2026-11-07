#import <UIKit/UIKit.h>
#import <sys/utsname.h>

static NSString * const kRYUMAEndpoint = @"https://ryuma-verify.ieuhehhehehehhrh.workers.dev";
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
- (void)showVerified;
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

    UILabel *brand = [self label:@"RYUMA" size:36 weight:UIFontWeightBold color:UIColor.whiteColor];
    UILabel *check = [self label:@"✓" size:76 weight:UIFontWeightLight color:[UIColor colorWithRed:0.22 green:0.82 blue:0.40 alpha:1]];
    UILabel *hi = [self label:@"Hi iPhone" size:25 weight:UIFontWeightSemibold color:[UIColor colorWithRed:0.22 green:0.82 blue:0.40 alpha:1]];
    NSString *details = [NSString stringWithFormat:@"Device: %@  |  iOS: %@\nRYUMA License System", RYUMADeviceName(), UIDevice.currentDevice.systemVersion];
    UILabel *info = [self label:details size:15 weight:UIFontWeightRegular color:[UIColor colorWithWhite:0.72 alpha:1]];
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
    UIScrollView *scroll = [UIScrollView new];
    scroll.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scroll];
    [NSLayoutConstraint activateConstraints:@[
        [scroll.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:18],
        [scroll.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-18],
        [scroll.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:22],
        [scroll.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-22]
    ]];

    UIStackView *stack = [UIStackView new];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.alignment = UIStackViewAlignmentFill;
    stack.spacing = 18;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [scroll addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[
        [stack.topAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.topAnchor constant:20],
        [stack.bottomAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.bottomAnchor constant:-20],
        [stack.leadingAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.leadingAnchor],
        [stack.trailingAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.trailingAnchor],
        [stack.widthAnchor constraintEqualToAnchor:scroll.frameLayoutGuide.widthAnchor]
    ]];

    UILabel *brand = [self label:@"RYUMA" size:34 weight:UIFontWeightBold color:UIColor.whiteColor];
    UILabel *heading = [self label:@"License Verification" size:24 weight:UIFontWeightMedium color:UIColor.whiteColor];
    UILabel *instruction = [self label:@"Enter your license key to continue." size:18 weight:UIFontWeightRegular color:UIColor.whiteColor];
    self.keyField = [UITextField new];
    self.keyField.placeholder = @"License Key";
    self.keyField.textColor = UIColor.whiteColor;
    self.keyField.tintColor = [UIColor colorWithRed:0.25 green:0.52 blue:1 alpha:1];
    self.keyField.font = [UIFont systemFontOfSize:20];
    self.keyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.keyField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.keyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.keyField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,15,1)];
    self.keyField.leftViewMode = UITextFieldViewModeAlways;
    self.keyField.backgroundColor = [UIColor colorWithWhite:0.18 alpha:0.95];
    self.keyField.layer.cornerRadius = 17;
    self.keyField.layer.borderWidth = 1;
    self.keyField.layer.borderColor = [UIColor colorWithWhite:0.38 alpha:1].CGColor;
    self.keyField.translatesAutoresizingMaskIntoConstraints = NO;

    // Keep Paste and Submit reachable above the iOS keyboard in portrait and landscape.
    UIToolbar *keyboardBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 48)];
    keyboardBar.barStyle = UIBarStyleBlack;
    keyboardBar.translucent = YES;
    UIBarButtonItem *pasteItem = [[UIBarButtonItem alloc] initWithTitle:@"Paste" style:UIBarButtonItemStylePlain target:self action:@selector(pasteTapped)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *submitItem = [[UIBarButtonItem alloc] initWithTitle:@"Continue" style:UIBarButtonItemStyleDone target:self action:@selector(submitTapped)];
    keyboardBar.items = @[pasteItem, flexItem, submitItem];
    self.keyField.inputAccessoryView = keyboardBar;
    self.keyField.returnKeyType = UIReturnKeyGo;
    [self.keyField addTarget:self action:@selector(keyFieldReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];

    UIStackView *buttons = [UIStackView new];
    buttons.axis = UILayoutConstraintAxisHorizontal;
    buttons.spacing = 12;
    buttons.distribution = UIStackViewDistributionFillEqually;
    buttons.translatesAutoresizingMaskIntoConstraints = NO;
    self.pasteButton = [self button:@"Paste" color:[UIColor colorWithWhite:0.24 alpha:1]];
    self.submitButton = [self button:@"Submit" color:[UIColor colorWithRed:0.20 green:0.48 blue:0.88 alpha:1]];
    [self.pasteButton addTarget:self action:@selector(pasteTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton addTarget:self action:@selector(submitTapped) forControlEvents:UIControlEventTouchUpInside];
    [buttons addArrangedSubview:self.pasteButton];
    [buttons addArrangedSubview:self.submitButton];

    self.statusLabel = [self label:@"" size:14 weight:UIFontWeightRegular color:[UIColor colorWithWhite:0.72 alpha:1]];
    [stack addArrangedSubview:brand];
    [stack addArrangedSubview:heading];
    [stack addArrangedSubview:instruction];
    [stack addArrangedSubview:self.keyField];
    [stack addArrangedSubview:buttons];
    [stack addArrangedSubview:self.statusLabel];
    [NSLayoutConstraint activateConstraints:@[
        [self.keyField.heightAnchor constraintEqualToConstant:62],
        [buttons.heightAnchor constraintEqualToConstant:58]
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
            BOOL valid = !error && [(NSHTTPURLResponse *)response statusCode] == 200 && [json[@"valid"] boolValue];
            if (valid) {
                gRYUMAValid = YES;
                [self showVerified];
            } else {
                self.statusLabel.text = error ? @"Connection failed. Try again." : @"Invalid license key. Please try again.";
            }
        });
    }] resume];
}

- (void)showVerified {
    [self clearScreen];
    UIStackView *stack = [UIStackView new];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.alignment = UIStackViewAlignmentCenter;
    stack.spacing = 16;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stack];
    [stack addArrangedSubview:[self label:@"RYUMA" size:35 weight:UIFontWeightBold color:UIColor.whiteColor]];
    [stack addArrangedSubview:[self label:@"✓" size:78 weight:UIFontWeightLight color:[UIColor colorWithRed:0.22 green:0.82 blue:0.40 alpha:1]]];
    [stack addArrangedSubview:[self label:@"License verified" size:24 weight:UIFontWeightSemibold color:[UIColor colorWithRed:0.22 green:0.82 blue:0.40 alpha:1]]];
    [stack addArrangedSubview:[self label:@"Welcome to RYUMA!" size:18 weight:UIFontWeightRegular color:UIColor.whiteColor]];
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
