////
////  CustomTextField.swift
////  FitnessX
////
////  Created by Md Sadidur Rahman on 26/1/25.
////
//
//import UIKit
//
//class CustomTextField: UIView {
//    @IBOutlet private var contentView: UIView!
//    @IBOutlet private var textField: UITextField!
//    @IBOutlet private var iconImageView: UIImageView!
//    @IBOutlet private var rightButton: UIButton!
//    
//    
//    enum TextFieldType: Equatable {
//        case firstname
//        case lastname
//        case email
//        case password
//        case custom(icon: UIImage?,
//                    placeholder: String)
//        
//        var icon: UIImage? {
//            switch self {
//                
//            case .firstname,
//                    .lastname:
//                return #imageLiteral(resourceName: "Profile.png")
//            case .email:
//                return #imageLiteral(resourceName: "Message.png")
//            case .password:
//                return #imageLiteral(resourceName: "Lock.png")
//            case .custom(icon: let icon,
//                         _ ):
//                return icon
//            }
//        }
//        
//        var placeholder: String {
//            switch self {
//            case .firstname: return "First Name"
//            case .lastname: return "Last Name"
//            case .email: return "Email"
//            case .password: return "Password"
//            case .custom(_, let placeholder): return placeholder
//            }
//        }
//        
//        static func == (lhs: TextFieldType,
//                        rhs: TextFieldType) -> Bool {
//            switch (lhs, rhs) {
//            case (.firstname, .firstname),
//                (.lastname, .lastname),
//                (.email, .email),
//                (.password, .password):
//                return true
//            case (.custom(let icon1, let placeholder1), 
//                .custom(let icon2, let placeholder2)):
//                return icon1 == icon2 && 
//                       placeholder1 == placeholder2
//            default:
//                return false
//            }
//        }
//    }
//    
//    // MARK: - Properties
//    private var fieldType: TextFieldType?
//    
//    var text: String? {
//        get { return textField.text }
//        set { textField.text = newValue }
//    }
//    
//    var placeholder: String? {
//        get { return textField.placeholder }
//        set { textField.placeholder = newValue }
//    }
//    
//    // MARK: - Initialization
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupXib()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupXib()
//    }
//    
//    // MARK: - Setup
//    private func setupXib() {
//        Bundle.main.loadNibNamed("CustomTextField", owner: self)
//        addSubview(contentView)
//        contentView.frame = bounds
//        contentView.autoresizingMask = [.flexibleWidth,
//                                        .flexibleHeight]
//        
//        setupTextField()
//    }
//    
//    private func setupTextField() {
//        // Icon setup
//        iconImageView.tintColor = .gray
//        iconImageView.contentMode = .scaleAspectFit
//        
//        // Right button setup
//        rightButton.isHidden = true
//        rightButton.tintColor = .gray
//    }
//    
//    private func setupFieldType() {
//        guard let type = fieldType else { return }
//        
//        iconImageView.image = type.icon
//        textField.placeholder = type.placeholder
//        
//        if (type == .password) {
//            textField.isSecureTextEntry = true
//            rightButton.isHidden = false
//            rightButton.setImage(UIImage(systemName: "eye.slash"),
//                                 for: .normal)
//        } else {
//            rightButton.isHidden = true
//        }
//    }
//    
//    // MARK: - Actions
//    @IBAction private func rightButtonTapped(_ sender: UIButton) {
//        guard fieldType == .password else { return }
//        textField.isSecureTextEntry.toggle()
//        let image = textField.isSecureTextEntry ? #imageLiteral(resourceName: "Hide.png") : #imageLiteral(resourceName: "Show.png")
////        textField.isSecureTextEntry ? "eye.slash" : "eye"
//        rightButton.setImage(image,
//                             for: .normal)
//    }
//    
//    // MARK: - Public Configuration
//    func configure(type: TextFieldType) {
//        self.fieldType = type
//        setupFieldType()
//    }
//}
