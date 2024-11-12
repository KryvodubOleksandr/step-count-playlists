//
//  RootView.swift
//  StepCountPlaylists
//
//  Created by Alexander Sharko on 12.11.2024.
//

import SwiftUI

struct RootView: View {
    @StateObject var rootVM = ViewModelProvider.root
    
    var body: some View {
        Group {
            switch rootVM.authorizationStatus {
            case .notDetermined:
                authorizationNotDeterminedView
            case .sharingDenied:
                authorizationDeniedView
            default:
                PlaylistView()
            }
        }
        .multilineTextAlignment(.center)
    }
}

//MARK - authorizationNotDeterminedView
private extension RootView {
    var authorizationNotDeterminedView: some View {
        Text("")
            .task {
                do {
                    try await rootVM.getHealthKitAuthorization()
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}
 
//MARK - authorizationDeniedView
private extension RootView {
    var authorizationDeniedView: some View {
        Text("Access to your health data was denied.\nOpen Health App -> Sharing -> Apps -> StepCountPlaylists -> Turn On All.\nRelaunch the app.")
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.4))
            }
            .padding()
    }
}

#Preview {
    RootView()
}
