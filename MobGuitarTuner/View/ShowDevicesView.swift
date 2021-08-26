//
//  ShowDevicesView.swift
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

struct ShowDevicesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var noteTracker: NoteTracker
    @Binding var ShowDevices: Bool
    
    func getDevices() -> [Device] {
        return AudioEngine.inputDevices.compactMap { $0 }
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 10) {
                
                Text("Double tap to select the microphone")
                
                Spacer()
                
                ForEach(getDevices(), id: \.self) { device in
                    Text(device == self.noteTracker.engine.inputDevice ? "* \(device.deviceID)" : "\(device.deviceID)").onTapGesture {
                        do {
                            try AudioEngine.setInputDevice(device)
                        } catch let err {
                            print(err)
                        }
                    }
//                    .padding(.horizontal, 20)
                }
                
            }
            .padding(.vertical, 300)
            .preferredColorScheme(.light)
            .navigationBarTitle("Microphone Selection", displayMode: .inline)
            .navigationBarItems(leading: Button(action:{
//                self.ShowDevices.toggle()
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Close")
            })
        }
    }
}

struct ShowDevicesView_Previews: PreviewProvider {
    
    @StateObject static var noteTracker = NoteTracker()
    @State static var showDevices: Bool = true
    
    static var previews: some View {
        ShowDevicesView(noteTracker: noteTracker, ShowDevices: $showDevices)
    }
}
