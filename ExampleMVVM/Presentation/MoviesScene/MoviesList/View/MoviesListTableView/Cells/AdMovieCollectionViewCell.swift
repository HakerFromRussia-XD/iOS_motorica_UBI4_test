import UIKit

final class AdMovieCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "AdMovieCollectionViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    func configure(with viewModel: AdListItemViewModel) {
        titleLabel.text = viewModel.title
        // Загрузка изображения через ваш NetworkService (аналогично MovieCollectionViewCell)
    }

    // Настройка layout (аналогично MovieCollectionViewCell)
}
