// +ChatNotificationSettings.swift

import SwiftUI
import TDLibKit

extension ChatNotificationSettings {
    static let moc = ChatNotificationSettings(
        disableMentionNotifications: false,
        disablePinnedMessageNotifications: false,
        muteFor: 0,
        muteStories: false,
        showPreview: false,
        showStoryPoster: false,
        soundId: 0,
        storySoundId: 0,
        useDefaultDisableMentionNotifications: false,
        useDefaultDisablePinnedMessageNotifications: false,
        useDefaultMuteFor: false,
        useDefaultMuteStories: false,
        useDefaultShowPreview: false,
        useDefaultShowStoryPoster: false,
        useDefaultSound: false,
        useDefaultStorySound: false
    )
}
