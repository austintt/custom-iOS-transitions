//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    var captionLabel = UIView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var closeButton = UIButton()
    var coverImageView = UIImageView()
    var cardView = UIView()
    
    let cardWidth = 335
    let cardHeight = 250
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        // Fake it till you make it
        let backgroundImageView = UIImageView()
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        backgroundImageView.image = UIImage(named: "appStoreBackground.png")
        view.addSubview(backgroundImageView)
        
        // Generate content
        captionLabel = makeCaption("✨Beautiful transitions ahead✨")
        titleLabel = makeTitle("Hello SAiOS!")
        descriptionLabel = makeDescription()
        coverImageView = makeCoverImage()
        closeButton = makeCloseButton()
        cardView = makeCard()
        
        // Add Card
        view.addSubview(cardView)
        
        self.view = view
    }
    
    // MARK: UI Creation
    
    // Card
    func makeCard() -> UIView {
        let cardView = UIView()
        
        cardView.frame = CGRect(x: 20, y: 200, width: cardWidth, height: cardHeight)
        cardView.layer.cornerRadius = 14
        cardView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9803921569, alpha: 1) // Color Literal, double click me
        
        // Shadow
        cardView.layer.shadowOpacity = 0.25
        cardView.layer.shadowOffset = CGSize(width: 0, height: 10)
        cardView.layer.shadowRadius = 10
        
        // Add subviews
        cardView.addSubview(self.coverImageView)
        cardView.addSubview(self.captionLabel)
        cardView.addSubview(self.descriptionLabel)
        cardView.addSubview(self.titleLabel)
        cardView.addSubview(self.closeButton)
        
        // Tap to open
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardViewTapped))
        cardView.addGestureRecognizer(tap)
        cardView.isUserInteractionEnabled = true
        
        return cardView
    }
    
    // Title
    func makeTitle(_ text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 16, y: 16, width: 272, height: 38)
        titleLabel.text = text
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        return titleLabel
    }
    
    // Caption
    func makeCaption(_ text: String) -> UILabel {
        let captionLabel = UILabel()
        captionLabel.frame = CGRect(x: 16, y: 204, width: 272, height: 40)
        captionLabel.text = text
        captionLabel.textColor = .white
        
        return captionLabel
    }
    
    // Description
    func makeDescription() -> UILabel {
        let descriptionLabel = UILabel()
        descriptionLabel.frame = CGRect(x: 20, y: 448, width: 335, height: 175)
        descriptionLabel.numberOfLines = 15
        descriptionLabel.textColor = .black
        descriptionLabel.alpha = 0 // This will be animated to 1
        descriptionLabel.text = "Bacon ipsum dolor amet pork belly drumstick picanha andouille hamburger strip steak chuck pork loin bresaola leberkas turducken rump ground round t-bone. Doner ball tip buffalo biltong sirloin. Leberkas meatball ham cow pastrami. Sirloin swine ball tip jowl burgdoggen, turducken sausage."
        
        return descriptionLabel
    }
    
    // Cover Image
    func makeCoverImage() -> UIImageView {
        let coverImageView = UIImageView()
        coverImageView.frame = CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight)
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.layer.cornerRadius = 14
        coverImageView.image = UIImage(named: "catmaid.png")
        
        return coverImageView
    }
    
    // Close button
    func makeCloseButton() -> UIButton {
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: 328, y: 20, width: 28, height: 28)
        closeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8633615154)
        closeButton.layer.cornerRadius = 14
        closeButton.alpha = 0 // This will be animated to 1
        
        // State and action
        closeButton.setImage(#imageLiteral(resourceName: "x.png"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        return closeButton
    }
    
    // MARK: ✨Animations✨
    
    // Open animation
    @objc func cardViewTapped() {
        let animator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.7) {
            // Card View
            self.cardView.frame = CGRect(x: 0, y: 0, width: self.cardWidth + 40, height: self.cardHeight + 417)
            self.cardView.layer.cornerRadius = 0
            
            // Cover image
            self.coverImageView.frame = CGRect(x: 0, y: 0, width: self.cardWidth + 40, height: self.cardHeight + 170)
            self.coverImageView.layer.cornerRadius = 0
            
            // Labels
            self.titleLabel.frame = CGRect(x: 20, y: 20, width: 374, height: 38)
            self.captionLabel.frame = CGRect(x: 20, y: 370, width: 272, height: 40)
            self.descriptionLabel.alpha = 1
            
            // Close button
            self.closeButton.alpha = 1
        }
        animator.startAnimation()
    }
    
    // Close animation
    @objc func closeButtonTapped() {
        let animator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.7) {
            // Card view
            self.cardView.frame = CGRect(x: 20, y: 255, width: self.cardWidth, height: self.cardHeight)
            self.cardView.layer.cornerRadius = 14
            
            // Cover image
            self.coverImageView.frame = CGRect(x: 0, y: 0, width: self.cardWidth, height: self.cardHeight)
            self.coverImageView.layer.cornerRadius = 14
            
            // Labels
            self.titleLabel.frame = CGRect(x: 16, y: 16, width: 272, height: 38)
            self.captionLabel.frame = CGRect(x: 16, y: 204, width: 272, height: 40)
            self.descriptionLabel.alpha = 0
            
            // Close button
            self.closeButton.alpha = 0
        }
        animator.startAnimation()
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
