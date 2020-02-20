
//  GameViewController.swift
//  MAPD724-W2020-midterm
//Harmandeep kaur on 2020-02-19.
//301092579

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, GameManager {
    
    
    // button outlets
    @IBOutlet weak var StartButtonOutlet: UIButton!
    @IBOutlet weak var BackButtonOutlet: UIButton!
    
    // label outlets
    @IBOutlet weak var StartLabel: UILabel!
    @IBOutlet weak var LivesLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    
    var currentScene: SKScene?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        BackButtonOutlet.isHidden = true
        LivesLabel.isHidden = true
        ScoreLabel.isHidden = true
        
        CollisionManager.gameViewController = self
        
        SetScene(sceneName: "StartScene")
    }
    
    // ViewWillTransition allows you to detect orientation changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            
        } else {
            print("Portrait")
            
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func updateScoreLabel() -> Void
    {
        ScoreLabel.text  = "Score: \(ScoreManager.Score)"
    }
    
    func updateLivesLabel() -> Void
    {
        LivesLabel.text = "Lives: \(ScoreManager.Lives)"
    }
    
    
    func SetScene(sceneName: String)
    {
        if let view = self.view as! SKView?
        {
            // Load the SKScene from 'GameScene.sks'
            currentScene = SKScene(fileNamed: sceneName)
            
            if let gameScene = currentScene as? GameScene
            {
                gameScene.gameManager = self
            }
            
            // Set the scale mode to scale to fit the window
            currentScene?.scaleMode = .aspectFill
                
            // Present the scene
            view.presentScene(currentScene)
            
            
            view.ignoresSiblingOrder = true
        
        }
    }
    
    func PresentStartScene() {
        StartButtonOutlet.isHidden = false
        LivesLabel.isHidden = true
        ScoreLabel.isHidden = true
        StartLabel.isHidden = false
    }
    
    func PresentEndScene() {
        BackButtonOutlet.isHidden = false
        LivesLabel.isHidden = true
        ScoreLabel.isHidden = true
        SetScene(sceneName: "EndScene")
    }
    
    
    @IBAction func StartButton_Press(_ sender: Any)
    {
        StartButtonOutlet.isHidden = true
        StartLabel.isHidden = true
        LivesLabel.isHidden = false
        ScoreLabel.isHidden = false
        updateLivesLabel()
        updateScoreLabel()
        SetScene(sceneName: "GameScene")
        
    }
    
    @IBAction func BackButton_Press(_ sender: Any)
    {
        BackButtonOutlet.isHidden = true
        LivesLabel.isHidden = false
        ScoreLabel.isHidden = false
        ScoreManager.Score = 0
        ScoreManager.Lives = 5
        updateLivesLabel()
        updateScoreLabel()
        SetScene(sceneName: "GameScene")
    }
    
    
}
