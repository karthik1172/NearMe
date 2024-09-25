//
//  ContentView.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 18/09/24.
//

import SwiftUI
import MapKit

enum DisplayMode {
    case list
    case detail
}

struct ContentView: View {
    
    @State private var query: String = ""
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    @State private var locationManager = LocationManager.shared
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var isSearching: Bool = false
    @State private var mapItems:[MKMapItem] = []
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var selectedMapItem: MKMapItem?
    @State private var displayMode: DisplayMode = .list
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var route: MKRoute?
    
    func search() async {
        do {
            mapItems = try await performSearch(searchTerm: query, visibleRegion: visibleRegion)
            //print(mapItems)
            isSearching = false
        }
        catch {
            mapItems = []
            print(error.localizedDescription)
            isSearching = false
        }
    }
    
    func requestCalculateDirections() async {
        route = nil
        if let selectedMapItem {
            guard let currentUserLocation = locationManager.manager.location else { return }
            let startingMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentUserLocation.coordinate))
            
            self.route = await calculateDirection(from: startingMapItem, to: selectedMapItem)
            
        }
    }
    
    var body: some View {
        
        ZStack {
            Map(position: $position, selection: $selectedMapItem) {
                ForEach(mapItems, id: \.self) { mapItem in
                    Marker(item: mapItem)
                }
                UserAnnotation()
                
                if let route {
                    MapPolyline(route)
                        .stroke(.blue, lineWidth: 5)
                }
            }
            
            .onChange(of: locationManager.region, {
                withAnimation {
                    position = .region(locationManager.region)
                }
            })
            
            .sheet(isPresented: .constant(true), content: {
                VStack {
                    
                    switch displayMode {
                    case .list:
                        SearchBarView(search: $query, isSearching: $isSearching)
                        
                        PlaceListView(mapItems: mapItems, selectedMapItem: $selectedMapItem )
                    case .detail:
                        SelectedPlaceDetailView(mapItem: $selectedMapItem)
                            .padding()
                        
                        if selectedDetent == .large || selectedDetent == .medium {
                            
                            if let selectedMapItem {
                                ActionButton(mapItem: selectedMapItem)
                            }
                            
                            LookAroundPreview(initialScene: lookAroundScene)
                            
                        }
                            
                    }
                    
                    
                    
                    
                }
                .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            })
        }
        
        .onChange(of: selectedMapItem, {
            if selectedMapItem != nil {
                displayMode = .detail
            }
            else{
                displayMode = .list
            }
        })
        
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        
        .task(id: selectedMapItem) {
            lookAroundScene = nil
            if let selectedMapItem {
                let request = MKLookAroundSceneRequest(mapItem: selectedMapItem)
                lookAroundScene = try? await request.scene
                await requestCalculateDirections()
            }
        }
        
        .task(id: isSearching, {
            if isSearching {
                await search()
            }
        })
    }
}

#Preview {
    ContentView()
}
