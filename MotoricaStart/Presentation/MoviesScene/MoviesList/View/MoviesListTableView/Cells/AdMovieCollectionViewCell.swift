import UIKit

final class AdMovieCollectionViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing:AdMovieCollectionViewCell.self)
    static let height = CGFloat(130)
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    private var viewModel: AdListItemViewModel!
    private let mainQueue: DispatchQueueType = DispatchQueue.main

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        contentView.addSubview(titleLabel)
//        setupConstraints()
    }
    
//    func configure(with viewModel: AdListItemViewModel) {
//        titleLabel.text = viewModel.title
//        contentView.backgroundColor = .systemOrange // Цвет фона для рекламы
//    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
//    func fill(
//        with viewModel: AdListItemViewModel
//    ) {
//        self.viewModel = viewModel
//
//        titleLabel.text = viewModel.title
//        dateLabel.text = viewModel.releaseDate
//    }
}
