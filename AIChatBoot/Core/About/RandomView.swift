//
//  RandomView.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol RandomInteractor {
    func trackEvent(event: LoggableEvent)
}
extension CoreInteractor: RandomInteractor {}

@MainActor
protocol RandomRouter {}
extension CoreRouter: RandomRouter {}

@Observable
@MainActor
class RandomPresenter {
    
    private let interactor: RandomInteractor
    private let router: RandomRouter
    
    init(interactor: RandomInteractor, router: RandomRouter) {
        self.interactor = interactor
        self.router = router
    }
}

struct RandomDelegate {
    
}

extension CoreBuilder {
    func randomView(router: Router, delegate: RandomDelegate) -> some View {
        RandomView(
            presenter: RandomPresenter(
                interactor: interactor,
                router: CoreRouter(
                    router: router,
                    builder: self
                )
            ),
            delegate: delegate
        )
    }
}

extension CoreRouter {
    func showRandomView(delegate: RandomDelegate) {
        router.showScreen(.push) { router in
            builder.randomView(router: router, delegate: delegate)
        }
    }
}

struct RandomView: View {
    @State var presenter: RandomPresenter
    let delegate: RandomDelegate
    
    var body: some View {
        Text("Random!")
            .navigationTitle("Random!")
            .screenAppearAnalytics(name: "RandomView")    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    let delegate = RandomDelegate()

    return RouterView { router in
        builder.randomView(router: router, delegate: delegate)
        
    }
}
