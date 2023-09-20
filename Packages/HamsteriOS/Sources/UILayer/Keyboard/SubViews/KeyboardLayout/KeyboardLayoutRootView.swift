//
//  KeyboardLayoutRootView.swift
//
//
//  Created by morse on 2023/9/13.
//

import HamsterKeyboardKit
import HamsterUIKit
import UIKit

class KeyboardLayoutRootView: NibLessCollectionView {
  private let keyboardSettingsViewModel: KeyboardSettingsViewModel

  private var diffableDataSource: UICollectionViewDiffableDataSource<Int, KeyboardType>!

  init(keyboardSettingsViewModel: KeyboardSettingsViewModel) {
    self.keyboardSettingsViewModel = keyboardSettingsViewModel

    let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
      let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
      let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
      return section
    }

    super.init(frame: .zero, collectionViewLayout: layout)

    self.delegate = self
    self.diffableDataSource = makeDataSource()
  }

  override func didMoveToWindow() {
    super.didMoveToWindow()

    self.diffableDataSource.apply(keyboardSettingsViewModel.initKeyboardLayoutDataSource(), animatingDifferences: false)
    if let index = self.diffableDataSource.snapshot(for: 0).items.firstIndex(where: { $0 == keyboardSettingsViewModel.useKeyboardType }) {
      self.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .centeredVertically)
    }
  }
}

extension KeyboardLayoutRootView {
  func cellRegistration() -> UICollectionView.CellRegistration<KeyboardLayoutCell, KeyboardType> {
    UICollectionView.CellRegistration { cell, _, item in
      cell.label.text = item.label
      if !item.isCustom {
        cell.accessories = [.disclosureIndicator()]
      }
    }
  }

  func makeDataSource() -> UICollectionViewDiffableDataSource<Int, KeyboardType> {
    let cellRegistration = cellRegistration()
    return UICollectionViewDiffableDataSource(
      collectionView: self,
      cellProvider: { collectionView, indexPath, item in
        collectionView.dequeueConfiguredReusableCell(
          using: cellRegistration,
          for: indexPath,
          item: item
        )
      }
    )
  }
}

extension KeyboardLayoutRootView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let keyboardType = diffableDataSource.snapshot(for: indexPath.section).items[indexPath.item]
    keyboardSettingsViewModel.useKeyboardType = keyboardType
    if !keyboardType.isCustom {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
        keyboardSettingsViewModel.useKeyboardTypeSubject.send(keyboardType)
      }
    }
  }
}
