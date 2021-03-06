//
//  AnimationSelection.swift
//  Charging
//
//  Created by haiphan on 25/07/2021.
//

import UIKit
import RxCocoa
import RxSwift
import MediaPlayer
import SVProgressHUD

class AnimationSelection: HideNavigationController {
    
    enum StatusAction {
        case show, hide
    }
    
    enum TapAction: Int, CaseIterable {
        case icon, color, sound
    }
    
    var openfrom: BaseTabbarViewController.openfrom = .home
    
//    var moviePlayer:AVContro!
    var chargingAnimationModel: ChargingAnimationModel?
    var animationIconModel: Video?
    var selectSound: SoundRealmModel?

    @IBOutlet weak var lbBattery: UILabel!
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var hViewBottom: NSLayoutConstraint!
    @IBOutlet weak var vButtons: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var btStatus: UIButton!
    @IBOutlet var bts: [UIButton]!
    @IBOutlet weak var viewAnimation: UIView!
    @IBOutlet weak var imageAnimation: UIImageView!
    @IBOutlet weak var btSetAnimation: UIButton!
    private let viewSuccess: SuccessView = SuccessView.loadXib()
    private var moveBack: Bool = true
    
    private var bombSoundEffect: AVAudioPlayer = AVAudioPlayer()
    @VariableReplay private var statusAction: StatusAction = .hide
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ChargeManage.shared.updateAVPlayerfrom(avplayerfrom: .animationSelection)
//        ChargeManage.shared.eventPlayAVPlayer = ()
        
        if !self.moveBack {
            self.bombSoundEffect.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ChargeManage.shared.eventDisAppears = ()
        if self.moveBack {
            ChargeManage.shared.eventPauseAVPlayer = ()
            self.bombSoundEffect.stop()
        } else {
            self.bombSoundEffect.pause()
        }
        
    }
    
    
}
extension AnimationSelection {
    
    private func setupUI() {
        self.hViewBottom.constant = self.view.safeAreaBottom
        self.vButtons.clipsToBounds = true
        self.vButtons.layer.cornerRadius = 7
        self.vButtons.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        switch  self.openfrom {
        case .home:
            if let c = self.animationIconModel, let t = c.filename, let url = URL(string: t) {
                ChargeManage.shared.playAnimation(view: self.viewAnimation, url: url, avplayerfrom: .animationSelection)
            }
        case .app:
            ChargeManage.shared.playVideofromApp(view: self.viewAnimation)
            let sound = ChargeManage.shared.soundMode
            let listSound = ChargeManage.shared.listSoundCache
            if  let s = sound, let index = listSound.firstIndex(where: { $0.lastPathComponent == s.destinationURL.lastPathComponent }) {
                self.playAudio(url: listSound[index])
                ChargeManage.shared.eventPlayingVideo = ()
            }
            
        }
        

        
//        if let c = self.animationIconModel, let t = c.filename, let url = t.getURLLocal(extensionMovie: .mov) {
//            ChargeManage.shared.playAnimation(view: self.viewAnimation, url: url, avplayerfrom: .animationSelection)
//        }
        
//        self.viewButtonSetAnimation.gradientHozorital(color: [Asset._0090Ff.color, Asset._00D3Ff.color])
//        self.view.applyGradient(colours: [.yellow, .blue, .red], locations: [0.0, 0.5, 1.0])
        
        self.btSetAnimation.applyGradient(withColours: [Asset._0090Ff.color, Asset._00D3Ff.color], gradientOrientation: .horizontal)

        
    }
    
    private func setupRX() {
        
        ChargeManage.shared.$loadingModel.asObservable().bind(onNext: weakify({ value, wSelf in
            
            if let v = value, v.current >= v.total {
                LoadingManager.instance.dismiss()
                return
            }
            
            guard let value = value?.getPercent() else { return }
            
            SVProgressHUD.showProgress(Float(value), status: "Loading...\(Double(value).roundTo())%")
            
        })).disposed(by: disposeBag)
        
        self.rx.viewWillDisappear.asObservable().bind { _ in
            SVProgressHUD.dismiss()
        }.disposed(by: disposeBag)
        
        ChargeManage.shared.indicator.asObservable().bind(onNext: weakify({ item, wSelf in
            item ? LoadingManager.instance.show() : LoadingManager.instance.dismiss()
        })).disposed(by: disposeBag)
        
        ChargeManage.shared.$eventBatteryLevel.bind(onNext: weakify({ value, wSelf in
            wSelf.lbBattery.text = value?.batterCharging
        })).disposed(by: disposeBag)
        
        TapAction.allCases.forEach { type in
            let bt = self.bts[type.rawValue]
            
            bt.rx.tap.bind { _ in
                
                switch type {
                case .icon:
                    let vc = LisiConVC.createVC()
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                case .color:
                    let vc = ListColorVC.createVC()
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                case .sound: 
                    let vc = ListSoundVC.createVC()
                    vc.delegate = self
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                
            }.disposed(by: disposeBag)
            
        }
        
        self.$statusAction.asObservable().bind(onNext: weakify({ action, wSelf in
            
            switch action {
            case .hide:
                wSelf.btBack.isHidden = true
                wSelf.stackView.isHidden = true
            case .show:
                wSelf.btBack.isHidden = false
                wSelf.stackView.isHidden = false
            }
            
        })).disposed(by: disposeBag)
        
        self.btStatus.rx.tap.bind { _ in
            switch self.statusAction {
            case .hide:
                self.statusAction = .show
            case .show:
                self.statusAction = .hide
            }
        }.disposed(by: disposeBag)
        
        ChargeManage.shared.$colorIndex.bind(onNext: weakify({ v, wSef in
            wSef.lbBattery.textColor = ListColorVC.ColorCell.init(rawValue: v)?.color
        })).disposed(by: disposeBag)
        
        ChargeManage.shared.$iconAnimation.bind(onNext: weakify({ v, wSelf in
            guard let d = v.text else { return }
            wSelf.imageAnimation.image = UIImage(named: d)
        })).disposed(by: disposeBag)
        
        self.btBack.rx.tap.bind { _ in
            self.moveBack = true
            switch self.openfrom {
            case .app:
                let vc = BaseTabbarViewController()
                ChargeManage.shared.openfrom = .selectAnimation
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                self.navigationController?.popViewController(animated: true, nil)
            }
            
        }.disposed(by: disposeBag)
        
        self.btSetAnimation.rx.tap.bind { _ in
            if let v =  self.animationIconModel, let t = v.filename, let url = URL(string: t) {
                do {
                    let model = AnimationRealmModel(destinationURL: url, isDefault: false)
                    let data = try model.toData()
                    RealmManage.shared.addAndUpdateAnimation(data: data)
                } catch {
                    print("\(error.localizedDescription)")
                }
            }

            if let s = self.selectSound {
                do {
                    let t = s.destinationURL
                    let model = SoundRealmModel(destinationURL: t)
                    let data = try model.toData()
                    RealmManage.shared.addAndUpdateSound(data: data)
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
            
            if let f = ChargeManage.shared.animaionShowFirst, f.isFirst ?? false {
                do {
                    let model = ShowAnimationFirstModel(isFirst: false)
                    let data = try model.toData()
                    RealmManage.shared.addAndUpdateShowAnimationFirst(data: data)
                    let vc = HowToUserAnimation.createVC()
                    self.moveBack = false
                    self.navigationController?.pushViewController(vc, animated: true)
                } catch {
                    print("\(error.localizedDescription)")
                }
                
                
            }
            
            
            do {
                self.showSuccessView()
            }
            
        }.disposed(by: disposeBag)
    }
    
    private func showSuccessView() {
        self.viewSuccess.addView(parentView: self.view)
    }
    
    private func playAudio(url: URL) {
        //detect If Audio isplaying that solve to play Audio
        do {
            self.bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            self.bombSoundEffect.prepareToPlay()
            self.bombSoundEffect.volume = 1.0
            self.bombSoundEffect.play()
            self.bombSoundEffect.delegate = self
        } catch {
            print(" Erro play Audio \(error.localizedDescription) ")
        }
    }
    
}
extension AnimationSelection: SoundCallBack {
    func resendSound(sound: SoundRealmModel) {
        self.selectSound = sound
        self.playAudio(url: sound.destinationURL)
        ChargeManage.shared.eventPlayingVideo = ()
    }
}
extension AnimationSelection: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.bombSoundEffect.play()
    }
}
