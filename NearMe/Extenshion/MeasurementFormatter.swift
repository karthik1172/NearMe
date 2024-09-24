//
//  MeasurementFormatter.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 24/09/24.
//

import Foundation

extension MeasurementFormatter {
    static var distance: MeasurementFormatter {
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .naturalScale
        formatter.locale = Locale.current
        return formatter
        
    }
}
