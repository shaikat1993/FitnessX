//
//  CircularProgressButton.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 7/1/25.
//

// MARK: - CircularProgressButton.swift
import UIKit

@IBDesignable
class CircularProgressButton: UIButton {
    // MARK: - Inspectable Properties
    @IBInspectable var progressColor: UIColor = UIColor(hex: "#97B7FE") {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    @IBInspectable var backgroundProgressColor: UIColor = .clear {
        didSet {
            backgroundLayer.strokeColor = backgroundProgressColor.cgColor
        }
    }
    
    @IBInspectable var progressLineWidth: CGFloat = 2 {
        didSet {
            setupLayers()
        }
    }
    
    @IBInspectable var progressGap: CGFloat = 8 {
        didSet {
            updateCircularPath()
        }
    }
    
    // MARK: - Private Properties
    private let progressLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var totalSteps: Int = 4
    private var currentStep: Int = 0
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        setupButton()
        setupLayers()
    }
    
    private func setupButton() {
        tintColor = .white
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        
        // Default arrow image
        setImage(UIImage(named: "rightArrow"), for: .normal)
        setTitle("", for: .normal)
        
        // Center the image
        imageView?.contentMode = .center
        contentVerticalAlignment = .center
        contentHorizontalAlignment = .center
        
        layer.masksToBounds = false
    }
    
    private func setupLayers() {
        // Remove existing layers if any
        progressLayer.removeFromSuperlayer()
        backgroundLayer.removeFromSuperlayer()
        
        // Background Layer
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = backgroundProgressColor.cgColor
        backgroundLayer.lineWidth = progressLineWidth
        layer.addSublayer(backgroundLayer)
        
        // Progress Layer
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = progressLineWidth
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        updateCircularPath()
    }
    
    private func updateCircularPath() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        // Calculate button radius and add gap for progress circle
        let buttonRadius = min(bounds.width, bounds.height) / 2
        let progressRadius = buttonRadius + progressGap
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center,
                                      radius: progressRadius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        backgroundLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
        CATransaction.commit()
    }
    
    // MARK: - Public Methods
    func configure(totalSteps: Int) {
        self.totalSteps = totalSteps
        updateProgress(to: 0)
    }
    
    func updateProgress(to step: Int) {
        guard step >= 0 && step < totalSteps else { return }
        currentStep = step
        
        let progress = CGFloat(step) / CGFloat(max(totalSteps - 1, 1))
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.3)
        progressLayer.strokeEnd = progress
        CATransaction.commit()
    }
}
