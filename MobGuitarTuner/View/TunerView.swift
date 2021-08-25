//
//  TunerView.swift
//  MobGuitarTuner
//
//  Created by Jonathan Andrei on 24/08/21.
//
import AudioKit
import AudioKitEX
import AudioToolbox
import SoundpipeAudioKit
import AVFoundation
import SwiftUI

struct TunerView: View {
    
    @StateObject var tuner: Tuner = Tuner()
    @State var showDevices: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                
                Text("Frequency : \(tuner.data.pitch)")
                
//                Spacer()
                
                Text("Distance : \(tuner.minDistance)")
                
                Text("Note : \(tuner.data.noteNameWithSharps) / \(tuner.data.noteNameWithFlats)")
                
                Button("\(tuner.engine.inputDevice?.deviceID ?? "Choose Mic")") {
                    self.showDevices = true
                }
                
            }
            
            .navigationBarTitle("Tuner", displayMode: .inline)
            .onAppear() {
                self.tuner.start()
            }
            .onDisappear() {
                self.tuner.stop()
            }
            .sheet(isPresented: $showDevices, content: {ShowDevicesView(tuner: self.tuner, ShowDevices: self.$showDevices)})
            
        }
        
    }
}

struct TunerView_Previews: PreviewProvider {
    static var previews: some View {
        TunerView()
    }
}
