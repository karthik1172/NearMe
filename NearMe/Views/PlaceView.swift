//
//  PlaceView.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 23/09/24.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    
    let mapItem: MKMapItem
    private var address: String {
        let placemark = mapItem.placemark
        return "\(placemark.thoroughfare ?? ""), \(placemark.subThoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(mapItem.name ?? "")
                .font(.title3)
            
            Text(address)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

#Preview {
    PlaceView(mapItem: PreviewData.apple)
}
