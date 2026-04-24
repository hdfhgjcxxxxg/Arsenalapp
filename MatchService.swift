import Foundation

struct Match: Identifiable {
    let id = UUID()
    let home: String
    let away: String
    let homeId: Int
    let awayId: Int
    let date: Date
}

class MatchService {
    static let shared = MatchService()

    func fetchMatches(completion: @escaping ([Match]) -> Void) {
        let url = URL(string: "https://api.football-data.org/v4/teams/57/matches?status=SCHEDULED")!
        var req = URLRequest(url: url)
        req.addValue("YOUR_API_KEY", forHTTPHeaderField: "X-Auth-Token")

        URLSession.shared.dataTask(with: req) { data, _, _ in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let matchesJSON = json["matches"] as? [[String: Any]]
            else {
                completion([])
                return
            }

            let formatter = ISO8601DateFormatter()

            let matches = matchesJSON.map {
                Match(
                    home: ($0["homeTeam"] as? [String: Any])?["name"] as? String ?? "",
                    away: ($0["awayTeam"] as? [String: Any])?["name"] as? String ?? "",
                    homeId: ($0["homeTeam"] as? [String: Any])?["id"] as? Int ?? 0,
                    awayId: ($0["awayTeam"] as? [String: Any])?["id"] as? Int ?? 0,
                    date: formatter.date(from: $0["utcDate"] as? String ?? "") ?? Date()
                )
            }

            DispatchQueue.main.async {
                completion(matches)
            }
        }.resume()
    }
}
