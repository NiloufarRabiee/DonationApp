import SwiftUI
import CoreImage.CIFilterBuiltins

struct ProfilePage: View {
    @State private var username: String = "Niloufar Rabiee"
    @State private var email: String = "rabiee.nilooo@gmail.com"
    @State private var phoneNumber: String = "+393334981604"
    @State private var role: String = "App Developer"
    @State private var experience: String = "1 Year"
    @State private var reviews: String = "215€ Donations"
    @State private var showQRDetail = false

    // Links for QR Code
    private let urls = [
        "https://www.linkedin.com/feed/?trk=guest_homepage-basic_google-one-tap-submit",
        "https://www.instagram.com/_lily_springgirl_/profilecard/?igsh=eWtvODJ0aHc0eTh5",
        "https://github.com/NiloufarRabiee"
    ]
    @State private var currentIndex = 0
    @State private var timer: Timer? = nil

    var body: some View {
        NavigationView {
            ZStack {
                // Dark Background
                Color.black
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    // MARK: - Header Section
                    HStack {
                        Text("Profile")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Spacer()

                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    // MARK: - Profile Image and Info
                    VStack(spacing: 10) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.white)

                        Text(username)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text(email)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text(phoneNumber)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        HStack(spacing: 4) {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .frame(width: 14, height: 14)
                            }
                            Text("5.0")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1).blur(radius: 2))
                    .cornerRadius(15)

                    // MARK: - Info Cards
                    HStack(spacing: 20) {
                        infoCard(title: experience, subtitle: "Activity")
                        Divider()
                            .frame(height: 50)
                            .background(Color.gray.opacity(0.4))
                        infoCard(title: reviews, subtitle: "Donations")
                    }
                    .padding()
                    .background(Color.white.opacity(0.1).blur(radius: 2))
                    .cornerRadius(15)

                    // MARK: - QR Code Section
                    VStack(spacing: 15) {
                        Image(uiImage: generateQRCode(from: urls[currentIndex]))
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 160, height: 160)
                            .background(Color.white.opacity(0.1).blur(radius: 5))
                            .cornerRadius(12)
                            .padding()
                            .onTapGesture {
                                withAnimation {
                                    self.showQRDetail.toggle() // Trigger the pop-up transition
                                }
                            }

                        HStack(spacing: 50) {
                            circleButton(action: {}, icon: "info.circle")
                            circleButton(action: {}, icon: "square.and.arrow.up")
                        }
                    }

                    Spacer()
                }
                .padding()
                
                // Show QR Detail Page with pop-up transition
                if showQRDetail {
                    QRDetailPage(qrCodeLink: urls[currentIndex], showQRDetail: $showQRDetail)
                        .transition(.move(edge: .bottom))  // Pop-up transition from the bottom
                        .zIndex(1)
                }
            }
            .onAppear {
                // Start the timer when the view appears
                startTimer()
            }
            .onDisappear {
                // Invalidate the timer when the view disappears
                timer?.invalidate()
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: - Start Timer (every 5 seconds)
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            updateIndex()
        }
    }
    
    // MARK: - Update the QR Code Index
    private func updateIndex() {
        currentIndex = (currentIndex + 1) % urls.count
    }

    // MARK: - Reusable Views
    @ViewBuilder
    private func infoCard(title: String, subtitle: String) -> some View {
        VStack {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }

    @ViewBuilder
    private func circleButton(action: @escaping () -> Void, icon: String) -> some View {
        Button(action: action) {
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(.white)
                )
                .shadow(color: Color.purple.opacity(0.3), radius: 5, x: 0, y: 2)
        }
    }

    // MARK: - QR Code Generator
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}

struct QRDetailPage: View {
    var qrCodeLink: String
    @Binding var showQRDetail: Bool
    
    var body: some View {
        VStack {
            Text("QR Code Details")
                .font(.title)
                .foregroundColor(.white)
                .padding()

            Image(uiImage: generateQRCode(from: qrCodeLink))
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding()

            Button(action: {
                withAnimation {
                    showQRDetail.toggle() // Close the pop-up when button is tapped
                }
            }) {
                Text("Close")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
            }
        }
        .background(Color.black)
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding()
        .transition(.move(edge: .bottom)) // Slide up from the bottom
    }

    // MARK: - QR Code Generator (to generate QR code)
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
