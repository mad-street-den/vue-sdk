<p align="center">
  <img src="https://vue.ai/images/logo/vue-logo-light.svg" alt="Vue SDK"/>
</p>

# Table of Contents

<!-- MarkdownTOC -->

- [Overview](#overview)
- [Quick Start Guide](#quick-start-guide)
  - [Install Vue SDK](#1-install-vue-sdk)
  - [Initialize Vue SDK](#2-initialize-vue-sdk)
  - [Discover Events](#3-discover-events)
  - [Track Event](#4-track-event)
  - [Get Recommendations](#5-get-recommendations)
  - [Set User](#6-set-user)
  - [Reset User](#7-reset-user)
  - [Set BloxUUID](#8-set-bloxuuid)
  - [Reset BloxUUID](#9-reset-bloxuuid)
  - [VueSDK debugging and logging](#10-vuesdk-debugging-and-logging)
  - [Complete Code Example](#complete-code-example)
- [I want to know more!](#i-want-to-know-more)

<!-- /MarkdownTOC -->

<a name="introduction"></a>

# Overview

VueSDK is a library/SDK providing all the functions and utilities required to help you build and integrate all the recommendations and search offered by Vue.AI. To know about the detailed set of use cases available - please [visit this link](https://support.vue.ai/docs/DXM%20Hub/Strategy)

# Quick Start Guide

## 1. Install Vue SDK

You will need your project token for initializing your library. You can get your project token from [project settings](https://support.getblox.ai/docs/cli).

### Using CocoaPods

1. If this is your first time using CocoaPods, Install CocoaPods using `gem install cocoapods`. Otherwise, continue to Step 3.
2. Run `pod setup` to create a local CocoaPods spec mirror.
3. Create a Podfile in your Xcode project directory by running `pod init` in your terminal, edit the Podfile generated, and add the following line: `pod 'vue-sdk-ios'`.
4. Run `pod install` in your Xcode project directory. CocoaPods should download and install the VUE SDK library, and create a new Xcode workspace. Open up this workspace in Xcode or typing `open *.xcworkspace` in your terminal.

## 2. Initialize VueSDK

Import `vue_sdk_ios` into AppDelegate.swift, and initialize `VueSDK` within `application:didFinishLaunchingWithOptions:`

```swift
import vue_sdk_ios

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    ...
    VueSDK.initialize(token: "YOUR_TOKEN",baseUrl: "GIVEN_VUE_BASE_URL")
    ...
}
```

## 3. Discover Events

To ensure accurate and comprehensive event tracking, it is recommended to call the `discoverEvents` function before invoking the track function in your SDK integration. The `discoverEvents` function retrieves the essential information related to track events, such as event names, properties, and default properties. This step allows you to populate the necessary data and configure the event tracking accordingly.

```swift
VueSDK.mainInstance().discoverEvents(success: { (response) in
            //Handle success
        }, failure: { error in
            //Handle failure
        })
```

## 4. Track Event

To track custom events using our SDK, you can utilize the `track` function. This function allows you to capture specific actions or interactions within your application and gather valuable data for analysis.

Here's an example of how to use the track function:

```swift
VueSDK.mainInstance().track(
    eventName: "YOUR_CUSTOM_EVENT_NAME",
    properties: ["YOUR_KEY" : "YOUR_VALUE"],
    correlationID: "UNIQUE_CORRRELATION_ID",
    sdkConfig: VueSDKConfig(medium: "",url: "",platform: "",referrer: "")
 );
```

**Note:** The `correlationId` is an optional parameter that allows you to provide a unique correlation ID for the event. It is important to ensure that the `correlationId` is unique across each pages for both search and track API calls.

The SDK automatically includes several properties when tracking events. These properties are essential for comprehensive event tracking and provide valuable insights into user interactions. Given below are the properties that are automatically added by the SDK. By explicitly providing the SDK config parameter for the track function, the user can override each property's value:

<!-- TABLE_GENERATE_START -->

| key        | Description                            | Example Value     |
| ---------- | -------------------------------------- | ----------------- |
| `platform` | Platform of the user                   | ios               |
| `medium`   | Medium from where requests are sent    | application       |
| `referrer` | same values as platform for mobile app | ios               |
| `url`      | Bundle id of the application           | com.example.myapp |

<!-- TABLE_GENERATE_END -->

## 5. Get Recommendations

The getRecommendation functions in the SDK allows you to retrieve recommendations based on specific search criteria and properties. This function provides a convenient way to fetch recommendations and receive the results asynchronously.

### 1. Get Recommendations by Page

```swift
 VueSDK.mainInstance().getRecommendationsByPage(
    pageReference: "YOUR_PAGE_NAME",
    properties: RecommendationRequest(
        catalogs: [:]
    ),
    correlationID: "UNIQUE_CORRRELATION_ID",
    sdkConfig: VueSDKConfig(medium: "",url: "",platform: "",referrer: "")
) { response, error in
    if error != nil {
        // Handle Error case
    } else {
        // Handle Success case
    }
}

```

### 2. Get Recommendations by Module

```swift
 VueSDK.mainInstance().getRecommendationsByModule(
    moduleReference: "YOUR_MODULE_NAME",
    properties: RecommendationRequest(
        catalogs: [:]
    ),
    correlationID: "UNIQUE_CORRRELATION_ID",
    sdkConfig: VueSDKConfig(medium: "",url: "",platform: "",referrer: "")
) { response, error in
    if error != nil {
        // Handle Error case
    } else {
        // Handle Success case
    }
}

```

### 3. Get Recommendations by Strategy

```swift
VueSDK.mainInstance().getRecommendationsByStrategy(
    strategyReference: "YOUR_STRATEGY_NAME",
    properties: RecommendationRequest(
        catalogs: [:]
    ),
    correlationID: "UNIQUE_CORRRELATION_ID",
    sdkConfig: VueSDKConfig(medium: "",url: "",platform: "",referrer: "")
) { response, error in
    if error != nil {
        // Handle Error case
    } else {
        // Handle Success case
    }
}

```

**Note:** The `correlationId` is an optional parameter that allows you to provide a unique correlation ID for the search request. It is important to ensure that the `correlationId` is unique across pages for both search and track API calls.

Given below are the properties that are automatically added by the SDK for getRecommendations function. By explicitly providing the SDK config parameter for the getRecommendations function, the user can override each property's value.

<!-- TABLE_GENERATE_START -->

| key        | Description                            | Example Value     |
| ---------- | -------------------------------------- | ----------------- |
| `platform` | Platform of the user                   | ios               |
| `medium`   | Medium from where requests are sent    | application       |
| `referrer` | same values as platform for mobile app | ios               |
| `url`      | Bundle id of the application           | com.example.myapp |

<!-- TABLE_GENERATE_END -->

## 6. Set User

The `setUser` function in the SDK allows you to associate a user ID with subsequent API calls after the user has logged in. This user ID is used to track user-specific events and behaviors, providing personalized experiences and accurate analytics.

```swift
 VueSDK.mainInstance().setUser(userId: "YOUR_USER_ID")
```

## 7. Reset User

The `resetUser` function in the SDK allows you to clear the user information and reset the SDK state when the user logs out of your application. This ensures that any user-specific data and tracking are cleared and no longer associated with the user.

```swift
 VueSDK.mainInstance().resetUser()
```

## 8. Set BloxUUID

The `setBloxUUID` function in the SDK allows you to set the blox UUID which is passed as argument for the getRecommendations and track functions. In the case where you do not set bloxUUID, the SDK internally generates a random UUID upon an SDK function call and will maintain the same value till `setBloxUUID` is called.

```swift
 VueSDK.mainInstance().setBloxUUID(bloxUUID: "BLOX_UUID")
```

**Note:** The BloxUUID provided will be stored in App's cache and will be maintained throughout App's lifecycle.

## 9. Get BloxUUID

The `getBloxUUID` function in the SDK returns the blox UUID configured in the SDK.

```swift
 VueSDK.mainInstance().getBloxUUID()
```

**Note:** In case if setBloxUUID or an SDK function is not called throughout an app's lifecycle the getBloxUUID function will return a null value.

## 10. VueSDK debugging and logging

The SDK provides internal logging capabilities for debugging purposes. By default, the logging feature is disabled.

To enable internal logging, set `isLoggingEnabled` to `true`:

```swift
VueSDK.mainInstance().isLoggingEnabled = true
```

## Complete Code Example

Here's a runnable code example that covers everything in this quickstart guide.

```swift
import vue_sdk_ios

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    ...

    VueSDK.initialize(token: "YOUR_TOKEN",baseUrl: "GIVEN_VUE_BASE_URL");

    VueSDK.mainInstance().track(
 	eventName: "YOUR_CUSTOM_EVENT_NAME",
 	Properties: ["YOUR_KEY" : "YOUR_VALUE"]
    );

    VueSDK.mainInstance().getRecommendationsByPage(
        pageReference: "YOUR_PAGE_NAME",
        properties: RecommendationRequest(
            catalogs: [:]
        ),
        correlationID: "UNIQUE_CORRRELATION_ID"
    ) { response, error in
        if error != nil {
            // Handle Error case
        } else {
            // Handle Success case
        }
    }

    ...
}
```

## I want to know more!

Have any questions? Reach out to SDK [Support](https://support.getblox.ai/docs/cli) to speak to someone smart, quickly.
