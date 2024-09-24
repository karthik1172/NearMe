//
//  PlaceListView.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 24/09/24.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let mapItems: [MKMapItem]
    
    private var sortedItems: [MKMapItem] {
        
        // getting users location
        guard let userLocation = LocationManager.shared.manager.location else { return mapItems }
        
        // sorting smallest place from users location
        return mapItems.sorted { lhs, rhs in
            
            guard let lhsLocation = lhs.placemark.location, let rhsLocation = rhs.placemark.location else { return false
            }
            
            let lhsDistance = userLocation.distance(from: lhsLocation)
            let rhsDistance = userLocation.distance(from: rhsLocation)
            
            return lhsDistance < rhsDistance
        }
    }
    
    var body: some View {
        List(mapItems, id: \.self) { mapItem in
            PlaceView(mapItem: mapItem)
        }
    }
}

#Preview {
    PlaceListView(mapItems: [PreviewData.apple])
}

