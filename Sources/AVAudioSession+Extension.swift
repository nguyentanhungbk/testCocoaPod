//
//  Bundle+Ext.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 17/02/2022.
//

import Foundation
import AVFoundation

public extension AVAudioSession {

    /// Set the audio session category, and active state to the provide audio session instance.
    /// - Parameters:
    ///   - activeState: Audio session state.
    ///   - category: Audio session category.
    ///   - audioSession: Audio session instance.
    func setAudioSession(activeState: Bool, category: AVAudioSession.Category = .playback) {
        do {
            try self.setCategory(category, mode: .default, options: AVAudioSession.CategoryOptions.duckOthers)
            try self.setActive(activeState, options: .notifyOthersOnDeactivation)
        } catch {
            print("Unable to end AudioSession for background mode \(error)")
        }
    }
}
