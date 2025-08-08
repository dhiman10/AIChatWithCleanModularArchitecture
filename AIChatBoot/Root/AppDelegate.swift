//
//  AppDelegate.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 25.06.25.
//

import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!
    var builder: RootBuilder!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let config: BuildConfiguration

#if MOCK
        config = .mock(isSignedIn: true)
#elseif DEV
        config = .dev
#else
        config = .prod
#endif

        config.configure()
        dependencies = Dependencies(config: config)
        builder = RootBuilder(
            interactor: RootInteractor(
                container: dependencies.container
            ),
            loogedInRIB: {
                CoreBuilder(interactor: CoreInteractor(container: self.dependencies.container))
            },
            loogedOutRIB: {
                OnbBuilder(interactor: OnbInteractor(container: self.dependencies.container))
        }
        )

        return true
    }
}

enum BuildConfiguration {
    case mock(isSignedIn: Bool), dev, prod

    func configure() {
        switch self {
        case .mock:
            break
        case .dev:
            let plist = Bundle.main.path(forResource: "GoogleService-Info-Dev", ofType: "plist")!
            let options = FirebaseOptions(contentsOfFile: plist)!
            FirebaseApp.configure(options: options)
        case .prod:
            let plist = Bundle.main.path(forResource: "GoogleService-Info-Prod", ofType: "plist")!
            let options = FirebaseOptions(contentsOfFile: plist)!
            FirebaseApp.configure(options: options)
        }
    }
}
