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
            List {
                ForEach(getDevices(), id: \.self) { device in
                    HStack {
                        
                        Text("\(device.deviceID)")
                            .onTapGesture(perform: {
                                do {
                                    try AudioEngine.setInputDevice(device)
                                } catch let err {
                                    print(err)
                                }
                            })
                        
                        Spacer()
                        
                        if device == self.noteTracker.engine.inputDevice {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(.clear)
                        }
                    }
                }
            }
            .preferredColorScheme(.light)
            .navigationBarTitle("Microphone Selection", displayMode: .inline)
            .navigationBarItems(leading: Button(action:{
                closeSheet()
            }){
                Text("Close")
            })
            .onDisappear(perform: {
                self.ShowDevices = false
                print(self.ShowDevices)
            })
        }
    }
    func closeSheet() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ShowDevicesView_Previews: PreviewProvider {
    
    @StateObject static var noteTracker = NoteTracker()
    
    static var previews: some View {
        ShowDevicesView(noteTracker: noteTracker, ShowDevices: .constant(true))
    }
}
