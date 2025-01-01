import SwiftUI
import Charts

struct AnalyticsView: View {
    let trend: Trend
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Your existing analytics content
                
                // Add these new chart sections
                ChartView(
                    title: "Top Hashtags",
                    data: trend.statistics.hashtags.map {
                        ($0.name, Double($0.viewCount))
                    }
                )
                
                ChartView(
                    title: "Top Keywords",
                    data: trend.statistics.keywords.map {
                        ($0.term, Double($0.searchVolume))
                    }
                )
                
                TrendStatsCard(trend: trend)
            }
            .padding()
        }
        .navigationTitle("Trend Analytics")
    }
}

struct ChartView: View {
    let title: String
    let data: [(String, Double)]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            Chart {
                ForEach(data, id: \.0) { item in
                    SectorMark(
                        angle: .value("Value", item.1),
                        innerRadius: .ratio(0.618),
                        angularInset: 1.5
                    )
                    .foregroundStyle(by: .value("Category", item.0))
                }
            }
            .frame(height: 200)
        }
    }
}
struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnalyticsView(trend: Trend(
                title: "Sample Trend",
                description: "Sample description",
                imageUrl: "https://example.com/image.jpg",
                popularityScore: 98.5,
                genre: "Dance",
                statistics: TrendStatistics(
                    hashtags: [
                        HashtagData(name: "#sample", count: 1000, viewCount: 5000),
                        HashtagData(name: "#test", count: 800, viewCount: 4000)
                    ],
                    keywords: [
                        KeywordData(term: "sample", searchVolume: 5000, growthRate: 25.5),
                        KeywordData(term: "test", searchVolume: 4000, growthRate: 20.0)
                    ],
                    engagement: EngagementMetrics(
                        totalViews: 10000,
                        totalWatchTimeMinutes: 5000,
                        averageWatchDuration: 2.5,
                        engagementRate: 8.5
                    )
                )
            ))
        }
        .previewDisplayName("Analytics View")
    }
}
