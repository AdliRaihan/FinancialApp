//
//  ContentView.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 30/07/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        myAnotherContentView()
    }
}

struct myAnotherContentView: View {
    
    @State var texting = "asdasdasdasdasdasd"
    
    var body: some View {
        ScrollView.init {
            HStack {
                formViews.init(email: $texting)
                    .withAction {
                        print("From Action")
                }
                    .frame(minWidth: 0, idealWidth: 25, maxWidth: .infinity, minHeight: 0, idealHeight: 75, maxHeight: 75, alignment: .center).padding(20)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        myAnotherContentView()
    }
}

struct formViews: UIViewRepresentable {
    
    @Binding var email: String
    var masterView: myView = myView()
    
    func makeUIView(context: Context) -> UIView {
        autoreleasepool {
            return self.masterView
        }
    }
    
    func updateUIView(_ btnView: UIView, context: Context) {
        
    }
    
    func withAction(_ completeAction: @escaping ()->Void) -> formViews {
        self.masterView.closureAction = completeAction
        return self
    }
    
}

class myView: UIView {
    
    var closureAction: (() -> Void)?
    private var finButton: UIButton!
    
    
    init() {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        self.buildInterface()
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard finButton != nil else { return }
        NSLayoutConstraint.activate([
            self.finButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.finButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.finButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.finButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func buildInterface() {
        finButton = UIButton.init(frame: .zero)
        self.addSubview(finButton)
        finButton.layer.cornerRadius = 5
        finButton.layer.shadowColor = UIColor.black.cgColor
        finButton.layer.shadowRadius = 8
        finButton.layer.shadowOpacity = 0.1
        finButton.layer.shouldRasterize = true
        finButton.layer.shadowOffset = .zero
        finButton.setTitleColor(UIColor.black, for: .normal)
        finButton.backgroundColor = UIColor.systemOrange
        finButton.layer.rasterizationScale = UIScreen.main.scale
        finButton.clipsToBounds = false
        finButton.translatesAutoresizingMaskIntoConstraints = false
        finButton.addTarget(self, action: #selector(finButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func finButtonAction(_ sender:Any) {
        self.closureAction?()
    }
    
}

class myOwnAPI {
    static func callingApi() {
        print("Its Triggered!")
    }
}
