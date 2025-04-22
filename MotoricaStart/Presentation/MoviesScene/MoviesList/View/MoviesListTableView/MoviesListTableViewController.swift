import UIKit

final class MoviesListTableViewController: UITableViewController {

    var viewModel: MoviesListViewModel!

    var posterImagesRepository: PosterImagesRepository?
    var nextPageLoadingSpinner: UIActivityIndicatorView?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func reload() {
        tableView.reloadData()
    }

    func updateLoading(_ loading: MoviesListViewModelLoading?) {
        switch loading {
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
            tableView.tableFooterView = nextPageLoadingSpinner
        case .fullScreen, .none:
            tableView.tableFooterView = nil
        }
    }

    // MARK: - Private
    private func setupViews() {
        tableView.estimatedRowHeight = MoviesListItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MoviesListTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items.value[indexPath.row]
        print("Item at \(indexPath.row): \(item)")
        
        switch item {
            case .movie(let movieVM):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: MoviesListItemCell.reuseIdentifier,
                    for: indexPath
                ) as? MoviesListItemCell else {
                    assertionFailure("Cannot dequeue reusable cell \(MoviesListItemCell.self) with reuseIdentifier: \(MoviesListItemCell.reuseIdentifier)")
                    return UITableViewCell()
                }
                
                cell.fill(with: movieVM, posterImagesRepository: posterImagesRepository)
                
                if indexPath.row == viewModel.items.value.count - 1 {
                    viewModel.didLoadNextPage()
                }
                
                return cell
                
            case .ad(let adVM):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: AdMovieCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? AdMovieCollectionViewCell else {
                    assertionFailure("Cannot dequeue ad cell")
                    return UITableViewCell()
                }
//                cell.configure(with: adVM)
                return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.isEmpty ? tableView.frame.height : super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
