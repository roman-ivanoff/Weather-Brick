//
//  LocationErrorProtocol.swift
//  Weather
//
//  Created by Roman Ivanov on 18.08.2022.
//

import Foundation

protocol LocationErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}
