# Stripe Platform Configuration Guide

This document covers the platform-specific configurations for iOS and Android to ensure Stripe works correctly.

---

## ✅ Android Configuration (COMPLETED)

### Changes Made

**File: `android/app/build.gradle.kts`**
```kotlin
defaultConfig {
    minSdk = 21  // Required for Stripe SDK
    multiDexEnabled = true  // Required for Stripe SDK
    // ... other config
}
```

### What This Does
- **minSdk = 21**: Sets minimum Android version to Lollipop (required by Stripe SDK)
- **multiDexEnabled = true**: Allows app to use more than 65K methods (Stripe SDK is large)

### Permissions (Already Configured)
The following permissions are already in `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

---

## ✅ iOS Configuration (COMPLETED)

### Changes Made

**File: `ios/Podfile`**
```ruby
# Set minimum iOS version
platform :ios, '13.0'  # Required for Stripe SDK

# In post_install block
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)

    # Set minimum deployment target for all pods
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
```

### What This Does
- **platform :ios, '13.0'**: Sets minimum iOS version (required by Stripe SDK)
- **IPHONEOS_DEPLOYMENT_TARGET**: Ensures all CocoaPods use iOS 13.0+ (prevents compilation errors)

---

## 🔧 Post-Configuration Steps

### For iOS Development

After pulling these changes, run:

```bash
cd ios
pod install
cd ..
```

This will:
1. Install Stripe iOS SDK via CocoaPods
2. Update all pod dependencies
3. Configure Xcode project with correct deployment targets

**Note**: If you get pod installation errors, try:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

### For Android Development

No additional steps needed! Gradle will automatically download dependencies on first build.

---

## 📱 Testing

### Test on iOS Simulator (Mac only)
```bash
flutter run -d "iPhone 15 Pro"  # or any iOS simulator
```

### Test on Android Emulator
```bash
flutter run -d emulator-5554  # or your emulator name
```

### Test on Physical Device

**iOS:**
1. Connect iPhone via USB
2. Trust computer on device
3. Run: `flutter run`

**Android:**
1. Enable Developer Mode on phone
2. Enable USB Debugging
3. Connect via USB
4. Run: `flutter run`

---

## 🐛 Troubleshooting

### iOS Issues

**Error: "The iOS Simulator deployment target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 12.0"**
- Solution: Run `cd ios && pod install && cd ..`
- Verify Podfile has `platform :ios, '13.0'`

**Error: "Undefined symbols for Stripe"**
- Solution: Clean and rebuild
```bash
flutter clean
cd ios && pod install && cd ..
flutter run
```

**CocoaPods installation hanging**
- Solution: Update CocoaPods
```bash
sudo gem install cocoapods
cd ios && pod repo update && pod install && cd ..
```

### Android Issues

**Error: "Execution failed for task ':app:mergeDexDebug'"**
- Solution: MultiDex is already enabled in build.gradle.kts
- If still occurs, try `flutter clean && flutter build apk`

**Error: "Manifest merger failed"**
- Solution: Check AndroidManifest.xml for conflicts
- Our configuration is minimal and should not conflict

**Error: "Minimum SDK version X is less than 21"**
- Solution: Verify `minSdk = 21` in build.gradle.kts
- Run: `flutter clean && flutter run`

---

## 🚀 Build for Release

### iOS Release Build

```bash
flutter build ios --release
```

Then open Xcode and archive:
```bash
open ios/Runner.xcworkspace
```
- Product → Archive
- Distribute App → App Store Connect

### Android Release Build

```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

APK location: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📋 Configuration Checklist

- [x] Android minSdk set to 21
- [x] Android multiDex enabled
- [x] iOS platform set to 13.0
- [x] iOS deployment target set in post_install
- [x] Internet permissions configured
- [ ] Run `pod install` on iOS (YOU NEED TO DO)
- [ ] Test on iOS simulator (YOU NEED TO DO)
- [ ] Test on Android emulator (YOU NEED TO DO)
- [ ] Test Stripe payment on both platforms (YOU NEED TO DO)

---

## 🔐 Important Notes

1. **Minimum Versions**:
   - Android: API 21+ (Android 5.0 Lollipop)
   - iOS: 13.0+

2. **Device Support**:
   - Covers 99%+ of active devices
   - Very few devices run older versions

3. **Testing**:
   - Always test on both iOS and Android before release
   - Test with various payment methods (cards, Apple Pay, Google Pay)

4. **Performance**:
   - MultiDex may slightly increase APK size (~1-2MB)
   - No noticeable performance impact on modern devices

---

## 📚 Additional Resources

- [flutter_stripe Documentation](https://pub.dev/packages/flutter_stripe)
- [Stripe iOS SDK](https://stripe.com/docs/mobile/ios)
- [Stripe Android SDK](https://stripe.com/docs/mobile/android)
- [Flutter Platform Integration](https://docs.flutter.dev/platform-integration)

---

**All configurations are complete! You can now proceed with testing Stripe payments on both platforms.** 🎉
