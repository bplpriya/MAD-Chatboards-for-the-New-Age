plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle Plugin
    id("dev.flutter.flutter-gradle-plugin")
    // Firebase plugin MUST be last
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.mad_hw2"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.mad_hw2"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false // <-- add this
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM to manage versions
    implementation(platform("com.google.firebase:firebase-bom:32.2.2"))

    // Firebase Cloud Messaging
    implementation("com.google.firebase:firebase-messaging-ktx")
}
