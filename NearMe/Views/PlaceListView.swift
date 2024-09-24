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
    
    var body: some View {
        List(mapItems, id: \.self) { mapItem in
            PlaceView(mapItem: mapItem)
        }
    }
}

#Preview {
    PlaceListView(mapItems: [PreviewData.apple])
}

