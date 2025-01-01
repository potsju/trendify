import SwiftUI

struct TrendFeedView: View {
    @StateObject private var viewModel = TrendViewModel()
    let selectedGenres: [String]  // Add this line
    
    // Add filtered trends computed property
    var filteredTrends: [Trend] {
        viewModel.trends.filter { trend in
            selectedGenres.contains(trend.genre)
        }
    }
    
    var body: some View {
        VStack {
            // Add genres chips at the top
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(selectedGenres, id: \.self) { genre in
                        GenreChip(genre: genre)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 8)
            
            if viewModel.isLoading {
                ProgressView("Loading trends...")
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredTrends) { trend in  // Change to filteredTrends
                            NavigationLink(destination: AnalyticsView(trend: trend)) {
                                VStack {
                                    HStack {
                                        AsyncImage(url: URL(string: trend.imageUrl)) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 50, height: 50)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 50, height: 50)
                                            case .failure(_):
                                                Image(systemName: "photo")
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.gray.opacity(0.3))
                                            @unknown default:
                                                Image(systemName: "photo")
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.gray.opacity(0.3))
                                            }
                                        }
                                        .clipShape(Circle())
                                        
                                        VStack(alignment: .leading) {
                                            Text(trend.title)
                                                .font(.headline)
                                            Text(trend.description)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    
                                    TrendStatsCard(trend: trend)
                                        .padding(.top, 8)
                                }
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .onAppear {
            viewModel.fetchTrends()
        }
        .navigationTitle("Trending Now")
    }
}

// Add GenreChip view
struct GenreChip: View {
    let genre: String
    
    var body: some View {
        Text(genre)
            .font(.subheadline)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.1))
            .foregroundColor(.blue)
            .cornerRadius(16)
    }
}

// Update preview provider to include selected genres
struct TrendFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TrendFeedView(selectedGenres: ["Dance", "Comedy", "Music"])
        }
        .previewDisplayName("Trend Feed")
    }
}
