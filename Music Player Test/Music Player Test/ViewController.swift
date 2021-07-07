//
//  ViewController.swift
//  MyMusicPlayer
//
//  Created by yagom
//  Copyright © 2017년 yagom. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    var timer: Timer!

    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var slider: UISlider!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.addViewsWithCode()
        initializeProperties()
    }
    
    func setLabelFromTime(time:TimeInterval){
        
        let min = Int((time/60).truncatingRemainder(dividingBy: 99))
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let milisec = Int((time.truncatingRemainder(dividingBy: 1))*100)
        label.text = String(format:"%02ld:%02ld:%02ld",min,sec,milisec)
        
    }
    
    func initPlayer(){
        guard let soundAsset: NSDataAsset = NSDataAsset(name:"sound") else{
            print("음원 에셋 파일을 불러올 수 없습니다.")
            return
        }
        
        do{
            try player = AVAudioPlayer(data:soundAsset.data)
            
        }catch{
            print("플레이어 초기화 실패")
        }
    }
    
    
    func initButton(){
        button.isSelected = false
    }
    func initLabel(){
        setLabelFromTime(time:0)
    }
    func initSlider(){
        slider.minimumValue = 0
        slider.maximumValue = Float(player.duration)
        slider.value = 0
    }
    
    func initializeProperties(){
        initPlayer()
        initButton()
        initLabel()
        initSlider()
    }
    
    func playTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block:{ [weak self] (timer:Timer) in
            guard let `self` = self else {return}
            if self.slider.isTracking {return}
            self.slider.value = Float(self.player.currentTime)
            self.setLabelFromTime(time:self.player.currentTime)
        })
    }
    func invalidTimer(){
        timer = nil
    }
    @IBAction func pressedButton(_ sender: Any){
        button.isSelected = !button.isSelected
        
        if button.isSelected == true {
            player?.play()
            playTimer()
        }
        else{
            player?.pause()
            invalidTimer()
        }
    }
    
    @IBAction func untouchSlider1(_ sender: Any){
        player?.currentTime = TimeInterval(slider.value)
    }
    @IBAction func untouchSlider2(_ sender: Any){
        player?.currentTime = TimeInterval(slider.value)
    }
    
    @IBAction func changedSlider(_ sender: Any){
        setLabelFromTime(time:TimeInterval(slider.value))
    }
}

