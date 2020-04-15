//
//  ContentView.swift
//  TorchTest
//
//  Created by Sid Verma on 15/04/20.
//  Copyright © 2020 Sid Verma. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
  @State private var level: Float = 0.5
  var body: some View {
    VStack {
      Button(action: {
        setTorchLevel(self.level)
      }) {
        Text("SetTorch")
      }
      Text(String(self.level))
        .padding(.top)
      Slider(value: $level, in: 0.0...1.0, step: 0.1)
    }
  }
}

func setTorchLevel(_ level: Float) {
  guard let device = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back)
    else { return }
  
  do {
    try device.lockForConfiguration()
    if level == 0.0 {
      device.torchMode = .off
    } else {
      try device.setTorchModeOn(level: level)
    }
    device.unlockForConfiguration()
    print(device.isTorchActive, device.torchLevel)
  } catch {
    print(error.localizedDescription)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
