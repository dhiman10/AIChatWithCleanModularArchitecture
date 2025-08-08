//
//  About.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol AboutInteractor {
    func trackEvent(event: LoggableEvent)
}
extension CoreInteractor: AboutInteractor { }

@MainActor
protocol AboutRouter {
    func dismissScreen()
    func showRandomView(delegate: RandomDelegate)
}

extension CoreRouter: AboutRouter {}

@Observable
@MainActor
class AboutPresenter {
    private let interactor: AboutInteractor
    private let router: AboutRouter
    
    init(interactor: AboutInteractor, router: AboutRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onDismissPressed() {
        router.dismissScreen()
    }
    
    func onRandomPressed() {
        router.showRandomView(delegate: RandomDelegate())
    }
}
struct AboutDelegate {
    
}

struct About: View {
    @State var presenter: AboutPresenter
    let delegate: AboutDelegate

    var body: some View {
        List {
            Text("Made by SwiftfulThinking")

            Button("Random") {
                 presenter.onRandomPressed()
            }
            Button("Dismiss") {
                presenter.onDismissPressed()
            }
        }
        .screenAppearAnalytics(name: "AboutView")
        .navigationTitle("About Us ❤️")
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    let delegate = AboutDelegate()

    return RouterView { router in
        builder.aboutView(router: router, delegate: delegate)
        
    }
    .previewEnvironment()

}
