//
//  SettingsView.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 06.05.25.
//
 
import SwiftfulUtilities
import SwiftUI

struct SettingsView: View {
    @State var presenter: SettingsPresenter

    var body: some View {
        List {
            accountSection
            purchaseSection
            applicationSection
        }
        .lineLimit(1)
        .minimumScaleFactor(0.4)
        .navigationTitle("Settings")
        .onAppear {
            presenter.setAnonymousAccountStatus()
        }
        .screenAppearAnalytics(name: "SettingsView")
    }
    
    private var accountSection: some View {
        Section {
            if presenter.isAnonymousUser {
//                Text("Save & back-up account")
//                    .rowFormatting()
//                    .anyButton(.highlight) {
//                        presenter.onCreateAccountPressed()
//                    }
//                    .removeListRowFormatting()
//            } else {
                Text("Sign out")
                    .rowFormatting()
                    .anyButton(.highlight) {
                        presenter.onSignOutPressed()
                    }
                    .removeListRowFormatting()
            }
            
            Text("Delete account")
                .foregroundStyle(.red)
                .rowFormatting()
                .anyButton(.highlight) {
                    presenter.onDeleteAccountPressed()
                }
                .removeListRowFormatting()
        } header: {
            Text("Account")
        }
    }
    
    private var purchaseSection: some View {
        Section {
            HStack(spacing: 8) {
                Text("Account status: \(presenter.isPremium ? "PREMIUM" : "FREE")")
                Spacer(minLength: 0)
                if presenter.isPremium {
                    Text("MANAGE")
                        .badgeButton()
                }
            }
            .rowFormatting()
            .anyButton(.highlight) {}
            .disabled(!presenter.isPremium)
            .removeListRowFormatting()
        } header: {
            Text("Purchases")
        }
    }
    
    private var applicationSection: some View {
        Section {
            Text("Rate us on the App Store!")
                .foregroundStyle(.blue)
                .rowFormatting()
                .anyButton(.highlight, action: {
                    presenter.onRatingsButtonPressed()
                })
                .removeListRowFormatting()
            
            Text("About us...")
                .rowFormatting()
                .anyButton(.highlight, action: {
                    presenter.onAboutUsPressed()
                })
                .removeListRowFormatting()
            
            HStack(spacing: 8) {
                Text("Version")
                Spacer(minLength: 0)
                Text(Utilities.appVersion ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListRowFormatting()
            
            HStack(spacing: 8) {
                Text("Build Number")
                Spacer(minLength: 0)
                Text(Utilities.buildNumber ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListRowFormatting()
            
            Text("Contact us")
                .foregroundStyle(.blue)
                .rowFormatting()
                .anyButton(.highlight, action: {
                    presenter.onContactUsPressed()
                })
                .removeListRowFormatting()
        } header: {
            Text("Application")
        } footer: {
            Text("Created by Swiftful Thinking.\nLearn more at www.swiftful-thinking.com.")
                .baselineOffset(6)
        }
    }
}

private struct RowFormattingViewModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(colorScheme.backgroundPrimary)
    }
}

private extension View {
    func rowFormatting() -> some View {
        modifier(RowFormattingViewModifier())
    }
}

#Preview("No auth") {
    let container = DevPreview.shared.container
    container.register(AuthManager.self, service: AuthManager(service: MockAuthService(user: nil)))
    container.register(UserManager.self, service: UserManager(services: MockUserServices(user: nil)))

    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    
    return RouterView { router in
        builder.settingsView(router: router)
    }
    .previewEnvironment()
}

#Preview("Anonymous") {
    let container = DevPreview.shared.container
    container.register(AuthManager.self, service: AuthManager(service: MockAuthService(user: UserAuthInfo.mock(isAnonymous: true))))
    container.register(UserManager.self, service: UserManager(services: MockUserServices(user: .mock)))

    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    
    return RouterView { router in
        builder.settingsView(router: router)
    }
    .previewEnvironment()
}

#Preview("Not anonymous") {
    let container = DevPreview.shared.container
    container.register(AuthManager.self, service: AuthManager(service: MockAuthService(user: UserAuthInfo.mock(isAnonymous: false))))
    container.register(UserManager.self, service: UserManager(services: MockUserServices(user: .mock)))

    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    
    return RouterView { router in
        builder.settingsView(router: router)
    }
    .previewEnvironment()
}
