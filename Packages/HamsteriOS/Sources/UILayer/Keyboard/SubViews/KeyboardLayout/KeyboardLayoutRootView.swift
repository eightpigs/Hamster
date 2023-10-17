//
//  KeyboardLayoutRootView.swift
//
//
//  Created by morse on 2023/9/13.
//

import Combine
import HamsterKeyboardKit
import HamsterUIKit
import UIKit

class KeyboardLayoutRootView: NibLessView {
  private let keyboardSettingsViewModel: KeyboardSettingsViewModel
  private var subscriptions = Set<AnyCancellable>()

  private lazy var listView: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
      var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
      configuration.footerMode = .supplementary
      configuration.trailingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
        let keyboardType = diffableDataSource.snapshot(for: indexPath.section).items[indexPath.item]
        let action: UIContextualAction

        if keyboardType.isCustom {
          action = UIContextualAction(style: .destructive, title: "删除", handler: { [unowned self] _, _, completion in
            keyboardSettingsViewModel.deleteCustomizeKeyboardLayout(keyboardType)
            completion(true)
          })
          action.backgroundColor = .systemRed
        } else {
          action = UIContextualAction(style: .normal, title: "设置", handler: { [unowned self] _, _, completion in
            keyboardSettingsAction(keyboardType)
            completion(true)
          })
          action.backgroundColor = .systemBlue
        }
        return UISwipeActionsConfiguration(actions: [action])
      }
      let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
      return section
    }

    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.delegate = self
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, KeyboardType> = {
    let dataSource = makeDataSource()
    return dataSource
  }()

  init(keyboardSettingsViewModel: KeyboardSettingsViewModel) {
    self.keyboardSettingsViewModel = keyboardSettingsViewModel

    super.init(frame: .zero)

    addSubview(listView)
    listView.fillSuperview()

    loadDataSource()

    keyboardSettingsViewModel.reloadRootViewPublished
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] _ in
        loadDataSource()
      }
      .store(in: &subscriptions)
  }
}

extension KeyboardLayoutRootView {
  func loadDataSource() {
    self.diffableDataSource.apply(keyboardSettingsViewModel.initKeyboardLayoutDataSource(), animatingDifferences: false)
    if let index = self.diffableDataSource.snapshot(for: 0).items.firstIndex(where: { $0 == keyboardSettingsViewModel.useKeyboardType }) {
      self.listView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .centeredVertically)
    }
  }

  func cellRegistration() -> UICollectionView.CellRegistration<KeyboardLayoutCell, KeyboardType> {
    UICollectionView.CellRegistration { cell, _, item in
      cell.label.text = item.label
      if !item.isCustom {
        cell.accessories = [.disclosureIndicator()]
      }
    }
  }

  /// 页脚配置
  func footerRegistration() -> UICollectionView.SupplementaryRegistration<UICollectionViewListCell> {
    UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionFooter) { footerView, _, _ in
      var configuration = footerView.defaultContentConfiguration()
      configuration.text = """
      注意：
      1. 内置键盘向左滑动进入设置页面。
      2. 自定义布局通过配置文件调整，调整后需重新部署。
      """
      configuration.textProperties.font = UIFont.preferredFont(forTextStyle: .caption2)
      configuration.textProperties.color = UIColor.secondaryLabel
      footerView.contentConfiguration = configuration
    }
  }

  func makeDataSource() -> UICollectionViewDiffableDataSource<Int, KeyboardType> {
    let cellRegistration = cellRegistration()
    let footerRegistration = footerRegistration()

    let dataSource = UICollectionViewDiffableDataSource<Int, KeyboardType>(
      collectionView: listView,
      cellProvider: { collectionView, indexPath, item in
        collectionView.dequeueConfiguredReusableCell(
          using: cellRegistration,
          for: indexPath,
          item: item
        )
      }
    )

    dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath -> UICollectionReusableView? in
      if elementKind == UICollectionView.elementKindSectionFooter {
        return collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
      }
      return nil
    }

    return dataSource
  }

  /// 内置键盘设置页面
  func keyboardSettingsAction(_ keyboardType: KeyboardType) {
    guard !keyboardType.isCustom else { return }
    keyboardSettingsViewModel.settingsKeyboardType = keyboardType
    keyboardSettingsViewModel.useKeyboardTypeSubject.send(keyboardType)
  }
}

extension KeyboardLayoutRootView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let keyboardType = diffableDataSource.snapshot(for: indexPath.section).items[indexPath.item]
    keyboardSettingsViewModel.useKeyboardType = keyboardType
  }
}
