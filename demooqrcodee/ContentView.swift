//
//  ContentView.swift
//  demoqr
//
//  Created by Niloufar Rabiee on 11/12/24.
//

import SwiftUI
import QRCode
import UIKit

struct ContentView: View {
    private let urls = [
        "https://www.linkedin.com/feed/?trk=guest_homepage-basic_google-one-tap-submit",
        "https://www.instagram.com/_lily_springgirl_/profilecard/?igsh=eWtvODJ0aHc0eTh5",
        "https://github.com/NiloufarRabiee"
    ]
    @State private var currentIndex = 0

    var body: some View {
        TimelineView(.periodic(from: .now, by: 8 * 60 * 60)) { context in
            VStack {
                if let image = generateQRCode(for: urls[currentIndex]) {
                    image
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaledToFit()
                } else {
                    Text("No QR Code")
                }
            }
            .padding()
            .onChange(of: context.date) { _ in
                updateIndex()
            }
        }
    }

    private func updateIndex() {
        currentIndex = (currentIndex + 1) % urls.count
    }

    private func generateQRCode(for url: String) -> Image? {
        do {
            let cgImage = try QRCode.build
                .text(url)
                .generate.image(dimension: 600)
            return cgImageToSwiftUIImage(cgImage: cgImage)
        } catch {
            print("Error generating QR Code: \(error.localizedDescription)")
            return nil
        }
    }

    private func cgImageToSwiftUIImage(cgImage: CGImage) -> Image? {
        let uiImage = UIImage(cgImage: cgImage)
        return Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}


struct QRCodeContentView: View {

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                WelcomePage()
            }
            .badge(2)


            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsPage()
            }


            Tab("Profile", systemImage: "person.fill") {
                ProfilePage()
            }
            .badge("!")
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    QRCodeContentView()
}





