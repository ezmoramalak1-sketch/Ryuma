# RYUMA — GitHub build starter

Use from iPhone + GitHub: create a repository, upload these files, then open Actions → Build RYUMA → Run workflow. Download the `RYUMA-build` artifact when it succeeds.

Before use, replace `REPLACE.WITH.YOUR.APP.BUNDLE.ID` in `RYUMA.plist` with the bundle identifier of an app you own/are authorized to modify.

This is source code, not a compiled dylib. GitHub Actions builds it using a macOS runner and Theos. The output is a Theos tweak build; ESign injection compatibility and signing depend on the target IPA and ESign version. It is not guaranteed for every iOS version/device.

API request: POST JSON `{"key":"entered-key"}` to the supplied Cloudflare Worker. The worker currently validates only the key; it does not validate the separately supplied fingerprint. Keep the actual secret in Cloudflare Worker environment variables, never in this repository.

Only inject into an app you own or have permission to modify. Check the IPA's bundle ID before setting the filter.
