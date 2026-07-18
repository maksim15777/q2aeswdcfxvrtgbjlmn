// SettingsView.swift

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var starsVM: StarsViewModel
    @State private var showStars = false
    
    var body: some View {
        List {
            // --- Мои звёзды ---
            Section {
                Button {
                    showStars = true
                } label: {
                    HStack(spacing: 14) {
                        // Orange icon with star
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.orange, Color(hue: 0.08, saturation: 1, brightness: 0.95)],
                                        startPoint: .topLeading, endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 36, height: 36)
                            Image(systemName: "star.fill")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        
                        Text("Мои звёзды")
                            .font(.system(size: 17))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        // Balance badge
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(.yellow)
                            Text(NumberFormatter.starsFormatter.string(from: NSNumber(value: starsVM.balance)) ?? "\(starsVM.balance)")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                                .contentTransition(.numericText())
                                .animation(.spring(), value: starsVM.balance)
                        }
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.secondary.opacity(0.6))
                    }
                    .padding(.vertical, 2)
                }
                .buttonStyle(.plain)
            }
            .listRowBackground(
                Rectangle().fill(.thinMaterial)
            )
            
            // --- App settings ---
            Section {
                SpacingAround(axis: .horizontal) {
                    Text("Change settings for the app here")
                }
            } header: {
                Text("Settings")
                    .font(.headline)
            }
            .listRowBackground(Color.clear)
            
            customSection(header: "Chats List") {
                Toggle("Archived Chats", isOn: $settings.showArchivedChatsButton)
            }
            
            customSection(header: "Chat") {
                Toggle("Albums", isOn: $settings.showAlbums)
                Toggle("Photos", isOn: $settings.showPhotos)
                Toggle("Animojis", isOn: $settings.showAnimojis)
                Toggle("Voice Notes", isOn: $settings.showVoiceNotes)
                Toggle("Replies", isOn: $settings.showReplies)
                Toggle("Forwarded From", isOn: $settings.showForwardedFrom)
                Toggle("Edited", isOn: $settings.showEdited)
            }
        }
        .listStyle(.automatic)
        .scrollContentBackground(.hidden)
        .fullScreenCover(isPresented: $showStars) {
            TelegramStarsView()
                .environmentObject(starsVM)
        }
    }
    
    @ViewBuilder func customSection<Content: View>(
        header: String? = nil,
        footer: String? = nil,
        @ViewBuilder _ content: () -> Content
    ) -> some View {
        Section {
            content()
        } header: {
            if let header {
                Text(header)
            }
        } footer: {
            if let footer {
                Text(footer)
            }
        }
        .listRowBackground(
            Rectangle()
                .fill(.thinMaterial)
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsViewModel())
            .environmentObject(StarsViewModel())
    }
}
