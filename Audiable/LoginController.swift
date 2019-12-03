//
//  LoginController.swift
//  Audiable
//
//  Created by sanaboina  prasad on 03/12/19.
//  Copyright © 2019 sanaboina  prasad. All rights reserved.
//

import UIKit


protocol LoginControlDelegate: class {
    func finishedLogin()
}
class LoginController: UIViewController,LoginControlDelegate {
   
    
    
    private let cellIdentifier = "cell"
    private let logindCellId = "logindCellId"
    private var bottomPageControlAnchor: NSLayoutConstraint?
    private var skipButtontopAnchor: NSLayoutConstraint?
    private var nextButtontopAnchor: NSLayoutConstraint?
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    let pages: [Page] =  {
        let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in life. Every recipient's first book is on us ", imageName: "nature" )
        let secondPage = Page(title: "Send from your library", message: "Tap more menu next to the book. Choose \"send the book\" ", imageName: "photo" )
        let thirdPage = Page(title: "Send from your Player", message: "Tap more menu from upper corner. Choose \"send the book\" ", imageName: "page3" )
        
        return [firstPage,secondPage,thirdPage]
    }()
    
    lazy var pageController: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = pages.count + 1
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 125/255, blue: 236/255, alpha: 1)
        return pc
    }()
    
    let skipButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(UIColor(red: 247/255, green: 125/255, blue: 236/255, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(skipPages), for: .touchUpInside)
        return btn
    }()
    
    let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(UIColor(red: 247/255, green: 125/255, blue: 236/255, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return btn
    }()
    @objc fileprivate func skipPages(){
        pageController.currentPage = pages.count - 1
        nextPage()
        return
    }
    
    @objc fileprivate func nextPage(){
        if pageController.currentPage == pages.count {
            
            return
        }
        if pageController.currentPage == pages.count - 1 {
            moveControlConstraintstoOffScreen()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
        let indexpath = IndexPath(item: pageController.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexpath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        pageController.currentPage += 1
    }
    var bottomConstraint: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(pageController)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        observeKeyBoardNotifications()
        
        
        pageController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        pageController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        pageController.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bottomPageControlAnchor = pageController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomPageControlAnchor?.isActive = true
        
        
        skipButtontopAnchor = skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        skipButtontopAnchor?.isActive = true
        
        nextButtontopAnchor = nextButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButtontopAnchor?.isActive = true
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: logindCellId)
        
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, topPadding: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, bottomPaading: 0, leading: view.leadingAnchor, leadingPadding: 0, trailing: view.trailingAnchor, trailingPadding: 0, width: 0, height: 0)
        
        
    }
    func finishedLogin(){
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainViewController: MainViewController  = rootViewController as? MainViewController  else { return }
        
        mainViewController.viewControllers = [HomeViewController()]
        UserDefaults.standard.setIsLogedIn(value: true)
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func moveControlConstraintstoOffScreen(){
        nextButtontopAnchor?.constant = -80
        skipButtontopAnchor?.constant = -80
        bottomPageControlAnchor?.constant = 60
    }
    
    fileprivate func observeKeyBoardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboadWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboadWillHide(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    @objc fileprivate func keyboardWillShow(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -150
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x/view.frame.width)
        pageController.currentPage = pageNumber
        if  pageNumber == pages.count {
            moveControlConstraintstoOffScreen()
            
        }else{
            bottomPageControlAnchor?.constant = 0
            skipButtontopAnchor?.constant = 0
            nextButtontopAnchor?.constant = 0
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
    
extension LoginController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == pages.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: logindCellId, for: indexPath) as! LoginCell
            cell.delegate = self
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PageCell
            cell.page = pages[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        let indexpath = IndexPath(item: pageController.currentPage, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexpath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
            self.collectionView.reloadData()
        }
    }
}
    
    
    
    
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, topPadding: CGFloat, bottom: NSLayoutYAxisAnchor?, bottomPaading: CFloat, leading: NSLayoutXAxisAnchor?, leadingPadding: CGFloat, trailing:
        NSLayoutXAxisAnchor?, trailingPadding: CGFloat, width: CGFloat, height: CGFloat){
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: CGFloat(bottomPaading)).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: trailingPadding).isActive = true
        }
        if  height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if  width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
