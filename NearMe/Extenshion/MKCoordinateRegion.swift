//
//  MKCoordinateRegion.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 20/09/24.
//

import Foundation
import MapKit

extension MKCoordinateRegion: @retroactive Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        if lhs.center.latitude == rhs.center.latitude && lhs.span.latitudeDelta == rhs.span.latitudeDelta && lhs.span.longitudeDelta == rhs.span.longitudeDelta {
            return true
        }
        
        else {
            return false
        }
    }
}
