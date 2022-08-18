//
//  DegreeSymbolFormatter.swift
//  Weather
//
//  Created by Roman Ivanov on 18.08.2022.
//

import Foundation

enum DegreeSymbolFormatter {
    static func addDegreeSymbol(_ temp: Double) -> String {
        let measurementFormatter = MeasurementFormatter()
        let temperatureInKelvin = Measurement(value: temp, unit: UnitTemperature.kelvin)
        let temperature = temperatureInKelvin.converted(to: .celsius)
        measurementFormatter.unitStyle = .short
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        measurementFormatter.locale = Locale(identifier: "en_GB")
        measurementFormatter.numberFormatter.maximumFractionDigits = 0

        return measurementFormatter.string(from: temperature)
    }
}
