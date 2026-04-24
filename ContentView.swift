import SwiftUI

struct ContentView: View {
    @State private var matches: [Match] = []

    var body: some View {
        NavigationView {
            List(matches) { match in
                HStack {
                    AsyncImage(url: logoURL(match.homeId)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 30, height: 30)

                    Text(match.home)

                    Text("vs")

                    Text(match.away)

                    AsyncImage(url: logoURL(match.awayId)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 30, height: 30)
                }
            }
        }
        .onAppear {
            MatchService.shared.fetchMatches {
                matches = $0
            }
        }
    }

    func logoURL(_ id: Int) -> URL? {
        URL(string: "https://crests.football-data.org/\(id).png")
    }
}
