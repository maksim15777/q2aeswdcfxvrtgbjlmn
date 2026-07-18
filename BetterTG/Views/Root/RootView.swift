// RootView.swift

import SwiftUI
import TDLibKit

struct RootView: View {
    
    @StateObject var viewModel = RootViewModel()
    @StateObject var settings = SettingsViewModel()
    @StateObject var starsVM = StarsViewModel()
    
    @State var showConfirmChatDelete = false
    @State var deleteChatForAllUsers = false
    @State var confirmedChat: Chat?
    
    @State var query = ""
    @State var queryArchived = ""
    
    @State var showArchivedChats = false
    @State var showSettings = false
    
    @Namespace var namespace
    
    let chatId = "chatId"
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Group {
            if let loggedIn = viewModel.loggedIn {
                if loggedIn {
                    bodyView
                } else {
                    LoginView()
                }
            } else {
                bodyPlaceholder
            }
        }
        .overlay {
            if starsVM.showSuccessAnimation {
                StarsPurchaseSuccessView(amount: starsVM.purchasedAmount)
                    .transition(.opacity)
            }
        }
        .zIndex(999)
        .animation(.easeInOut(duration: 0.3), value: starsVM.showSuccessAnimation)
        .transition(.opacity)
        .animation(value: viewModel.loggedIn)
        .environmentObject(viewModel)
        .environmentObject(settings)
        .environmentObject(starsVM)
        .onAppear {
            if viewModel.namespace == nil {
                viewModel.namespace = namespace
            }
        }
    }
}
