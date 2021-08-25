//
//  Tuner.swift
//  iOSGuitarTuner
//
//  Created by Jonathan Andrei on 16/08/21.
//

import Foundation
import AudioKit
import AudioKitEX
import AudioToolbox
import SoundpipeAudioKit
import AVFoundation
import SwiftUI

class Tuner: ObservableObject {
    let engine = AudioEngine()
    var mic: AudioEngine.InputNode
    var tracker: PitchTap!
//    var tappableNode1: Fader
//    var tappableNodeA: Fader
//    var tappableNode2: Fader
//    var tappableNodeB: Fader
//    var tappableNode3: Fader
//    var tappableNodeC: Fader
    var silence: Fader
    
    @Published var minDistances: Float = 10_000.0
    @Published var frequencies: Float = 0.0
    
    @Published var data = TunerData()
    
    func update(_ pitch: AUValue, _ amp: AUValue) {
        
        data.pitch = pitch
        data.amplitude = amp
        
        var frequency = pitch
        
        while frequency > Float(data.noteFrequenciesList[data.noteFrequenciesList.count - 1]) {
            frequency /= 2.0
        }
        
        while frequency < Float(data.noteFrequenciesList[0]) {
            frequency *= 2.0
        }
        
        self.frequencies = frequency
        
        var minDistance: Float = 10_000.0
        var index = 0
        
        for possibleIndex in 0 ..< data.noteFrequenciesList.count {
            
            let distance = fabsf(Float(data.noteFrequenciesList[possibleIndex]) - frequency)
            
            if distance < minDistance {
                
                index = possibleIndex
                minDistance = distance
                self.minDistances = distance
                
            }
            
        }
        
        let octave = Int(log2f(pitch / frequency))
        data.noteNameWithSharps = "\(data.noteNamesWithSharpsList[index])\(octave)"
        data.noteNameWithFlats = "\(data.noteNamesWithFlatsList[index])\(octave)"
        
    }
    
    init() {

        do {
            // Configure settings of AVFoundation.
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.measurement, options: [])
            try Settings.setSession(category: .playAndRecord, options: AVAudioSession.CategoryOptions.defaultToSpeaker.rawValue)

        } catch let error {
            print(error.localizedDescription)
        }
        
        guard let input = engine.input else {
            fatalError()
        }
        
        mic = input
//        tappableNode1 = Fader(mic)
//        tappableNode2 = Fader(tappableNode1)
//        tappableNode3 = Fader(tappableNode2)
//        tappableNodeA = Fader(tappableNode3)
//        tappableNodeB = Fader(tappableNodeA)
//        tappableNodeC = Fader(tappableNodeB)
//        silence = Fader(tappableNodeC, gain: 0)
        self.silence = Fader(mic, gain: 0)
        engine.output = silence
        
        tracker = PitchTap(mic) { pitch, amp in
            DispatchQueue.main.async {
                self.update(pitch[0], amp[0])
            }
        }
            
    }
    
    func start() {
        
        do {
            try engine.start()
            tracker.start()
        } catch let error {
            Log(error)
        }
        
    }
    
    func stop() {
        
        engine.stop()
        
    }
    
}
//        do {
//            // Configure settings of AVFoundation.
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.measurement, options: [])
//        } catch let error {
//            print(error.localizedDescription)
//        }
//
//        Settings.enableLogging = true
//
//        mic = engine.input
//        tracker = PitchTap(mic) { pitch, amp in
//
//            DispatchQueue.main.async {
//                self.up
//            }
//
//        }
