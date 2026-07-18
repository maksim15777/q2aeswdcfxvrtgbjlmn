// +ChatPermission.swift

import SwiftUI
import TDLibKit

extension ChatPermissions {
    static let moc = ChatPermissions(
        canAddLinkPreviews: false,
        canChangeInfo: false,
        canCreateTopics: false,
        canEditTag: false,
        canInviteUsers: false,
        canPinMessages: false,
        canReactToMessages: false,
        canSendAudios: false,
        canSendBasicMessages: false,
        canSendDocuments: false,
        canSendOtherMessages: false,
        canSendPhotos: false,
        canSendPolls: false,
        canSendVideoNotes: false,
        canSendVideos: false,
        canSendVoiceNotes: false
    )
}
