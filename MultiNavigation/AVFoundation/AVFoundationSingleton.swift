//
//  AVFoundationSingleton.swift
//  MultiNavigation
//
//  Created by Saurabh Gupta on 11/06/25.
//

import UIKit
import AVFoundation

final class AVFoundationSingleton {
  
  var player: AVAudioPlayer!
  let forResource = ["C", "D", "E", "F", "G", "A", "B"]
  var index: Int = 0
  var timer: Timer?
  
  init() {
    try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
    try? AVAudioSession.sharedInstance().setActive(true)
  }
  
  func playSound() {
    if let url = Bundle.main.url(forResource: forResource[index], withExtension: "wav") {
      player = try! AVAudioPlayer(contentsOf: url)
      index = (index + 1) % forResource.count
      player.play()
    }
  }
  
  func startTime() {
    timer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                 repeats: true,
                                 block: { [weak self] timer in
      self?.playSound()
    })
  }
  
  func endTime() {
    timer?.invalidate()
    timer = nil
  }
  
}
