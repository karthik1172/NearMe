//
//  SwiftUIView.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 25/09/24.
//

import SwiftUI
import MapKit

struct ActionButton: View {
    let mapItem: MKMapItem
    
    var body: some View {
        HStack {
            if let phone = mapItem.phoneNumber {
                Button {
                    if let phone = mapItem.phoneNumber {
                        let numericPH = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                        makeCall(phone: numericPH)
                    }
                } label: {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Call")
                    }
                }
                .buttonStyle(.bordered)
            }
            
            Button {
                MKMapItem.openMaps(with: [mapItem])
            } label: {
                HStack {
                    Image(systemName: "car.circle.fill")
                    Text("Take me there")
                }
            }
            .buttonStyle(.bordered)
            .tint(.green)
            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    ActionButton(mapItem: PreviewData.apple)
}
