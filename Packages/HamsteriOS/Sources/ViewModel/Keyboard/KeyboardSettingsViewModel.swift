//
//  KeyboardSettingsViewModel.swift
//
//
//  Created by morse on 2023/7/12.
//

import Combine
import HamsterKeyboardKit
import HamsterKit
import OSLog
import ProgressHUD
import UIKit

public enum KeyboardSettingsSubView {
  case toolbar
  case numberNineGrid
  case symbols
  case symbolKeyboard
  case keyboardLayout
  case space
}

public enum NumberNineGridTabView {
  case settings
  case symbols
}

public enum KeyboardLayoutSegmentAction {
  case chineseLayoutSettings
  case chineseLayoutSwipeSettings
}

public class KeyboardSettingsViewModel: ObservableObject, Hashable, Identifiable {
  // MARK: - properties

  public var id = UUID()

  public var displayButtonBubbles: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displayButtonBubbles ?? true
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displayButtonBubbles = newValue
    }
  }

  public var upSwipeOnLeft: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.upSwipeOnLeft ?? true
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.upSwipeOnLeft = newValue
    }
  }

  public var swipeLabelUpAndDownLayout: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.swipeLabelUpAndDownLayout ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.swipeLabelUpAndDownLayout = newValue
    }
  }

  public var enableEmbeddedInputMode: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableEmbeddedInputMode ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableEmbeddedInputMode = newValue
    }
  }

  public var lockShiftState: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.lockShiftState ?? true
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.lockShiftState = newValue
    }
  }

  public var displaySpaceLeftButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displaySpaceLeftButton ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displaySpaceLeftButton = newValue
    }
  }

  public var spaceLeftButtonProcessByRIME: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.spaceLeftButtonProcessByRIME ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.spaceLeftButtonProcessByRIME = newValue
    }
  }

  public var keyValueOfSpaceLeftButton: String {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.keyValueOfSpaceLeftButton ?? ""
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.keyValueOfSpaceLeftButton = newValue
    }
  }

  public var displaySpaceRightButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displaySpaceRightButton ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displaySpaceRightButton = newValue
    }
  }

  public var spaceRightButtonProcessByRIME: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.spaceRightButtonProcessByRIME ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.spaceRightButtonProcessByRIME = newValue
    }
  }

  public var keyValueOfSpaceRightButton: String {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.keyValueOfSpaceRightButton ?? ""
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.keyValueOfSpaceRightButton = newValue
    }
  }

  public var displayChineseEnglishSwitchButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displayChineseEnglishSwitchButton ?? true
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displayChineseEnglishSwitchButton = newValue
    }
  }

  public var chineseEnglishSwitchButtonIsOnLeftOfSpaceButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.chineseEnglishSwitchButtonIsOnLeftOfSpaceButton ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.chineseEnglishSwitchButtonIsOnLeftOfSpaceButton = newValue
    }
  }

  public var enableToolbar: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.enableToolbar ?? true
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.enableToolbar = newValue
    }
  }

  public var displaySemicolonButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displaySemicolonButton ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displaySemicolonButton = newValue
    }
  }

  public var displayClassifySymbolButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displayClassifySymbolButton ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.displayClassifySymbolButton = newValue
    }
  }

  public var enableNineGridOfNumericKeyboard: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableNineGridOfNumericKeyboard ?? true
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableNineGridOfNumericKeyboard = newValue
    }
  }

  public var enterDirectlyOnScreenByNineGridOfNumericKeyboard: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enterDirectlyOnScreenByNineGridOfNumericKeyboard ?? true
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enterDirectlyOnScreenByNineGridOfNumericKeyboard = newValue
    }
  }

  public var enableSymbolKeyboard: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableSymbolKeyboard ?? true
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableSymbolKeyboard = newValue
    }
  }

  public var candidateWordFontSize: Int {
    get {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.candidateWordFontSize ?? 20
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.candidateWordFontSize = newValue
    }
  }

  public var heightOfToolbar: Int {
    get {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.heightOfToolbar ?? 50
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.heightOfToolbar = newValue
    }
  }

  public var heightOfCodingArea: Int {
    get {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.heightOfCodingArea ?? 10
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.heightOfCodingArea = newValue
    }
  }

  public var codingAreaFontSize: Int {
    get {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.codingAreaFontSize ?? 12
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.codingAreaFontSize = newValue
    }
  }

  public var candidateCommentFontSize: Int {
    get {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.candidateCommentFontSize ?? 12
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.candidateCommentFontSize = newValue
    }
  }

  public var displayKeyboardDismissButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.displayKeyboardDismissButton ?? true
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.displayKeyboardDismissButton = newValue
    }
  }

  public var displayIndexOfCandidateWord: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.displayIndexOfCandidateWord ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.displayIndexOfCandidateWord = newValue
    }
  }

  public var displayCommentOfCandidateWord: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.displayCommentOfCandidateWord ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.toolbar?.displayCommentOfCandidateWord = newValue
    }
  }

  public var maximumNumberOfCandidateWords: Int {
    get {
      HamsterAppDependencyContainer.shared.configuration.rime?.maximumNumberOfCandidateWords ?? 100
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.rime?.maximumNumberOfCandidateWords = newValue
    }
  }

  public var symbolsOfGridOfNumericKeyboard: [String] {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.symbolsOfGridOfNumericKeyboard ?? []
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.symbolsOfGridOfNumericKeyboard = newValue
    }
  }

  public var pairsOfSymbols: [String] {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.pairsOfSymbols ?? []
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.pairsOfSymbols = newValue
    }
  }

  public var symbolsOfCursorBack: [String] {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.symbolsOfCursorBack ?? []
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.symbolsOfCursorBack = newValue
    }
  }

  public var symbolsOfReturnToMainKeyboard: [String] {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.symbolsOfReturnToMainKeyboard ?? []
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.symbolsOfReturnToMainKeyboard = newValue
    }
  }

  public var symbolsOfChineseNineGridKeyboard: [String] {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.symbolsOfChineseNineGridKeyboard ?? []
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.symbolsOfChineseNineGridKeyboard = newValue
    }
  }

  // 是否启用空格加载文本
  public var enableLoadingTextForSpaceButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableLoadingTextForSpaceButton ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableLoadingTextForSpaceButton = newValue
    }
  }

  // 空格按钮加载文本
  public var loadingTextForSpaceButton: String {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.loadingTextForSpaceButton ?? ""
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.loadingTextForSpaceButton = newValue
    }
  }

  // 空格按钮长显文本
  public var labelTextForSpaceButton: String {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.labelTextForSpaceButton ?? ""
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.labelTextForSpaceButton = newValue
    }
  }

  // 空格按钮长显为当前输入方案
  // 当开启此选项后，labelForSpaceButton 设置的值无效
  public var showCurrentInputSchemaNameForSpaceButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.showCurrentInputSchemaNameForSpaceButton ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.showCurrentInputSchemaNameForSpaceButton = newValue
    }
  }

  // 空格按钮加载文字显示当前输入方案
  // 当开启此选项后， loadingTextForSpaceButton 设置的值无效
  public var showCurrentInputSchemaNameOnLoadingTextForSpaceButton: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.showCurrentInputSchemaNameOnLoadingTextForSpaceButton ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.showCurrentInputSchemaNameOnLoadingTextForSpaceButton = newValue
    }
  }

  /// 中文标准键盘默认划动选项
  public var chineseStanderSystemKeyboardSwipeList: [Key] {
    HamsterAppDependencyContainer.shared.configuration.swipe?.keyboardSwipe?
      .first(where: { $0.keyboardType?.isChinesePrimaryKeyboard ?? false })?
      .keys ?? []
  }

  /// 选择键盘类型
  public var useKeyboardType: KeyboardType? {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.useKeyboardType?.keyboardType
    }
    set {
      guard let keyboardType = newValue else { return }
      if case .custom(let named, _) = keyboardType {
        if !named.isEmpty {
          HamsterAppDependencyContainer.shared.configuration.Keyboard?.useKeyboardType = keyboardType.yamlString
        }
        return
      }
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.useKeyboardType = keyboardType.yamlString
    }
  }

  /// 键盘布局用户选择设置键盘类型
  public var settingsKeyboardType: KeyboardType? = nil

  /// 键盘类型
  public var keyboardLayoutList: [KeyboardType] {
    let list: [KeyboardType] = [
      .chinese(.lowercased),
      .chineseNineGrid
    ]
    return list + (HamsterAppDependencyContainer.shared.configuration.keyboards ?? []).map { $0.type }
  }

  // MARK: - combine

  // 中文九宫格符号列表编辑状态
  @Published
  public var symbolsOfChineseNineGridIsEditing: Bool = false

  @Published
  public var symbolTableIsEditing: Bool = false

  /// 键盘类型
  /// 注意：没有为属性 useKeyboardType 加 @Published 是因为不想进入键盘布局页面解决跳转
  public var useKeyboardTypeSubject = PassthroughSubject<KeyboardType, Never>()
  public var useKeyboardTypePublished: AnyPublisher<KeyboardType, Never> {
    useKeyboardTypeSubject.eraseToAnyPublisher()
  }

  /// 重置信号，当需要 table/collection 重新加载时使用
  public var resetSignSubject = PassthroughSubject<Bool, Never>()
  public var resetSignPublished: AnyPublisher<Bool, Never> {
    resetSignSubject.eraseToAnyPublisher()
  }

  /// navigation 转 subview
  private let subViewSubject = PassthroughSubject<KeyboardSettingsSubView, Never>()
  public var subViewPublished: AnyPublisher<KeyboardSettingsSubView, Never> {
    subViewSubject.eraseToAnyPublisher()
  }

  /// 数字九宫格页面切换
  private let numberNineGridSubviewSwitchSubject = CurrentValueSubject<NumberNineGridTabView, Never>(.settings)
  public var numberNineGridSubviewSwitchPublished: AnyPublisher<NumberNineGridTabView, Never> {
    numberNineGridSubviewSwitchSubject.eraseToAnyPublisher()
  }

  /// 符号设置页面切换
  private let symbolSettingsSubviewSwitchSubject = CurrentValueSubject<Int, Never>(0)
  public var symbolSettingsSubviewPublished: AnyPublisher<Int, Never> {
    symbolSettingsSubviewSwitchSubject.eraseToAnyPublisher()
  }

  /// 键盘布局 segment 切换
  private var segmentActionSubject = PassthroughSubject<KeyboardLayoutSegmentAction, Never>()
  public var segmentActionPublished: AnyPublisher<KeyboardLayoutSegmentAction, Never> {
    segmentActionSubject.eraseToAnyPublisher()
  }

  /// 按键划动设置页面
  public var keySwipeSettingsActionSubject = PassthroughSubject<(Key, KeyboardType), Never>()
  public var keySwipeSettingsActionPublished: AnyPublisher<(Key, KeyboardType), Never> {
    keySwipeSettingsActionSubject.eraseToAnyPublisher()
  }

  /// 打开文档页面
  public var openDocumentPickerSubject = PassthroughSubject<Bool, Never>()
  public var openDocumentPickerPublished: AnyPublisher<Bool, Never> {
    openDocumentPickerSubject.eraseToAnyPublisher()
  }

  /// keyboardLayout Root View Reload
  public var reloadRootViewSubject = PassthroughSubject<Bool, Never>()
  public var reloadRootViewPublished: AnyPublisher<Bool, Never> {
    reloadRootViewSubject.eraseToAnyPublisher()
  }

  /// 划动设置页面重新加载
  public var reloadKeySwipeSettingViewSubject = PassthroughSubject<(Key, KeyboardType), Never>()
  public var reloadKeySwipeSettingViewPublished: AnyPublisher<(Key, KeyboardType), Never> {
    reloadKeySwipeSettingViewSubject.eraseToAnyPublisher()
  }

  /// 划动设置页面选项弹出框
  public var alertSwipeSettingSubject = PassthroughSubject<(KeyboardActionOption, KeySwipe, Key, KeyboardType), Never>()
  public var alertSwipeSettingPublished: AnyPublisher<(KeyboardActionOption, KeySwipe, Key, KeyboardType), Never> {
    alertSwipeSettingSubject.eraseToAnyPublisher()
  }

  /// 划动设置页面删除对话框
  public var alertSwipeSettingDeleteConfirmSubject = PassthroughSubject<() -> Void, Never>()
  public var alertSwipeSettingDeleteConfirmPublished: AnyPublisher<() -> Void, Never> {
    alertSwipeSettingDeleteConfirmSubject.eraseToAnyPublisher()
  }

  /// 新增划动设置页面弹出框
  public var addAlertSwipeSettingSubject = PassthroughSubject<(KeyboardActionOption, (KeyboardAction) -> Void), Never>()
  public var addAlertSwipeSettingPublished: AnyPublisher<(KeyboardActionOption, (KeyboardAction) -> Void), Never> {
    addAlertSwipeSettingSubject.eraseToAnyPublisher()
  }

  /// 新增划动设置页面 dismiss
  public var addAlertSwipeSettingDismissSubject = PassthroughSubject<(Key, KeyboardType), Never>()
  public var addAlertSwipeSettingDismissPublished: AnyPublisher<(Key, KeyboardType), Never> {
    addAlertSwipeSettingDismissSubject.eraseToAnyPublisher()
  }

  /// 中文26键划动列表重新加载
  public var chineseStanderSystemKeyboardSwipeListReloadSubject = PassthroughSubject<Bool, Never>()
  public var chineseStanderSystemKeyboardSwipeListReloadPublished: AnyPublisher<Bool, Never> {
    chineseStanderSystemKeyboardSwipeListReloadSubject.eraseToAnyPublisher()
  }

  // MARK: - init data

  /// 键盘设置选项
  lazy var keyboardSettingsItems: [SettingSectionModel] = [
    .init(
      footer: Self.enableKeyboardAutomaticallyLowercaseRemark,
      items: [
        .init(
          text: "显示按键气泡",
          type: .toggle,
          toggleValue: { [unowned self] in displayButtonBubbles },
          toggleHandled: { [unowned self] in
            displayButtonBubbles = $0
          }),
        .init(
          text: "Shift状态锁定",
          type: .toggle,
          toggleValue: { [unowned self] in lockShiftState },
          toggleHandled: { [unowned self] in
            lockShiftState = $0
          })
      ]),

    .init(
      footer: "开启后建议调整工具栏高度为：40。\n（位置：键盘设置 -> 候选栏设置 -> 工具栏高度）",
      items: [
        .init(
          text: "启用内嵌模式",
          type: .toggle,
          toggleValue: { [unowned self] in enableEmbeddedInputMode },
          toggleHandled: { [unowned self] in
            enableEmbeddedInputMode = $0
          })
      ]),

    .init(
      items: [
        .init(
          text: "空格设置",
          accessoryType: .disclosureIndicator,
          type: .navigation,
          navigationAction: { [unowned self] in
            self.subViewSubject.send(.space)
          })
      ]),

    .init(
      footer: "关闭后，上下滑动全部显示时，右侧为显示上划，左侧显示下划。",
      items: [
        .init(
          text: "左侧显示上划",
          type: .toggle,
          toggleValue: { [unowned self] in upSwipeOnLeft },
          toggleHandled: { [unowned self] in
            upSwipeOnLeft = $0
          })
      ]),

    .init(
      footer: "默认关闭状态下，在按键上方显示上下划动符号（如果存在），开启状态下，按键上方显示上划，下方显示下划。",
      items: [
        .init(
          text: "按键上下方显示划动",
          type: .toggle,
          toggleValue: { [unowned self] in swipeLabelUpAndDownLayout },
          toggleHandled: { [unowned self] in
            swipeLabelUpAndDownLayout = $0
          })
      ]),

    .init(
      items: [
        .init(
          text: "键盘布局",
          accessoryType: .disclosureIndicator,
          type: .navigation,
          navigationAction: { [unowned self] in
            self.subViewSubject.send(.keyboardLayout)
          })
      ]
    ),
    .init(
      items: [
        .init(
          text: "候选栏设置",
          accessoryType: .disclosureIndicator,
          type: .navigation,
          navigationLinkLabel: { [unowned self] in enableToolbar ? "启用" : "禁用" },
          navigationAction: { [unowned self] in
            self.subViewSubject.send(.toolbar)
          })
      ]
    ),
    .init(
      items: [
        .init(
          text: "数字九宫格",
          accessoryType: .disclosureIndicator,
          type: .navigation,
          // navigationLinkLabel: { [unowned self] in enableNineGridOfNumericKeyboard ? "启用" : "禁用" },
          navigationAction: { [unowned self] in
            self.subViewSubject.send(.numberNineGrid)
          }),
        .init(
          text: "符号设置",
          accessoryType: .disclosureIndicator,
          type: .navigation,
          navigationAction: { [unowned self] in
            self.subViewSubject.send(.symbols)
          }),
        .init(
          text: "符号键盘",
          accessoryType: .disclosureIndicator,
          type: .navigation,
          // navigationLinkLabel: { [unowned self] in enableSymbolKeyboard ? "启用" : "禁用" },
          navigationAction: { [unowned self] in
            self.subViewSubject.send(.symbolKeyboard)
          })
      ])
  ]

  /// 中文键盘设置
  lazy var chineseStanderSystemKeyboardSettingsItems: [SettingSectionModel] = [
    .init(
      footer: "“按键位于空格左侧”选项：关闭状态则位于空格右侧，开启状态则位于空格左侧",
      items: [
        .init(
          text: "启用分号按键",
          type: .toggle,
          toggleValue: { [unowned self] in displaySemicolonButton },
          toggleHandled: { [unowned self] in
            displaySemicolonButton = $0
          }),
        .init(
          text: "启用符号按键",
          type: .toggle,
          toggleValue: { [unowned self] in displayClassifySymbolButton },
          toggleHandled: { [unowned self] in
            displayClassifySymbolButton = $0
          }),
        .init(
          text: "启用中英切换按键",
          type: .toggle,
          toggleValue: { [unowned self] in displayChineseEnglishSwitchButton },
          toggleHandled: { [unowned self] in
            displayChineseEnglishSwitchButton = $0
          }),
        .init(
          text: "按键位于空格左侧",
          type: .toggle,
          toggleValue: { [unowned self] in chineseEnglishSwitchButtonIsOnLeftOfSpaceButton },
          toggleHandled: { [unowned self] in
            chineseEnglishSwitchButtonIsOnLeftOfSpaceButton = $0
          })
      ]),
    .init(
      items: [
        .init(
          text: "启用空格左侧按键",
          type: .toggle,
          toggleValue: { [unowned self] in displaySpaceLeftButton },
          toggleHandled: { [unowned self] in
            displaySpaceLeftButton = $0
          }),
        .init(
          text: "左侧按键由RIME处理",
          type: .toggle,
          toggleValue: { [unowned self] in spaceLeftButtonProcessByRIME },
          toggleHandled: { [unowned self] in
            spaceLeftButtonProcessByRIME = $0
          }),
        .init(
          icon: UIImage(systemName: "square.and.pencil"),
          placeholder: "左侧按键键值",
          type: .textField,
          textValue: { [unowned self] in keyValueOfSpaceLeftButton },
          textHandled: { [unowned self] in
            keyValueOfSpaceLeftButton = $0
          }),
        .init(
          text: "启用空格右侧按键",
          type: .toggle,
          toggleValue: { [unowned self] in displaySpaceRightButton },
          toggleHandled: { [unowned self] in
            displaySpaceRightButton = $0
          }),
        .init(
          text: "右侧按键由RIME处理",
          type: .toggle,
          toggleValue: { [unowned self] in spaceRightButtonProcessByRIME },
          toggleHandled: { [unowned self] in
            spaceRightButtonProcessByRIME = $0
          }),
        .init(
          icon: UIImage(systemName: "square.and.pencil"),
          placeholder: "右侧按键键值",
          type: .textField,
          textValue: { [unowned self] in keyValueOfSpaceRightButton },
          textHandled: { [unowned self] in
            keyValueOfSpaceRightButton = $0
          })
      ])
  ]

  /// 工具栏设置选项
  lazy var toolbarSteppers: [StepperModel] = [
    .init(
      text: "候选字最大数量",
      value: Double(maximumNumberOfCandidateWords),
      minValue: 50,
      maxValue: 500,
      stepValue: 50,
      valueChangeHandled: { [unowned self] in
        maximumNumberOfCandidateWords = Int($0)
      }),
    .init(
      text: "候选字体大小",
      value: Double(candidateWordFontSize),
      minValue: 10,
      maxValue: 30,
      stepValue: 1,
      valueChangeHandled: { [unowned self] in
        candidateWordFontSize = Int($0)
      }),
    .init(
      text: "候选备注字体大小",
      value: Double(candidateCommentFontSize),
      minValue: 5,
      maxValue: 30,
      stepValue: 1,
      valueChangeHandled: { [unowned self] in
        candidateCommentFontSize = Int($0)
      }),
    .init(
      text: "工具栏高度",
      value: Double(heightOfToolbar),
      minValue: 30,
      maxValue: 80,
      stepValue: 1,
      valueChangeHandled: { [unowned self] in
        heightOfToolbar = Int($0)
      }),
    .init(
      text: "编码区高度",
      value: Double(heightOfCodingArea),
      minValue: 5,
      maxValue: 20,
      stepValue: 1,
      valueChangeHandled: { [unowned self] in
        heightOfCodingArea = Int($0)
      }),
    .init(
      text: "编码区字体大小",
      value: Double(codingAreaFontSize),
      minValue: 5,
      maxValue: 20,
      stepValue: 1,
      valueChangeHandled: { [unowned self] in
        codingAreaFontSize = Int($0)
      })
  ]

  lazy var toolbarToggles: [SettingItemModel] = [
    .init(
      text: "启用候选工具栏",
      toggleValue: { [unowned self] in enableToolbar },
      toggleHandled: { [unowned self] in
        enableToolbar = $0
      }),
    .init(
      text: "显示键盘收起图标",
      toggleValue: { [unowned self] in displayKeyboardDismissButton },
      toggleHandled: { [unowned self] in
        displayKeyboardDismissButton = $0
      }),
    .init(
      text: "显示候选项索引",
      toggleValue: { [unowned self] in displayIndexOfCandidateWord },
      toggleHandled: { [unowned self] in
        displayIndexOfCandidateWord = $0
      }),
    .init(
      text: "显示候选文字 Comment",
      toggleValue: { [unowned self] in displayCommentOfCandidateWord },
      toggleHandled: { [unowned self] in
        displayCommentOfCandidateWord = $0
      })
  ]

  lazy var numberNineGridSettings: [SettingItemModel] = [
    //    .init(
//      text: "启用数字九宫格",
//      type: .toggle,
//      toggleValue: enableNineGridOfNumericKeyboard,
//      toggleHandled: { [unowned self] in
//        enableNineGridOfNumericKeyboard = $0
//      }),
    .init(
      text: "符号是否直接上屏",
      type: .toggle,
      toggleValue: { [unowned self] in enterDirectlyOnScreenByNineGridOfNumericKeyboard },
      toggleHandled: { [unowned self] in
        enterDirectlyOnScreenByNineGridOfNumericKeyboard = $0
      }),
    .init(
      text: "符号列表 - 恢复默认值",
      textTintColor: .systemRed,
      type: .button,
      buttonAction: { [unowned self] in
        guard let defaultConfiguration = HamsterAppDependencyContainer.shared.defaultConfiguration else {
          throw "获取系统默认配置失败"
        }
        if let defaultSymbolsOfGridOfNumericKeyboard = defaultConfiguration.Keyboard?.symbolsOfGridOfNumericKeyboard {
          self.symbolsOfGridOfNumericKeyboard = defaultSymbolsOfGridOfNumericKeyboard
          resetSignSubject.send(true)
          ProgressHUD.showSuccess("重置成功")
        }
      })
  ]

  lazy var symbolKeyboardSettings: [SettingItemModel] = [
    //    .init(
//      text: "启用符号键盘",
//      type: .toggle,
//      toggleValue: enableSymbolKeyboard,
//      toggleHandled: { [unowned self] in
//        enableSymbolKeyboard = $0
//      }),
    .init(
      text: "常用符号 - 恢复默认值",
      textTintColor: .systemRed,
      type: .button,
      buttonAction: { [unowned self] in
        guard let defaultConfiguration = HamsterAppDependencyContainer.shared.defaultConfiguration else {
          throw "获取系统默认配置失败"
        }
        // TODO: 常用符号重置
      })
  ]

  lazy var spaceSettings: [SettingSectionModel] = [
    .init(items: [
      .init(
        icon: UIImage(systemName: "square.and.pencil"),
        placeholder: "加载文字",
        type: .textField,
        textValue: { [unowned self] in
          loadingTextForSpaceButton
        },
        textHandled: { [unowned self] in
          loadingTextForSpaceButton = $0
        })
    ]),
    .init(items: [
      .init(
        icon: UIImage(systemName: "square.and.pencil"),
        placeholder: "长显文字",
        type: .textField,
        textValue: { [unowned self] in
          labelTextForSpaceButton
        },
        textHandled: { [unowned self] in
          labelTextForSpaceButton = $0
        })
    ]),
    .init(items: [
      .init(
        text: "启用加载文字",
        type: .toggle,
        toggleValue: { [unowned self] in
          enableLoadingTextForSpaceButton
        },
        toggleHandled: { [unowned self] in
          enableLoadingTextForSpaceButton = $0
        }),
      .init(
        text: "长显显示输入方案名",
        type: .toggle,
        toggleValue: { [unowned self] in
          showCurrentInputSchemaNameForSpaceButton
        },
        toggleHandled: { [unowned self] in
          showCurrentInputSchemaNameForSpaceButton = $0
        }),
      .init(
        text: "加载文字显示输入方案名",
        type: .toggle,
        toggleValue: { [unowned self] in
          showCurrentInputSchemaNameOnLoadingTextForSpaceButton
        },
        toggleHandled: { [unowned self] in
          showCurrentInputSchemaNameOnLoadingTextForSpaceButton = $0
        })
    ])
  ]

  // MARK: - Initialization

  public init() {}

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  public static func == (lhs: KeyboardSettingsViewModel, rhs: KeyboardSettingsViewModel) -> Bool {
    lhs.id == rhs.id
  }
}

// MARK: - target-action

extension KeyboardSettingsViewModel {
  @objc func numberNineGridSegmentedControlChange(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      numberNineGridSubviewSwitchSubject.send(.settings)
      return
    }
    numberNineGridSubviewSwitchSubject.send(.symbols)
  }

  @objc func changeTableEditModel() {
    symbolTableIsEditing.toggle()
  }

  @objc func changeSymbolsOfChineseNineGridEditorState() {
    symbolsOfChineseNineGridIsEditing.toggle()
  }

  @objc func symbolsSegmentedControlChange(_ sender: UISegmentedControl) {
    symbolSettingsSubviewSwitchSubject.send(sender.selectedSegmentIndex)
  }

  @objc func chineseLayoutSegmentChangeAction(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      segmentActionSubject.send(.chineseLayoutSettings)
    case 1:
      segmentActionSubject.send(.chineseLayoutSwipeSettings)
    default:
      return
    }
  }

  /// 导入自定义键盘布局
  @objc func importCustomizeKeyboardLayout() {
    openDocumentPickerSubject.send(true)
  }

  /// 导出自定义键盘布局
  @objc func exportCustomizeKeyboardLayout() {}
}

// MARK: - KeyboardLayout 键盘布局相关

extension KeyboardSettingsViewModel {
  public struct KeyboardLayoutItem: Hashable {
    let id = UUID()
    public var keyboardType: KeyboardType
    public var checkState: Bool
    private let viewModel: KeyboardSettingsViewModel

    init(keyboardType: KeyboardType, checkState: Bool, viewModel: KeyboardSettingsViewModel) {
      self.keyboardType = keyboardType
      self.checkState = checkState
      self.viewModel = viewModel
    }

    public func setChecked() {
      viewModel.useKeyboardType = keyboardType
      viewModel.reloadRootViewSubject.send(true)
    }

    public func settings() {
      viewModel.settingsKeyboardType = keyboardType
      viewModel.useKeyboardTypeSubject.send(keyboardType)
    }

    public static func == (lhs: KeyboardSettingsViewModel.KeyboardLayoutItem, rhs: KeyboardSettingsViewModel.KeyboardLayoutItem) -> Bool {
      lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
  }

  /// 键盘布局总列表 DataSource
  func initKeyboardLayoutDataSource() -> NSDiffableDataSourceSnapshot<Int, KeyboardSettingsViewModel.KeyboardLayoutItem> {
    var snapshot = NSDiffableDataSourceSnapshot<Int, KeyboardSettingsViewModel.KeyboardLayoutItem>()
    snapshot.appendSections([0])

    let item = keyboardLayoutList.map {
      KeyboardSettingsViewModel.KeyboardLayoutItem(keyboardType: $0, checkState: $0 == self.useKeyboardType, viewModel: self)
    }
    snapshot.appendItems(item, toSection: 0)
    return snapshot
  }

  /// 自定义键盘列表 DataSource
//  func initCustomizerKeyboardLayoutDataSource() -> NSDiffableDataSourceSnapshot<Int, KeyboardType> {
//    var snapshot = NSDiffableDataSourceSnapshot<Int, KeyboardType>()
//    snapshot.appendSections([0])
//    snapshot.appendItems(customizeKeyboardLayoutList, toSection: 0)
//    return snapshot
//  }

  /// 中文26键盘布局 DataSource
  func initChineseStanderSystemKeyboardDataSource() -> NSDiffableDataSourceSnapshot<SettingSectionModel, SettingItemModel> {
    var snapshot = NSDiffableDataSourceSnapshot<SettingSectionModel, SettingItemModel>()
    snapshot.appendSections(chineseStanderSystemKeyboardSettingsItems)
    chineseStanderSystemKeyboardSettingsItems.forEach { item in
      snapshot.appendItems(item.items, toSection: item)
    }
    return snapshot
  }

  /// 中文26键盘划动 DataSource
  func initChineseStanderSystemKeyboardSwipeDataSource() -> NSDiffableDataSourceSnapshot<Int, Key> {
    var snapshot = NSDiffableDataSourceSnapshot<Int, Key>()
    snapshot.appendSections([0])
    snapshot.appendItems(chineseStanderSystemKeyboardSwipeList, toSection: 0)
    return snapshot
  }

  /// 导入自定义键盘布局
  public func importCustomizeKeyboardLayout(fileURL: URL) async {
    Logger.statistics.debug("importCustomizeKeyboardLayout fileName: \(fileURL.path)")
    await ProgressHUD.show("导入中……", interaction: false)
    // 检测是否为iCloudURL, 需要特殊处理
    var needAccessingSecurity = false
    if fileURL.path.contains("com~apple~CloudDocs") || fileURL.path.contains("iCloud~dev~fuxiao~app~hamsterapp") {
      needAccessingSecurity = true
      // iCloud中的URL须添加安全访问资源语句，否则会异常：Operation not permitted
      // startAccessingSecurityScopedResource与stopAccessingSecurityScopedResource必须成对出现
      if !fileURL.startAccessingSecurityScopedResource() {
        await ProgressHUD.showError("导入文件读取受限，无法加载文件", interaction: false, delay: 1.5)
        return
      }
    }

    // 加载自定义键盘配置文件
    do {
      let keyboards = try HamsterConfigurationRepositories.shared.loadCustomizerKeyboardLayoutYAML(fileURL)

      // 停止读取url文件
      if needAccessingSecurity { fileURL.stopAccessingSecurityScopedResource() }

      // 内置键盘
      // 注意：.filter 会过滤掉与导入键盘名称相同的键盘
      let originalKeyboards = (HamsterAppDependencyContainer.shared.configuration.keyboards ?? [])
        .filter {
          for importKeyboard in keyboards.keyboards {
            if importKeyboard.type == $0.type {
              return false
            }
          }
          return true
        }

      HamsterAppDependencyContainer.shared.configuration.keyboards = originalKeyboards + keyboards.keyboards

      await ProgressHUD.showSuccess("导入成功", interaction: false, delay: 1.5)
      reloadRootViewSubject.send(true)
    } catch {
      Logger.statistics.error("importCustomizeKeyboardLayout error: \(error)")
      await ProgressHUD.showError("自定义键盘配置文件加载失败", interaction: false, delay: 1.5)
      return
    }
  }

  /// 删除自定义键盘布局
  func deleteCustomizeKeyboardLayout(_ keyboardType: KeyboardType) {
    var keyboards = HamsterAppDependencyContainer.shared.configuration.keyboards ?? []
    if let index = keyboards.firstIndex(where: { $0.type == keyboardType }) {
      keyboards.remove(at: index)
      HamsterAppDependencyContainer.shared.configuration.keyboards = keyboards
      ProgressHUD.showSuccess("删除成功", interaction: false, delay: 1.5)
      reloadRootViewSubject.send(true)
    } else {
      ProgressHUD.showFailed("未找到此键盘", interaction: false, delay: 1.5)
    }
  }
}

// MARK: - Swipe Settings

extension KeyboardSettingsViewModel {
  /// App中可以用来下拉选择的 KeyboardAction
  /// 注意：需要与 Customize/Yaml/Models.swift 中扩展的 String 方法内 var keyboardAction: KeyboardAction 的选项对应, 否则无法序列化
  public enum KeyboardActionOption: CaseIterable, Comparable {
    case character
    case symbol
    case shortCommand
    case keyboardType

    var option: String {
      switch self {
      case .character: "字符（由 RIME 处理）"
      case .symbol: "符号字符（不由 RIME 处理）"
      case .shortCommand: "快捷指令"
      case .keyboardType: "切换键盘"
      }
    }
  }

  /// App中可以用来下拉选择的 KeyboardAction
  /// 注意：需要与 Customize/Yaml/Models.swift 中扩展的 String 方法内  var keyboardType: KeyboardType 的选项对应, 否则无法序列化
  public enum KeyboardTypeOption: CaseIterable {
    case alphabetic
    case chinese
    case classifySymbolic
    case chineseNineGrid
    case numericNineGrid
    case custom
    case emojis

    var option: String {
      switch self {
      case .alphabetic: "英文键盘"
      case .chinese: "中文26键键盘"
      case .classifySymbolic: "分类符号键盘"
      case .chineseNineGrid: "中文九宫格键盘"
      case .numericNineGrid: "数字九宫格键盘"
      case .custom: "自定义键盘"
      case .emojis: "Emojis键盘"
      }
    }

    var keyboardType: KeyboardType? {
      switch self {
      case .alphabetic: return .alphabetic(.lowercased)
      case .chinese: return .chinese(.lowercased)
      case .classifySymbolic: return .classifySymbolic
      case .chineseNineGrid: return .chineseNumeric
      case .numericNineGrid: return .numericNineGrid
      case .emojis: return .emojis
      default:
        return nil
      }
    }
  }

  /// 获取新增 Swipe 设置项
  func addKeySwipeSettingItems(
    _ key: Key,
    keySwipe: KeySwipe,
    setDirection: @escaping (KeySwipe.Direction) -> Void,
    setActionOption: @escaping (KeyboardActionOption) -> Void,
    setLabelText: @escaping (String) -> Void,
    setShowLabel: @escaping (Bool) -> Void,
    saveHandle: @escaping () -> Void) -> [SettingSectionModel]
  {
    let swipeSettingItems = [
      SettingSectionModel(
        items: [
          .init(
            text: "按键操作",
            type: .textField,
            textValue: { key.action.yamlString },
            textFieldShouldBeginEditing: false)
        ]),
      SettingSectionModel(items: [
        .init(
          text: "划动方向",
          type: .PullDown,
          textValue: { keySwipe.direction.labelText },
          pullDownMenuActionsBuilder: {
            KeySwipe.Direction.allCases
              .map { direction in
                UIAction(title: direction.labelText) { _ in
                  if let _ = key.swipe.first(where: { swipe in swipe.direction == direction }) {
                    ProgressHUD.showError("划动方向:\(direction.labelText) 配置已存在")
                    return
                  }
                  setDirection(direction)
                }
              }
          }),
        .init(
          text: "划动操作",
          type: .PullDown,
          textValue: { keySwipe.action.yamlString },
          pullDownMenuActionsBuilder: {
            KeyboardActionOption.allCases
              .map { action in
                UIAction(title: action.option) { _ in
                  setActionOption(action)
                }
              }
          }),
        .init(
          text: "键盘显示文本",
          placeholder: "显示文本",
          type: .textField,
          textValue: { keySwipe.label.text },
          textHandled: { labelText in
            setLabelText(labelText)
          }),
        .init(
          text: "是否显示文本",
          type: .toggle,
          toggleValue: { keySwipe.display },
          toggleHandled: { display in
            setShowLabel(display)
          }),
        .init(
          text: "保存",
          type: .button,
          buttonAction: {
            saveHandle()
          })
      ])
    ]

    return swipeSettingItems
  }

  /// 将 key 变为设置属性, 方便 Tabel 展示
  func getSettingsItems(_ key: Key, keyboardType: KeyboardType) -> [SettingSectionModel] {
    var swipeSettingsItem: [SettingSectionModel] = [
      .init(
        items: [
          .init(
            text: "按键操作",
            type: .textField,
            textValue: { key.action.yamlString },
            textFieldShouldBeginEditing: false)

        ])
    ]

    for swipe in key.swipe.sorted(by: { $0.direction > $1.direction }) {
      swipeSettingsItem.append(SettingSectionModel(
        items: [
          .init(
            text: "划动方向",
            type: .PullDown,
            textValue: { swipe.direction.labelText },
            pullDownMenuActionsBuilder: {
              let setupDirection = { [unowned self] (direction: KeySwipe.Direction) in
                var key = key
                var swipe = swipe
                // 删除原先的滑动方向配置
                key.swipe.removeAll(where: { $0.direction == swipe.direction })
                guard !key.swipe.contains(where: { $0.direction == direction }) else {
                  ProgressHUD.showError("划动方向：\(direction.labelText) 已存在。")
                  return
                }
                swipe.direction = direction
                key.swipe.append(swipe)
                key.swipe.sort(by: { $0.direction > $1.direction })
                self.saveKeySwipe(key, keyboardType: keyboardType)
                // 添加刷新表格操作
                self.reloadKeySwipeSettingViewSubject.send((key, keyboardType))
              }

              return KeySwipe.Direction.allCases
                .map { direction in
                  UIAction(title: direction.labelText) { _ in
                    setupDirection(direction)
                  }
                }
            }),
          .init(
            text: "划动操作",
            type: .PullDown,
            textValue: { swipe.action.yamlString },
            pullDownMenuActionsBuilder: {
              let setupAction = { [unowned self] (option: KeyboardActionOption) in
                // 通知划动设置 controller 弹出设置对话框
                self.alertSwipeSettingSubject.send((option, swipe, key, keyboardType))
              }

              return KeyboardActionOption.allCases
                .map { action in
                  UIAction(title: action.option) { _ in
                    setupAction(action)
                  }
                }
            }),
          .init(
            text: "键盘显示文本",
            placeholder: "显示文本",
            type: .textField,
            textValue: { swipe.label.text },
            textHandled: { labelText in
              var key = key
              var swipe = swipe
              swipe.label = KeyLabel(loadingText: "", text: labelText)
              key.swipe.removeAll(where: { $0.direction == swipe.direction })
              key.swipe.append(swipe)
              self.saveKeySwipe(key, keyboardType: keyboardType)
            }),
          .init(
            text: "是否显示文本",
            type: .toggle,
            toggleValue: { swipe.display },
            toggleHandled: { display in
              var key = key
              var swipe = swipe
              swipe.display = display
              key.swipe.removeAll(where: { $0.direction == swipe.direction })
              key.swipe.append(swipe)
              self.saveKeySwipe(key, keyboardType: keyboardType)
            }),
          .init(
            text: "删除",
            textTintColor: .systemRed,
            type: .button,
            buttonAction: { [unowned self] in
              alertSwipeSettingDeleteConfirmSubject.send {
                var key = key
                key.swipe.removeAll(where: { $0.direction == swipe.direction })
                self.saveKeySwipe(key, keyboardType: keyboardType)
                self.reloadKeySwipeSettingViewSubject.send((key, keyboardType))
              }
            })
        ]
      ))
    }

    return swipeSettingsItem
  }

  func saveKeySwipe(_ key: Key, keyboardType: KeyboardType) {
    if var keyboardSwipe = HamsterAppDependencyContainer.shared.configuration.swipe?.keyboardSwipe,
       var keyboard = keyboardSwipe.first(where: { $0.keyboardType == keyboardType })
    {
      if let keyIndex = keyboard.keys?.firstIndex(where: { $0.action == key.action }) {
        keyboard.keys?[keyIndex] = key
      } else {
        keyboard.keys?.append(key)
      }

      keyboardSwipe.removeAll(where: { $0.keyboardType == keyboardType })
      keyboardSwipe.append(keyboard)
      HamsterAppDependencyContainer.shared.configuration.swipe?.keyboardSwipe = keyboardSwipe
    }
  }

  func deleteKeySwipe(_ key: Key, swipe: KeySwipe, keyboardType: KeyboardType) {
    if var keyboardSwipe = HamsterAppDependencyContainer.shared.configuration.swipe?.keyboardSwipe,
       var keyboard = keyboardSwipe.first(where: { $0.keyboardType == keyboardType })
    {
      if let keyIndex = keyboard.keys?.firstIndex(where: { $0.action == key.action }) {
        keyboard.keys?[keyIndex] = key
      } else {
        keyboard.keys?.append(key)
      }

      keyboardSwipe.removeAll(where: { $0.keyboardType == keyboardType })
      keyboardSwipe.append(keyboard)
      HamsterAppDependencyContainer.shared.configuration.swipe?.keyboardSwipe = keyboardSwipe
    }
  }

  /// 判断划动的 Key 是否存在
  func swipeKeyExists(_ key: Key, keyboardType: KeyboardType) -> Bool {
    if let keyboardSwipe = HamsterAppDependencyContainer.shared.configuration.swipe?.keyboardSwipe,
       let keyboard = keyboardSwipe.first(where: { $0.keyboardType == keyboardType })
    {
      return keyboard.keys?.contains(where: { $0.action == key.action }) ?? false
    }
    return false
  }
}

// MARK: - Constants

public extension KeyboardSettingsViewModel {
  static let symbolKeyboardRemark = "启用后，常规符号键盘将被替换为符号键盘。常规符号键盘布局类似系统自带键盘符号布局。"
  static let enableKeyboardAutomaticallyLowercaseRemark = "关闭后，Shift状态随当前输入状态变化。注意: 双击Shift会保持锁定"
}

extension KeyboardType {
  var label: String {
    switch self {
    case .chinese: return "中文26键"
    case .chineseNineGrid: return "中文9键"
    case .custom(let name, _): return name.isEmpty ? "自定义键盘" : "自定义-\(name)"
    case .numericNineGrid: return "数字九宫格"
    default: return ""
    }
  }

  var yamlString: String {
    switch self {
    case .chinese: return "chinese"
    case .chineseNineGrid: return "chineseNineGrid"
    case .custom(let name, _): return "custom(\(name))"
    default: return ""
    }
  }
}
