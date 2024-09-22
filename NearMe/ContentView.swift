//
//  ContentView.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 18/09/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var query: String = "cofee"
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    @State private var locationManager = LocationManager.shared
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var isSearching: Bool = false
    @State private var mapItems:[MKMapItem] = []
    @State private var visibleRegion: MKCoordinateRegion?
    
    func search() async {
        do {
            mapItems = try await performSearch(searchTerm: query, visibleRegion: visibleRegion)
            print(mapItems)
            isSearching = false
        }
        catch {
            print(error)
        }
    }
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(mapItems, id: \.self) { mapItem in
                    Marker(item: mapItem)
                }
                UserAnnotation()
            }
            
            .onChange(of: locationManager.region, {
                withAnimation {
                    position = .region(locationManager.region)
                }
            })
            
            .sheet(isPresented: .constant(true), content: {
                VStack {
                    TextField("Search", text: $query)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .onSubmit {
                            isSearching = true
                        }
                    List(mapItems, id: \.self) { mapItem in
                        PlaceView(mapItem: mapItem)
                    }
                    Spacer()
                }
                .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            })
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        .task(id: isSearching) {
            await search()
        }
    }
}

#Preview {
    ContentView()
}
