# mb-mobile-sdk
Magiclabs mobile SDK

> **⚠️ Warning: This is a Mock SDK**
>
> The `MagiclabsMock` SDK provided here is **not operational** and is intended for **testing purposes only**. It simulates the behavior of the real SDK but does not perform actual network requests, photo analysis, or project manipulation. This mock version should be used solely for integration testing and validating workflows without interacting with live systems.


## Table of Contents

- [mb-mobile-sdk](#mb-mobile-sdk)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Features](#features)
  - [Getting Started](#getting-started)
    - [iOS](#ios)
      - [Installation](#installation)
      - [CocoaPods Installation](#cocoapods-installation)
      - [Importing the SDK](#importing-the-sdk)
      - [Initialization](#initialization)
    - [Android](#android)
      - [Download the SDK](#download-the-sdk)
      - [Step 2: Add the `.aar` file to your project](#step-2-add-the-aar-file-to-your-project)
      - [Import the SDK in your code](#import-the-sdk-in-your-code)
    - [Event Handling](#event-handling)
      - [Setting Up the Event Handler](#setting-up-the-event-handler)
    - [Retrieving design options](#retrieving-design-options)
    - [Photo Analysis](#photo-analysis)



## Overview
The MagicLabs SDK provides functionality for analyzing photos, autofilling projects, and dynamically managing design surfaces.

## Features
- **Autofill Options**: Retrieve options for embellishments, photo densities, and sticker levels.
- **Photo Analysis**: Analyze a batch of photos and extract relevant metadata for project design.
- **Autofill Project**: Design the surfaces of a project.
- **Resize Projects**: Adjust surface format size.
- **Restyle Projects**: Restyle a project.
- **Autofill Surface**: Design a new surface4.
- **Shuffle Surface**: Shuffle the arrangement of photos on a surface.
- **Auto-Adapt Surface**: Automatically adjust photo arrangement of a surface following user edits.
- **Suggest Surfaces**: Generate multiple surface suggestions.

## Getting Started
### iOS
#### Installation

The MagicLabs SDK is available via CocoaPods and distributed as an `XCFramework`. Follow the steps below to integrate the SDK into your iOS project.

#### CocoaPods Installation
1. Ensure CocoaPods is installed in your project. If it isn't, you can install it by running:

   ```bash
   sudo gem install cocoapods
   ```
2. Add the MagicLabs SDK to your Podfile, replacing VERSION with the relevant number:
   ```
   target 'YourApp' do
    use_frameworks!

    pod 'MagiclabsSDK', :podspec => 'https://github.com/magiclabs-ai/mb-mobile-sdk/releases/download/${VERSION}/MagiclabsSDK.podspec'
   end
   ```
3. Run pod install to integrate the SDK into your project:
   ```bash
   pod install
   ```

#### Importing the SDK
Once you've installed the SDK via CocoaPods, import it into the necessary files in your Swift project:
```swift
import MagiclabsSDK
```

#### Initialization
To begin using the SDK, initialize it with a ClientConfiguration object:

To begin using the SDK, initialize it with a `ClientConfiguration` object. The initialization requires an API key and allows you to specify the base URL for the API (defaults to `"https://api.example.com"` if not provided).

Here’s an example of how to configure the SDK with actual values:

```swift
let magiclabsClient = MagiclabsMock()
let config = ClientConfiguration(
    apiKey = "your-api-key-here",  
    baseUrl = "https://api.magiclabs.com" 
)
magiclabsClient.initialize(configuration: config)
```

### Android
To integrate the MOCK MagicLabs SDK into your Android project, you need to download the SDK as an `.aar` file from the GitHub release page and configure your project accordingly. Follow the steps below to set up the SDK in an Android environment.

#### Download the SDK

1. Go to the [MagicLabs SDK GitHub Releases](https://github.com/magiclabs-ai/mb-mobile-sdk/releases) page.
2. Download the `mobile_sdk:VERSION.aar` file for the appropriate version you wish to use. 

#### Step 2: Add the `.aar` file to your project
2. Create a `libs` folder under the `app` module if it doesn’t already exist.
3. Place the downloaded `.aar` file (`mobile_sdk-VERSION.aar`) into the `libs` folder.
4. Modify the `build.gradle` file in your `app` module to include the `.aar` file:

```gradle
dependencies {
    implementation(files("libs/mobile_sdk-VERSION.aar"))
}
```

#### Import the SDK in your code
```kotlin
import com.magiclabs.core.MagiclabsMock
import com.magiclabs.models.ClientConfiguration

// Initialize the MagicLabs Mock SDK
val magiclabsClient = MagiclabsMock()
val config = ClientConfiguration(
    apiKey = "your-api-key-here",
    baseUrl = "https://api.magiclabs.com"
)
magiclabsClient.initialize(config)
```


### Event Handling

The MagicLabs SDK uses an event-driven architecture to notify your app about important actions like photo analysis, project resizing, and more. To handle these events, you need to implement an `eventHandler` that listens for specific events and processes the associated data.

#### Setting Up the Event Handler
You can assign an `eventHandler` to the `MagiclabsClient` to respond to different events triggered during SDK operations. Here’s an example:

```swift
// iOS
magiclabsClient.eventHandler = { event in
    switch event.name {
    case "photo.analyzed":
        // Handle photo analysis event
        if let analyzedPhoto = event.data as? Photo {
            print("Photo analyzed: \(analyzedPhoto.id)")
            // Perform additional actions with the analyzed photo
        }
    case "project.resized":
        // Handle project resize event
        if let resizedProject = event.data as? Project {
            print("Project resized: \(resizedProject.id)")
            // Update UI or perform other actions
        }
    case "surface.autofilled":
        // Handle surface autofill event
        if let surface = event.data as? Surface {
            print("Surface autofilled with ID: \(surface.id)")
        }
    default:
        print("Unhandled event: \(event.name)")
    }
}
```

```kotlin
// Android
magiclabsClient.eventHandler = { event: Event ->
    when (event.name) {
        "photo.analyzed" -> {
            // Handle photo analysis event
            val analyzedPhoto = event.data as? Photo
            analyzedPhoto?.let {
                // Perform additional actions with the analyzed photo
                println("Photo analyzed with ID: ${it.id}")
            }
        }
        "project.resized" -> {
            // Handle project resizing event
            val resizedProject = event.data as? Project
            resizedProject?.let {
                println("Project resized with ID: ${it.id}")
            }
        }
        "surface.autofilled" -> {
            // Handle surface autofill event
            println("Surface autofilled with data: ${event.data}")
        }
        else -> {
            // Handle other events
            println("Unhandled event: ${event.name}")
        }
    }
}
```

### Retrieving design options
To analyze a set of photos, use the `analyzePhotos` method. This method requires a list of `Photo` objects and triggers events as each photo is analyzed.

Here’s an example of how to perform photo analysis:

```swift
// Create a list of Photo objects to analyze
let photos = [
    Photo(id: "1", width: 1024, height: 1024, orientation: 0),
    Photo(id: "2", width: 1024, height: 1024, orientation: 0),
]

// Call the analyzePhotos method
magiclabsClient.analyzePhotos(photos: photos) { result in
    switch result {
    case .success():
        print("Photo analysis started successfully.")
    case .failure(let error):
        print("Photo analysis failed with error: \(error.localizedDescription)")
    }
}
```

### Photo Analysis
To analyze a set of photos, use the `analyzePhotos` method. This method requires a list of `Photo` objects and triggers events as each photo is analyzed.

Here’s an example of how to perform photo analysis:

```swift
// iOS
// Create a list of Photo objects to analyze
let photos = [
    Photo(id: "1", width: 1024, height: 1024, orientation: 0),
    Photo(id: "2", width: 1024, height: 1024, orientation: 0),
]

// Call the analyzePhotos method
magiclabsClient.analyzePhotos(photos: photos) { result in
    switch result {
    case .success():
        print("Photo analysis started successfully.")
    case .failure(let error):
        print("Photo analysis failed with error: \(error.localizedDescription)")
    }
}
```

```kotlin
// Android
// Create a list of Photo objects to analyze
val photos = listOf(
    Photo("1", 2048, 2048, 0),
    Photo("2", 2048, 2048, 0),
    Photo("3", 2048, 2048, 0),
)

// Call the analyzePhotos method
val results = sdk.analyzePhotos(photos)
```
