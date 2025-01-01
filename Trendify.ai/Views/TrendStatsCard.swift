//
//  TrendStatsCard.swift
//  Trendify.ai
//
//  Created by Darren Choe on 12/31/24.
//

import SwiftUI

struct TrendStatsCard: View {
    let trend: Trend
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Statistics")
                .font(.headline)
                .padding(.bottom, 4)
            
            HStack {
                StatBox(title: "Views", value: formatNumber(trend.statistics.engagement.totalViews))
                StatBox(title: "Watch Time", value: "\(trend.statistics.engagement.averageWatchDuration)m")
            }
            
            HStack {
                StatBox(title: "Engagement", value: "\(trend.statistics.engagement.engagementRate)%")
                StatBox(title: "Growth", value: "\(trend.statistics.keywords.first?.growthRate ?? 0)%")
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    
    private func formatNumber(_ number: Int64) -> String {
        let num = Double(number)
        let thousand = num / 1000
        let million = num / 1000000
        
        if million >= 1.0 {
            return String(format: "%.1fM", million)
        } else if thousand >= 1.0 {
            return String(format: "%.1fK", thousand)
        }
        return "\(number)"
    }
}

struct StatBox: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
struct TrendStatsCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TrendStatsCard(trend: Trend(
                title: "Sample Trend",
                description: "Sample description",
                imageUrl: "https://example.com/image.jpg",
                popularityScore: 98.5,
                genre: "Dance", // Add the genre parameter
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
                ))
            )
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Stats Card Light")
            
            TrendStatsCard(trend: Trend(
                title: "Sample Trend",
                description: "Sample description",
                imageUrl: "https://example.com/image.jpg",
                popularityScore: 98.5,
                genre: "Dance", // Add the genre parameter
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
                ))
            )
            .preferredColorScheme(.dark)
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Stats Card Dark")
        }
    }
}

