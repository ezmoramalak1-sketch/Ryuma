#import <UIKit/UIKit.h>

static NSString * const kEndpoint = @"https://ryuma-verify.ieuhehhehehehhrh.workers.dev";
static BOOL gShown = NO;
static BOOL gVerified = NO;
static BOOL gChecking = NO;

static UIViewController *TopController(void) {
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (scene.activationState != UISceneActivationStateForegroundActive || ![scene isKindOfClass:UIWindowScene.class]) continue;
            for (UIWindow *w in ((UIWindowScene *)scene).windows) if (w.isKeyWindow) { window = w; break; }
            if (window) break;
        }
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (!window) window = UIApplication.sharedApplication.keyWindow;
#pragma clang diagnostic pop
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController && !vc.presentedViewController.isBeingDismissed) vc = vc.presentedViewController;
    return vc;
}

static void ShowGate(void);
static void ShowMessage(NSString *message) {
    UIViewController *vc = TopController();
    if (!vc) return;
    UIAlertController *a = [UIAlertController alertControllerWithTitle:@"RYUMA" message:message preferredStyle:UIAlertControllerStyleAlert];
    [a addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [vc presentViewController:a animated:YES completion:nil];
}

static void Verify(NSString *key) {
    if (gChecking) return;
    gChecking = YES;
    NSMutableURLRequest *r = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kEndpoint]];
    r.HTTPMethod = @"POST";
    r.timeoutInterval = 15;
    [r setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    r.HTTPBody = [NSJSONSerialization dataWithJSONObject:@{@"key": key} options:0 error:nil];

    [[[NSURLSession sharedSession] dataTaskWithRequest:r completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            gChecking = NO;
            NSDictionary *json = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : nil;
            BOOL ok = !error && [(NSHTTPURLResponse *)response statusCode] == 200 && [json[@"valid"] boolValue];
            if (ok) {
                gVerified = YES;
                UIViewController *vc = TopController();
                [vc dismissViewControllerAnimated:YES completion:^{ ShowMessage(@"License verified. Welcome to RYUMA!"); }];
            } else {
                ShowMessage(error ? @"Connection failed. Try again." : @"Invalid license key. Please try again.");
                gShown = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ ShowGate(); });
            }
        });
    }] resume];
}

static void ShowGate(void) {
    if (gShown || gVerified) return;
    UIViewController *vc = TopController();
    if (!vc || vc.presentedViewController) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ ShowGate(); });
        return;
    }
    gShown = YES;
    UIAlertController *a = [UIAlertController alertControllerWithTitle:@"RYUMA" message:@"License Verification\nEnter your license key to continue." preferredStyle:UIAlertControllerStyleAlert];
    [a addTextFieldWithConfigurationHandler:^(UITextField *f) {
        f.placeholder = @"License Key";
        f.autocorrectionType = UITextAutocorrectionTypeNo;
        f.autocapitalizationType = UITextAutocapitalizationTypeNone;
        f.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [a addAction:[UIAlertAction actionWithTitle:@"Paste" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        NSString *p = UIPasteboard.generalPasteboard.string ?: @"";
        if (p.length) Verify([p stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]);
        else { gShown = NO; ShowMessage(@"Clipboard is empty."); dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ ShowGate(); }); }
    }]];
    [a addAction:[UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        NSString *key = [a.textFields.firstObject.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if (!key.length) { gShown = NO; ShowMessage(@"Please enter a license key."); dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ ShowGate(); }); }
        else Verify(key);
    }]];
    [vc presentViewController:a animated:YES completion:nil];
}

%ctor {
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ ShowGate(); });
    });
}
