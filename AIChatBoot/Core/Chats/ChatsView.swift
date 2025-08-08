//
//  ChatsView.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 06.05.25.
//
import SwiftUI

struct ChatsView<ChatRowCell: View>: View {
    @State var presenter: ChatsPresenter
    @ViewBuilder var chatRowCell: (ChatRowCellDelegate) -> ChatRowCell
    
    var body: some View {
        List {
            if !presenter.recentAvatars.isEmpty {
                recentSection
            }
            chatSection
        }
        .navigationTitle("Chats")
        .screenAppearAnalytics(name: "ChatsView")
        .onAppear {
            presenter.loadRecentAvatars()
        }
        .task {
            await presenter.loadChats()
        }

    }

    private var recentSection: some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(presenter.recentAvatars, id: \.self) { avatar in
                        if let imageName = avatar.profileImageName {
                            VStack(spacing: 8) {
                                ImageLoaderView(urlString: imageName)
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(minHeight: 60)

                                Text(avatar.name ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                            .anyButton {
                                presenter.onAvatarPressed(avatar: avatar)
                            }
                        }
                    }
                }
                .padding(.top, 12)
            }
            .frame(height: 120)
            .scrollIndicators(.hidden)
            .removeListRowFormatting()
        }
        header: {
            Text("Recents")
        }
    }

    private var chatSection: some View {
        Section {
            if presenter.isLoadingChats {
                ProgressView()
                    .padding(40)
                    .frame(maxWidth: .infinity)
                    .removeListRowFormatting()
            } else if presenter.chats.isEmpty {
                Text("Your chats will appear here!")
                    .foregroundStyle(.secondary)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .removeListRowFormatting()
            } else {
                ForEach(presenter.chats) { chat in
                    chatRowCell(ChatRowCellDelegate(chat: chat))
                        .anyButton(.highlight, action: {
                            presenter.onChatPressed(chat: chat)
                        })
                        .removeListRowFormatting()
                }
            }
        } header: {
            Text(presenter.chats.isEmpty ? "" : "Chats")
        }
    }
}

#Preview("Has data") {
    let builder = CoreBuilder(interactor: CoreInteractor(container: DevPreview.shared.container))
    
    return RouterView { router in
        builder.chatsView(router: router)
    }
    .previewEnvironment()
}
#Preview("No data") {
    let container = DevPreview.shared.container
    container.register(RemoteAvatarService.self, service: MockAvatarService(avatars: []))
    container.register(LocalAvatarPersistence.self, service: MockLocalAvatarPersistence(avatars: []))
    container.register(ChatService.self, service: MockChatService(chats: []))
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    
    return RouterView { router in
        builder.chatsView(router: router)
    }
    .previewEnvironment()
}
#Preview("Slow loading chats") {
    let container = DevPreview.shared.container
    container.register(ChatService.self, service: MockChatService(delay: 5))
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    
    return RouterView { router in
        builder.chatsView(router: router)
    }
    .previewEnvironment()
}
