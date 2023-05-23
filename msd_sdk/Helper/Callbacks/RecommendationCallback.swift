//
//  RecommendationCallback.swift
//  msd_sdk
//
//  Created by Julien on 22/05/23.
//

import Foundation

public protocol RecommendationCallback {
    func onRecommendationsFetched()
    func onError()
}
