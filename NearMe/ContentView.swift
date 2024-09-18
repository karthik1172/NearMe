//
//  ContentView.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 18/09/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var query: String = ""
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    var body: some View {
        ZStack {
            Map()
                .sheet(isPresented: .constant(true), content: {
                    VStack {
                        TextField("Search", text: $query)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                            .onSubmit {
                                // Core fired when you returned in textfield.
                            }
                        Spacer()
                    }
                    .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                })
        }
    }
}

#Preview {
    ContentView()
}
