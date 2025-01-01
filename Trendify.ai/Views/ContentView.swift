//
//  ContentView.swift
//  Trendify.ai
//
//  Created by Darren Choe on 12/31/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TrendFeedView(selectedGenres: ["Dance", "Music", "Gaming"])
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDisplayName("Content View")
    }
}
