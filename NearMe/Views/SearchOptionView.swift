//
//  SearchOptionView.swift
//  NearMe
//
//  Created by Karthik Rashinkar on 24/09/24.
//

import SwiftUI

struct SearchOptionView: View {
    let searchOptions = ["Restaurants":"fork.knife", "Coffee":"cup.and.saucer.fill", "Hospital":"cross.case.fill", "Grocery":"cart.fill", "Movies":"film", "Books":"book", "Sports":"figure.australian.football", "Shopping":"bag.fill", "Gym": "dumbbell.fill", "Restroom": "toilet.fill"]
    
    let onSelected: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(searchOptions.sorted(by: >), id: \.key) { key, value in
                    Button {
                        //action
                        onSelected(key)
                    } label: {
                        HStack{
                            Image(systemName: value)
                            Text(key)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 236/255, green: 240/255, blue: 241/255, opacity: 1.0))
                    .foregroundStyle(.black)
                    .padding(4)
                }
            }
        }
    }
}

#Preview {
    SearchOptionView(onSelected: {_ in})
}

