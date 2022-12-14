//
//  QuestionCell.swift
//  Nursing
//
//  Created by Vitaliy Zagorodnov on 31.01.2021.
//

import UIKit

final class QuestionCell: UITableViewCell {
    lazy var questionLabel = makeQuestionLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension QuestionCell {
    func configure(question: String, questionHtml: String, textSize: TextSize) {
        let attr = TextAttributes()
            .font(Fonts.SFProRounded.semiBold(size: textSize.questionFontSize))
            .textColor(UIColor.black)
            .lineHeight(textSize.questionLineHeight)
        
        questionLabel.attributedText = attributedString(for: questionHtml, textSize: textSize) ?? question.attributed(with: attr)
    }
}

// MARK: Private
private extension QuestionCell {
    func initialize() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func attributedString(for htmlString: String, textSize: TextSize) -> NSAttributedString? {
        guard !htmlString.isEmpty else {
            return nil
        }
        
        let font = Fonts.SFProRounded.semiBold(size: textSize.questionFontSize)
        let htmlWithStyle = "<span style=\"font-family: \(font.fontName); font-style: semiBold; font-size: \(font.pointSize); line-height: \(textSize.questionLineHeight)px;\">\(htmlString)</span>"
        let data = Data(htmlWithStyle.utf8)
        
        let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil
        )
        
        return attributedString
    }
}

// MARK: Make constraints
private extension QuestionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.scale),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.scale),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension QuestionCell {
    func makeQuestionLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
