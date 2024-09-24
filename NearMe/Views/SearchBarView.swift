//
//  SearchBarView.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 24/09/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var search: String
    @Binding var isSearching: Bool
    
    var body: some View {
        VStack(spacing: -10) {
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onSubmit {
                    isSearching = true
                }
            SearchOptionView { searchTerm in
                search = searchTerm
                isSearching = true
            }
            .padding([.leading, .bottom], 10)
        }
    }
}

#Preview {
    SearchBarView(search: .constant("cofieee"), isSearching: .constant(true as Bool))
}
