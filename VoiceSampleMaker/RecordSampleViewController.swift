//
//  ViewController.swift
//  VoiceSampleMaker
//
//  Created by 城野 on 2021/01/21.
//

import UIKit
import AVFoundation

class RecordSampleViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var isRecording = false
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func record(){
        
        if !isRecording {
            
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSession.Category.playAndRecord)
            try! session.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try! AVAudioRecorder(url: getAudioFileURL(), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            isRecording = true
            
            statusLabel.text = "録音中"
            recordButton.setTitle("Stop", for: .normal)
            playButton.isEnabled = false
    
        } else {
            
            audioRecorder.stop()
            isRecording = false
            
            statusLabel.text = "待機中"
            recordButton.setTitle("RECORD", for: .normal)
            playButton.isEnabled = true
            
        }
    }
    
    func getAudioFileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirect = paths[0]
        let url = docDirect.appendingPathComponent("recording.m4a")
        return url
    }
    
    @IBAction func play(){
        if !isPlaying{
            
            audioPlayer = try! AVAudioPlayer(contentsOf: getAudioFileURL())
            audioPlayer.delegate = self
            audioPlayer.play()
            
            isPlaying = true
            
            statusLabel.text = "再生中"
            playButton.setTitle("Stop", for: .normal)
            recordButton.isEnabled = false
            
        } else {
            
            audioPlayer.stop()
            isPlaying = false
            
            statusLabel.text = "待機中"
            playButton.setTitle("Play", for: .normal)
            recordButton.isEnabled = true
            
        }
    }
    
    
    
}

