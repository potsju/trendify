import Foundation
import Combine
import SwiftUI

class TrendViewModel: ObservableObject {
    @Published var trends: [Trend] = []
    @Published var isLoading: Bool = false
    @Published var selectedTimeRange: TimeRange = .day
    @Published var chartData: ChartData = ChartData()
    
    private var cancellables = Set<AnyCancellable>()
    
    enum TimeRange {
        case day, week, month
    }
    
    struct ChartData {
        var topHashtags: [(String, Double)] = []
        var topKeywords: [(String, Double)] = []
        var viewershipData: [(String, Double)] = []
    }
    
    func fetchTrends() {
        isLoading = true
        // Simulate API call with mock data
        let mockTrend = Trend(
            id: UUID(),
            title: "Viral Dance Challenge",
            description: "New trending dance move",
            imageUrl: "https://example.com/image1.jpg",
            popularityScore: 98.5,
            genre: "Dance",  
            statistics: TrendStatistics(
                hashtags: [
                    HashtagData(name: "#dancechallenge", count: 1000000, viewCount: 5000000),
                    HashtagData(name: "#viral", count: 800000, viewCount: 4000000)
                ],
                keywords: [
                    KeywordData(term: "dance", searchVolume: 500000, growthRate: 25.5),
                    KeywordData(term: "challenge", searchVolume: 400000, growthRate: 20.0)
                ],
                engagement: EngagementMetrics(
                    totalViews: 10000000,
                    totalWatchTimeMinutes: 500000,
                    averageWatchDuration: 2.5,
                    engagementRate: 8.5
                )
            )
        )
        
        self.trends = [mockTrend]
        self.updateChartData(from: [mockTrend])
        self.isLoading = false
    }
    
    private func updateChartData(from trends: [Trend]) {
        var hashtagCounts: [String: Double] = [:]
        var keywordCounts: [String: Double] = [:]
        
        trends.forEach { trend in
            trend.statistics.hashtags.forEach { hashtag in
                hashtagCounts[hashtag.name, default: 0] += Double(hashtag.viewCount)
            }
            trend.statistics.keywords.forEach { keyword in
                keywordCounts[keyword.term, default: 0] += Double(keyword.searchVolume)
            }
        }
        
        chartData.topHashtags = Array(hashtagCounts.sorted { $0.value > $1.value }.prefix(5))
        chartData.topKeywords = Array(keywordCounts.sorted { $0.value > $1.value }.prefix(5))
    }
}
