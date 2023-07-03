<p align="center">
  <img src="https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco,dpr_1/v1441713939/o8bplvbhmr2jzkhynltt.png" alt="MSD Swift Library"/>
</p>

# Table of Contents

<!-- MarkdownTOC -->

- [Overview](#overview)
- [Quick Start Guide](#quick-start-guide)
  - [Install MSD](#1-install-msd)
  - [Initialize MSD](#2-initialize-msd)
  - [Discover Events](#3-discover-events)
  - [Track Event](#4-track-event)
  - [Get Recommendations](#5-get-recommendations)
  - [Set User](#6-set-user)
  - [Reset User Profile](#7-reset-user-profile)
  - [MSD debugging and logging](#8-msd-debugging-and-logging)
  - [Complete Code Example](#complete-code-example)
- [I want to know more!](#i-want-to-know-more)

<!-- /MarkdownTOC -->

<a name="introduction"></a>

# Overview

Welcome to the official MSD Swift Library

# Quick Start Guide

## 1. Install MSD

You will need your project token for initializing your library. You can get your project token from [project settings](https://www.madstreetden.com/contact-us/).

### Using CocoaPods

1. If this is your first time using CocoaPods, Install CocoaPods using `gem install cocoapods`. Otherwise, continue to Step 3.
2. Run `pod setup` to create a local CocoaPods spec mirror.
3. Create a Podfile in your Xcode project directory by running `pod init` in your terminal, edit the Podfile generated, and add the following line: `pod 'MSD'`.
4. Run `pod install` in your Xcode project directory. CocoaPods should download and install the MSD library, and create a new Xcode workspace. Open up this workspace in Xcode or typing `open *.xcworkspace` in your terminal.

## 2. Initialize MSD

Import `msd_sdk` into AppDelegate.swift, and initialize `MSD` within `application:didFinishLaunchingWithOptions:`

```swift
import msd_sdk

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    ...
    let msdClient = MSD.initialize(
    token: "YOUR_TOKEN",
    baseUrl: "GIVEN_MSD_BASE_URL"
    )
    ...
}
```

Maintain this `msdClient` as a singleton object so that it can be used to call other sdk functions.

## 3. Discover Events

To ensure accurate and comprehensive event tracking, it is recommended to call the `discoverEvents` function before invoking the track function in your SDK integration. The `discoverEvents` function retrieves the essential information related to track events, such as event names, properties, and default properties. This step allows you to populate the necessary data and configure the event tracking accordingly.

```swift
msdClient.discoverEvents(success: { (response) in
            //Handle success
        }, failure: { error in
            //Handle failure
        })
```

## 4. Track Event

To track custom events using our SDK, you can utilize the `track` function. This function allows you to capture specific actions or interactions within your application and gather valuable data for analysis.

Here's an example of how to use the track function:

```swift
msdClient.track(
    eventName: "YOUR_CUSTOM_EVENT_NAME",
    Properties: ["YOUR_KEY" : "YOUR_VALUE"],
    correlationID: "UNIQUE_CORRRELATION_ID"
 );
```

**Note:** The `correlationId` is an optional parameter that allows you to provide a unique correlation ID for the event. It is important to ensure that the `correlationId` is unique across each pages for both search and track API calls.

The SDK automatically includes several properties when tracking events, eliminating the need for users to manually add them. These properties are essential for comprehensive event tracking and provide valuable insights into user interactions. Here are some of the properties that are automatically added by the SDK:

<!-- TABLE_GENERATE_START -->

| key         | Description                            | Example Value                        |
| ----------- | -------------------------------------- | ------------------------------------ |
| `blox_uuid` | Device UUID generated                  | 5fbeac07-f385-4145-a690-e98571ae985e |
| `platform`  | Platform of the user                   | ios                                  |
| `medium`    | Medium from where requests are sent    | application                          |
| `referrer`  | same values as platform for mobile app | ios                                  |
| `user_id`   | user id passed while calling setUser   | 81bf1152-ce89-4954-b38e-f81875258f6e |
| `url`       | Bundle id of the application           | com.example.myapp                    |

<!-- TABLE_GENERATE_END -->

## 5. Get Recommendations

The getRecommendation functions in the SDK allows you to retrieve recommendations based on specific search criteria and properties. This function provides a convenient way to fetch recommendations and receive the results asynchronously.

### 1. Get Recommendations by Page

```swift
 msdClient.getRecommendationsByPage(
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

```

### 2. Get Recommendations by Module

```swift
 msdClient.getRecommendationsByModule(
    moduleReference: "YOUR_MODULE_NAME",
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

```

### 3. Get Recommendations by Strategy

```swift
msdClient.getRecommendationsByStrategy(
    strategyReference: "YOUR_STRATEGY_NAME",
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

```

**Note:** The `correlationId` is an optional parameter that allows you to provide a unique correlation ID for the search request. It is important to ensure that the `correlationId` is unique across pages for both search and track API calls.

The SDK automatically includes several properties when tracking events, eliminating the need for users to manually add them. Here are some of the properties that are automatically added by the SDK:

<!-- TABLE_GENERATE_START -->

| key         | Description                            | Example Value                        |
| ----------- | -------------------------------------- | ------------------------------------ |
| `blox_uuid` | Device UUID generated                  | 5fbeac07-f385-4145-a690-e98571ae985e |
| `platform`  | Platform of the user                   | ios                                  |
| `medium`    | Medium from where requests are sent    | application                          |
| `referrer`  | same values as platform for mobile app | ios                                  |
| `user_id`   | user id passed while calling setUser   | 81bf1152-ce89-4954-b38e-f81875258f6e |
| `url`       | Bundle id of the application           | com.example.myapp                    |

<!-- TABLE_GENERATE_END -->

## 6. Set User

The `setUser` function in the SDK allows you to associate a user ID with subsequent API calls after the user has logged in. This user ID is used to track user-specific events and behaviors, providing personalized experiences and accurate analytics.

```swift
 msdClient.setUser(userId: "YOUR_USER_ID")
```

## 7. Reset User Profile

The `resetUserProfile` function in the SDK allows you to clear the user information and reset the SDK state when the user logs out of your application. This ensures that any user-specific data and tracking are cleared and no longer associated with the user.

```swift
 msdClient.resetUserProfile()
```

## 8. MSD debugging and logging

The SDK provides internal logging capabilities for debugging purposes. By default, the logging feature is disabled.

To enable internal logging, set `isLoggingEnabled` to `true`:

```swift
msdClient.isLoggingEnabled = true
```

## Complete Code Example

Here's a runnable code example that covers everything in this quickstart guide.

```swift
import msd_sdk

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    ...

    let msdClient =  MSD.initialize(
 	token: "YOUR_TOKEN",
 	baseUrl: "https://api.msd.com"
    );

    msdClient.track(
 	eventName: "YOUR_CUSTOM_EVENT_NAME",
 	Properties: ["YOUR_KEY" : "YOUR_VALUE"]
    );

    msdClient.getRecommendationsByPage(
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

No worries, here are some links that you will find useful:

- **[Advanced iOS - Swift Guide](https://www.madstreetden.com/industry-solutions/)**
- **[Sample app](https://github.com/Jiju-keyvalue/msd-sdk-ios-sample-app/tree/dev)**

Have any questions? Reach out to MSD [Support](https://www.madstreetden.com/contact-us/) to speak to someone smart, quickly.
