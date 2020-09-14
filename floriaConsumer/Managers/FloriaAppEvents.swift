//
//  FloriaAppEvents.swift
//  floriaConsumer
//
//  Created by arabpas on 9/7/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import Foundation
import FBSDKCoreKit


class FloriaAppEvents {
    
    //
    static func logCompleteRegistrationEvent(registrationMethod: String = "mobile") {
        let parameters = [
            AppEvents.ParameterName.registrationMethod.rawValue: registrationMethod
        ]

        AppEvents.logEvent(.completedRegistration, parameters: parameters)
    }
    //
    static func logViewContentEvent(contentID: String, contentType: String, currency: String, valueToSum: Double) {
        let parameters = [
            AppEvents.ParameterName("ContentID").rawValue: contentID,
            AppEvents.ParameterName("ContentType").rawValue: contentType,
            AppEvents.ParameterName("Currency").rawValue: currency
        ]

        AppEvents.logEvent(.init("ViewContent"), valueToSum: valueToSum, parameters: parameters)
    }
    //
    static func logAddToWishlistEvent(contentID: String, contentType: String, currency: String, valueToSum: Double) {
        let parameters = [
            AppEvents.ParameterName("ContentID").rawValue: contentID,
            AppEvents.ParameterName("ContentType").rawValue: contentType,
            AppEvents.ParameterName("Currency").rawValue: currency
        ]

        AppEvents.logEvent(.init("AddToWishlist"), valueToSum: valueToSum, parameters: parameters)
    }
    //
    static func logInitiateCheckoutEvent(contentID: String, contentType: String, currency: String, valueToSum: Double) {
        let parameters = [
            AppEvents.ParameterName("ContentID").rawValue: contentID,
            AppEvents.ParameterName("ContentType").rawValue: contentType,
            AppEvents.ParameterName("Currency").rawValue: currency
        ]

        AppEvents.logEvent(.init("InitiateCheckout"), valueToSum: valueToSum, parameters: parameters)
    }
    //
    static func logRateEvent(contentType: String, maxRatingValue: Int,ratingGiven: Double) {
        
        let parameters = [
            AppEvents.ParameterName.contentType.rawValue: contentType,
            AppEvents.ParameterName.maxRatingValue.rawValue: NSNumber(value:maxRatingValue)
            ] as [String : Any]

        AppEvents.logEvent(.rated, valueToSum: ratingGiven, parameters: parameters)
    }
    //
    static func logPurchaseEvent(contentID: String, contentType: String, currency: String, valueToSum: Double) {
        let parameters = [
            AppEvents.ParameterName("ContentID").rawValue: contentID,
            AppEvents.ParameterName("ContentType").rawValue: contentType,
            AppEvents.ParameterName("Currency").rawValue: currency
        ]

        AppEvents.logEvent(.init("purchase"), valueToSum: valueToSum, parameters: parameters)
    }
    //
    static func logAddPaymentInfoEvent() {
        AppEvents.logEvent(.init("addPaymentInfo"))
    }
}
