//
//  ViewController.swift
//  HW #6 straySquare
//
//  Created by Евгений Л on 18.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var squareView = UIView()
    var snap: UISnapBehavior!
    var animator: UIDynamicAnimator!
    var colision: UICollisionBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupUIView()
        gestureRecognizer()
        colisionBehaviorAndAnimator()
        snapBehavior()
    }
    
    func setupUIView() {
        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        squareView.center = view.center
        squareView.backgroundColor = .systemBlue
        squareView.layer.cornerRadius = 10
        
        view.addSubview(squareView)
    }
    
    func snapBehavior() {
        snap = UISnapBehavior(item: squareView, snapTo: squareView.center)
        animator.addBehavior(snap)
    }
    
    func colisionBehaviorAndAnimator() {
        colision = UICollisionBehavior(items: [squareView])
        colision.translatesReferenceBoundsIntoBoundary = true
        
        animator = UIDynamicAnimator(referenceView: view)
        animator.addBehavior(colision)
    }
    
    func gestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(paramTap:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(paramTap: UITapGestureRecognizer){
        let tapPoint = paramTap.location(in: view)
        if snap != nil {
            animator.removeBehavior(snap)
        }
        
        snap = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snap.damping = 2
        animator.addBehavior(snap)
    }
}

