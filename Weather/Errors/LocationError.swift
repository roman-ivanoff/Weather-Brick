//
//  LocationError.swift
//  Weather
//
//  Created by Roman Ivanov on 30.07.2022.
//

import Foundation

struct LocationError: LocationErrorProtocol {
    var title: String?
    var code: Int
    var errorDescription: String? { description }
    var failureReason: String? { description }

    private var description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Location Error"
        self.description = description
        self.code = code
    }
}
