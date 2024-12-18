import SwiftUI

struct MoreFeatures: View {
    // Sample data
    let featuredItems = [
        ("star.fill", "Special Event", "Don't miss our upcoming event.", Color.orange),
        ("gift.fill", "Exclusive Gifts", "Get your exclusive gift now!", Color.blue),
        ("heart.fill", "Support", "Donate to our cause today.", Color.red),
        ("leaf.fill", "Eco-Friendly", "Join our eco-friendly initiative.", Color.green)
    ]
    
    let popularDonations = [
        ("Apple Tree Planting", "Help us plant trees", 75),
        ("Food Bank", "Feed the homeless in our community", 125),
        ("Child Education Fund", "Support education for children in need", 50)
    ]
    
    // State variables
    @State private var bounceStar = false
    @State private var bounceGift = false
    @State private var bounceHeart = false
    @State private var bounceLeaf = false

    // Environment to handle navigation
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // Background
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // Featured Section
                            horizontalScrollView(items: featuredItems, geometry: geometry)
                            
                            // Popular Donations Section
                            sectionTitle("Popular Donations")
                            donationList(items: popularDonations, geometry: geometry)
                            
                            // Upcoming Events Section
                            sectionTitle("Upcoming Events")
                            eventList(geometry: geometry)
                        }
                        .padding(.bottom, 80)
                        .padding(.top, 36)
                    }
                }
            }
            .navigationTitle("More Features")
            .navigationBarItems(leading: backButton) // Custom back button
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true) // Hide the default back button
        }
    }
    
    // MARK: - Section Title
    @ViewBuilder
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
    }
    
    // MARK: - Horizontal ScrollView
    @ViewBuilder
    private func horizontalScrollView(items: [(String, String, String, Color)], geometry: GeometryProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(items, id: \.1) { item in
                    featuredCard(image: item.0, title: item.1, subtitle: item.2, color: item.3, width: geometry.size.width)
                }
            }
            .padding([.leading, .bottom], 24)
        }
    }
    
    // MARK: - Featured Card
    @ViewBuilder
    private func featuredCard(image: String, title: String, subtitle: String, color: Color, width: CGFloat) -> some View {
        VStack {
            applyBounceAnimation(for: image, color: color)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
        .padding()
        .frame(width: width * 0.6)
        .background(Color.white.opacity(0.1).cornerRadius(12))
    }
    
    // MARK: - Popular Donations List
    @ViewBuilder
    private func donationList(items: [(String, String, Int)], geometry: GeometryProxy) -> some View {
        ForEach(items, id: \.0) { item in
            donationCard(title: item.0, subtitle: item.1, amount: item.2, width: geometry.size.width)
        }
    }
    
    // MARK: - Donation Card
    @ViewBuilder
    private func donationCard(title: String, subtitle: String, amount: Int, width: CGFloat) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            Spacer()
            Text("\(amount) Donations")
                .font(.subheadline)
                .foregroundColor(.yellow)
        }
        .padding()
        .frame(width: width * 0.9)
        .background(Color.white.opacity(0.1).cornerRadius(12))
        .padding(.horizontal, 16)
    }
    
    // MARK: - Upcoming Events List
    @ViewBuilder
    private func eventList(geometry: GeometryProxy) -> some View {
        VStack(spacing: 16) {
            eventCard(title: "Annual Charity Walk", date: "March , 2025", location: "Metro Paark Centrale", width: geometry.size.width)
            eventCard(title: "Food Donation Drive", date: "February 15, 2024", location: "Via Toledo", width: geometry.size.width)
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - Event Card
    @ViewBuilder
    private func eventCard(title: String, date: String, location: String, width: CGFloat) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text("Date: \(date)")
                .foregroundColor(.gray)
            Text("Location: \(location)")
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: width * 0.9)
        .background(Color.white.opacity(0.1).cornerRadius(12))
    }
    
    // MARK: - Bounce Animation Logic
    private func applyBounceAnimation(for icon: String, color: Color) -> some View {
        let animation: Animation = .spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)
        var isBouncing: Binding<Bool> {
            switch icon {
            case "star.fill": return $bounceStar
            case "gift.fill": return $bounceGift
            case "heart.fill": return $bounceHeart
            case "leaf.fill": return $bounceLeaf
            default: return .constant(false)
            }
        }
        
        return Image(systemName: icon)
            .font(.system(size: 40))
            .foregroundColor(color)
            .scaleEffect(isBouncing.wrappedValue ? 1.1 : 1)
            .animation(animation, value: isBouncing.wrappedValue)
            .onAppear {
                withAnimation { isBouncing.wrappedValue.toggle() }
            }
    }

    // MARK: - Custom Back Button
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                Text("Back")
                    .foregroundColor(.white)
            }
        }
    }
    
}

struct MoreFeatures_Previews: PreviewProvider {
    static var previews: some View {
        MoreFeatures()
            .preferredColorScheme(.dark)
    }
}
