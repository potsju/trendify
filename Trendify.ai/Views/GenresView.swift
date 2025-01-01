import SwiftUI

struct GenresView: View {
    @State private var selectedGenres = Set<String>()
    @State private var showTrendingPage = false
    
    let genres: [(name: String, emoji: String)] = [
        ("Dance", "💃"),
        ("Comedy", "😂"),
        ("Fashion", "👗"),
        ("Food", "🍳"),
        ("Gaming", "🎮"),
        ("Music", "🎵"),
        ("Sports", "⚽️"),
        ("Tech", "💻"),
        ("Beauty", "💄"),
        ("Education", "📚"),
        ("Fitness", "💪"),
        ("Travel", "✈️")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Choose Your Interests")
                    .font(.title)
                    .bold()
                    .padding(.top)
                
                Text("Select up to 3 genres")
                    .foregroundColor(.gray)
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(genres, id: \.name) { genre in
                            Button(action: {
                                toggleGenre(genre.name)
                            }) {
                                VStack(spacing: 8) {
                                    Text(genre.emoji)
                                        .font(.system(size: 40))
                                    Text(genre.name)
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedGenres.contains(genre.name) ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedGenres.contains(genre.name) ? Color.blue : Color.clear, lineWidth: 2)
                                )
                            }
                            .foregroundColor(selectedGenres.contains(genre.name) ? .blue : .primary)
                        }
                    }
                    .padding()
                }
                
                NavigationLink(
                    destination: TrendFeedView(selectedGenres: Array(selectedGenres)),
                    isActive: $showTrendingPage
                ) {
                    Button(action: {
                        if !selectedGenres.isEmpty {
                            showTrendingPage = true
                        }
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedGenres.isEmpty ? Color.gray : Color.blue)
                            .cornerRadius(10)
                    }
                }
                .disabled(selectedGenres.isEmpty)
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
            }
        }
    }
    
    private func toggleGenre(_ genre: String) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else if selectedGenres.count < 3 {
            selectedGenres.insert(genre)
        }
    }
}

struct GenresView_Previews: PreviewProvider {
    static var previews: some View {
        GenresView()
    }
}
