//
//  Setting.swift
//  demooqrcodee
//
//  Created by Niloufar Rabiee on 16/12/24.
//

import SwiftUI

struct SettingsPage: View {
    @State private var dropdownExpanded = false

    var body: some View {
        ZStack {
            // Background Color (Dark Mode)
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // MARK: - Title
                HStack {
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 40)

                // MARK: - Settings Cards
                VStack(spacing: 16) {
                    settingsCard(icon: "clock.fill", title: "Donation History", subtitle: "Track your past donations", color: .orange)
                    settingsCard(icon: "repeat.circle.fill", title: "Repeat Donation Settings", subtitle: "Manage auto-donations", color: .blue)
                    settingsCard(icon: "bell.fill", title: "Reminders", subtitle: "Set up reminders", color: .purple)
                }

                // MARK: - Info Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Info")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading, 16)

                    VStack(spacing: 16) {
                        settingsCard(icon: "info.circle.fill", title: "About Us", subtitle: "Learn about us", color: .teal)
                        settingsCard(icon: "lock.fill", title: "Privacy Policy", subtitle: "View privacy terms", color: .red)
                        settingsCard(icon: "questionmark.circle.fill", title: "FAQs", subtitle: "Get answers to your questions", color: .green)
                    }
                }

                Spacer()

               
//                VStack {
//                    // Adding Rectangle Around the Dropdown Buttons at the Bottom of the Screen
//                    HStack(spacing: 40) {
//                        // Home Icon (Dropdown) with Rectangular background around menu options
//                        Menu {
//                            Button(action: {
//                                print("Home Tapped")
//                            }) {
//                                Label("Home", systemImage: "house.fill")
//                            }
//                            .padding()
//                            .background(Color.white.opacity(0.1))
//                            .cornerRadius(8)
//
//                            Button(action: {
//                                print("Explore Tapped")
//                            }) {
//                                Label("Explore", systemImage: "magnifyingglass")
//                            }
//                            .padding()
//                            .background(Color.white.opacity(0.1))
//                            .cornerRadius(8)
//                        } label: {
//                            VStack {
//                                Image(systemName: "house.fill")
//                                    .font(.title3) // Slightly smaller icon size
//                                    .foregroundColor(.white)
//                                Text("Home")
//                                    .font(.caption)
//                                    .foregroundColor(.white)
//                            }
//                        }
//
//                        // Settings Icon (Dropdown) with Rectangular background around menu options
//                        Menu {
//                            Button(action: {
//                                print("Settings Tapped")
//                            }) {
//                                Label("Settings", systemImage: "gearshape.fill")
//                            }
//                            .padding()
//                            .background(Color.white.opacity(0.1).blur(radius: 2))
//                            .cornerRadius(15)
//                            .frame(maxWidth: .infinity, alignment: .bottom)
//                        } label: {
//                            VStack {
//                                Image(systemName: "gearshape.fill")
//                                    .font(.title3) // Slightly smaller icon size
//                                    .foregroundColor(.white)
//                                Text("Settings")
//                                    .font(.caption)
//                                    .foregroundColor(.white)
//                            }
//                        }
//
//                        // Profile Icon (Dropdown) with Rectangular background around menu options
//                        Menu {
//                            Button(action: {
//                                print("Profile Tapped")
//                            }) {
//                                Label("Profile", systemImage: "person.fill")
//                            }
//                            .padding()
//                            .background(Color.white.opacity(0.1))
//                            .cornerRadius(8)
//                        } label: {
//                            VStack {
//                                Image(systemName: "person.fill")
//                                    .font(.title3) // Slightly smaller icon size
//                                    .foregroundColor(.white)
//                                Text("Profile")
//                                    .font(.caption)
//                                    .foregroundColor(.white)
//                            }
//                        }
//                    }
//                    .padding(.bottom, 10) // Adjusted for spacing
//                    .background(Color.black.opacity(0.9)) // Background for the rectangle around buttons
//                    .cornerRadius(20) // Rounded corners for the rectangle background
//                    .padding(.horizontal, 16) // Added horizontal padding to ensure the rectangle is aligned properly
//                }
            }
        }
    }

    // MARK: - Settings Card
    @ViewBuilder
    private func settingsCard(icon: String, title: String, subtitle: String, color: Color) -> some View {
        HStack {
            // Icon
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title2)
            }

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            Color.white.opacity(0.1)
                .blur(radius: 1)
                .cornerRadius(12)
        )
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
            .preferredColorScheme(.dark)
    }
}







