//
//  Weather.swift
//  Weather
//
//  Created by Roman Ivanov on 28.07.2022.
//

import Foundation

struct Weather: Codable, Equatable {
    let id: Int
    let main: String
    let description: String
}
