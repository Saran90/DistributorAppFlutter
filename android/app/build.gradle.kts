plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.distributor_app_flutter"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    buildFeatures {
        buildConfig = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.intellilabs.distributor"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.

        minSdk = flutter.minSdkVersion
        targetSdk = 34  // Replace with your desired target SDK or a local variable
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    flavorDimensions.add("trademate")

    productFlavors {
        create("cochinDistributor") {
            dimension = "trademate"
            // applicationIdSuffix = ".cochinDistributor" // This is the correct syntax if you need it
        }
        create("varsha") {
            dimension = "trademate"
            // applicationIdSuffix = ".varsha"
        }
        create("nks") {
            dimension = "trademate"
            // applicationIdSuffix = ".nks" // Corrected this commented line as well
        }
    }
}

flutter {
    source = "../.."
}
