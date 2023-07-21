import Foundation

let userDefaults = UserDefaults.standard
let ios = "ios"
let mobile = "mobile"
let application = "application"

let LOG_INFO_TAG_EVENT_TRACKING = "Vue SDK Event Tracker"
let LOG_INFO_TAG_RECOMMENDATION = "Vue SDK Recommendation"
let LOG_INFO_TAG_DISCOVER_EVENTS = "Vue SDK Discover Events"
let LOG_INFO_TAG_GENERIC = "Vue SDK"

let DISCOVER_EVENTS_ENDPOINT = "/search/configs/metadata-pages?platform=ios"
let TRACK_ENDPOINT = "/events/track"
let SEARCH_RECOMMENDATION_ENDPOINT = "/search"
