//
//  OnboardingVC.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 7/1/25.
//

import UIKit
import Combine

class OnboardingVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            let nib = UINib(nibName: OnboardingCVCell.identifier, 
                            bundle: nil)
            collectionView.register(nib, 
                                    forCellWithReuseIdentifier: OnboardingCVCell.identifier)
            // Configure layout
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumLineSpacing = 0
                flowLayout.minimumInteritemSpacing = 0
                flowLayout.scrollDirection = .horizontal
            }
            
            // Configure collection view
            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: CircularProgressButton! {
        didSet {
            nextButton.progressColor = UIColor(hex: "#97B7FE")
            nextButton.backgroundProgressColor = .white
            nextButton.progressLineWidth = 3
            nextButton.progressGap = 4
        }
    }
    
    
    
    private var viewModel: OnboardingViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupPageControl()
        bindViewModel()
    }
    
    private func setupPageControl() {
        guard let viewModel = viewModel else { return }
        
        pageControl.numberOfPages = viewModel.slides.count
        pageControl.currentPage = viewModel.currentPage
        // Add target action for page control
        pageControl.addTarget(self,
                              action: #selector(pageControlDidChange(_:)),
                              for: .valueChanged)
    }
    
    private func updateUI(for page: Int) {
        pageControl.currentPage = page
        nextButton.updateProgress(to: page)
        
        if Int(collectionView.contentOffset.x / collectionView.bounds.width) != page {
            let indexPath = IndexPath(item: page, section: 0)
            collectionView.scrollToItem(at: indexPath,
                                        at: .centeredHorizontally,
                                        animated: true)
        }
    }
    
    private func bindViewModel(){
        guard let viewModel = viewModel else { return }
        
        viewModel.$currentPage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] page in
                self?.updateUI(for: page)
            }
            .store(in: &cancellables)
    }
    
    // Handle page control tap
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        viewModel?.updateSlides(sender.currentPage)
    }
    
    @IBAction func nextButtonTapped(_ sender: CircularProgressButton) {
        if viewModel?.currentPage == (viewModel?.slides.count ?? 0) - 1 {
            viewModel?.onboardingCompleted()
        } else {
            viewModel?.nextSlide()
        }
    }
}

extension OnboardingVC: UICollectionViewDelegate,
                        UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel?.slides.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCVCell.identifier,
                                                            for: indexPath) as? OnboardingCVCell else {
            return UICollectionViewCell()
        }
        guard let slide = viewModel?.slides[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.configure(with: slide)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    // Add this to handle scroll ending to update currentPage
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        viewModel?.updateSlides(Int(scrollView.contentOffset.x / width))
    }
}
