//
//  AppCoordinator.swift
//  iStudy
//
//  Created by Kien Trung on 2022/11/11.
//

import Foundation
import RxCocoa
import SwiftUI

// swiftlint:disable type_body_length
class AppCoordinator: NavigationCoordinator<AppRoute> {
    override init(rootViewController: NavigationCoordinator<RouteType>.RootViewController = .init(), initialRoute: RouteType? = nil) {
        super.init(rootViewController: rootViewController, initialRoute: initialRoute)
    }
    
    // swiftlint:disable cyclomatic_complexity function_body_length
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        if rootViewController.isNavigationBarHidden {
            rootViewController.setNavigationBarHidden(false, animated: false)
        }
        switch route {
            //MARK: - Select Language
        case .selectLanguage:
            let viewModel = SelectLanguageViewModel(with: weakRouter)
            let selectLanguage = SelectLanguageViewController.newInstance(with: viewModel)
            return .push(selectLanguage)
            
            //MARK: - Auth
        case .login:
            let viewModel = SignInViewModel(with: weakRouter)
            let vc = SignInViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case .mainRegister:
            let viewModel = SignUpViewModel(with: weakRouter)
            let vc = SignUpViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case let .subRegisger(phoneNo):
            let viewModel = SignUpUserPassViewModel(with: weakRouter, phoneNo: phoneNo)
            let vc = SignUpUserPassViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case let .forgotPassword(phoneNo):
            let viewModel = ForgotPasswordViewModel(with: weakRouter,phoneNo)
            let vc = ForgotPasswordViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case let .createNewPassword(phoneNo, optCode):
            let viewModel = CreateNewPasswordViewModel(with: weakRouter, phoneNo: phoneNo, otpCode: optCode)
            let vc = CreateNewPasswordViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case .logout:
            let coordinator = AppCoordinator(initialRoute: .login)
            coordinator.rootViewController.modalPresentationStyle = .fullScreen
            AppDelegate.shared?.appCoordinator = coordinator
            AppDelegate.shared?.rootCoordinator = nil
            return .presentOnRoot(coordinator, animation: .push)
            
            //MARK: - HOME
        case .tabbar:
            let coordinator = RootTabBarCoordinator()
            coordinator.rootViewController.modalPresentationStyle = .fullScreen
            AppDelegate.shared?.rootCoordinator = coordinator
            
            
            return .presentOnRoot(coordinator, animation: .push)
            //                let homeCoordinator = AppCoordinator(initialRoute: .home)
            //                homeCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "ic_menu_home"), tag: 0)
            //
            //                let digitizingCoordinator = AppCoordinator(initialRoute: .digitizing)
            //                digitizingCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Digitizing", image: #imageLiteral(resourceName: "scan-documents"), tag: 0)
            //
            //                let reviewCoordinator = AppCoordinator(initialRoute: .review)
            //                reviewCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Review", image: #imageLiteral(resourceName: "BookBookmark"), tag: 0)
            //
            //                let controllers = [homeCoordinator.rootViewController, digitizingCoordinator.rootViewController, reviewCoordinator.rootViewController]
            //                let tabBarController = BubbleTabBarController()
            //                tabBarController.viewControllers = controllers
            //                tabBarController.tabBar.tintColor = #colorLiteral(red: 0.3019607843, green: 0.5411764706, blue: 0.9411764706, alpha: 1)
            //
            //                let coordinator = TabBarCoordinator<TabRoute>(rootViewController: tabBarController, tabs: controllers, select: homeCoordinator)
            //                coordinator.rootViewController.modalPresentationStyle = .fullScreen
            //
            //                return .presentOnRoot(coordinator)
            
        case .notify:
            let viewModel = NotificationViewModel(with: weakRouter)
            let notifyVC = NotificationViewController.newInstance(with: viewModel)
            return .push(notifyVC)
            
        case .setting:
            let viewModel = SettingViewModel(with: weakRouter)
            let settingVC = SettingViewController.newInstance(with: viewModel)
            return .push(settingVC)
            
        case .home:
            let viewModel = HomeViewModel(with: weakRouter)
            let homeVC = HomeViewController.newInstance(with: viewModel)
            return .push(homeVC)
            
        case .searchDetail(let keyword):
            let viewModel = SearchResultsViewModel(with: weakRouter, keyword: keyword)
            let searchDetailVC = SearchResultsViewController.newInstance(with: viewModel)
            return .push(searchDetailVC)
            
        case .newFieldOfStudy:
            let viewNewField = NewFieldViewModel(with: weakRouter)
            let newFieldOfStudyVC = NewFieldViewController.newInstance(with: viewNewField)
            return .push(newFieldOfStudyVC)
            
        case let .editField(id, icon_path):
            let viewNewField = NewFieldViewModel(with: weakRouter, field_id: id, icon_path: icon_path)
            let newFieldOfStudyVC = NewFieldViewController.newInstance(with: viewNewField)
            return .push(newFieldOfStudyVC)
            
        case let .topicDetails(topic, user_id, owner):
            let viewModel = FieldDetailViewModel(with: weakRouter, topic: topic, user_id: user_id, owner :owner)
            let vc = FieldDetailViewController.newInstance(with: viewModel)
            
            return .push(vc)
            
        case let .topics(field):
            let viewModel = TopicsViewModel(with: weakRouter, field: field)
            let vc = TopicsViewController.newInstance(with: viewModel)
            
            return .push(vc)
            
        case .createTopic(let ID, let completion):
            let viewModel = CreateTopicViewModel(
                with: weakRouter,
                type: .create(fieldID: ID, completion: completion)
            )
            let createTopicVC = CreateTopicViewController.newInstance(with: viewModel)
            
            return .push(createTopicVC)
            
        case .editTopic(let topic, let completion):
            let viewModel = CreateTopicViewModel(with: weakRouter, type: .edit(topic, completion))
            let createTopicVC = CreateTopicViewController.newInstance(with: viewModel)
            
            return .push(createTopicVC)
            
        case .welcome:
            let viewModel = BaseViewModel(with: weakRouter)
            let welcomeVC = WelcomeViewController.newInstance(with: viewModel)
            return .push(welcomeVC)
            
        case let .notifyDetails(model):
            let viewModel = NotificationDetailViewModel(with: weakRouter, data: model)
            let vc = NotificationDetailViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case let .profile(user):
            let viewModel = ProfileViewModel(with: weakRouter, user: user)
            let profileVC = ProfileViewController.newInstance(with: viewModel)
            return .push(profileVC)
            
        case let .changePassword(user):
            let viewModel = ChangePasswordViewModel(with: weakRouter, user: user)
            let changePasswordVC = ChangePasswordViewController.newInstance(with: viewModel)
            return .push(changePasswordVC)
            
        case .language:
            let viewModel = LanguageViewModel(with: weakRouter)
            let languageVC = LanguageViewController.newInstance(with: viewModel)
            return .push(languageVC)
            
        case let .invite(lessonId):
            let viewModel = InviteViewModel(with: weakRouter, lessonId: lessonId)
            let vc = InviteViewController.newInstance(with: viewModel)
            return .presentPopup(vc)
            
        case let .newLesson(mode, topicID):
            let viewModel = LessonViewModel(with: weakRouter, mode: mode, topicID: topicID, lessonID: 0)
            let vc = LessonViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case let .editLesson(topicID, lessonID, completion):
            let viewModel = LessonViewModel(
                with: weakRouter,
                mode: .update,
                topicID: topicID,
                lessonID: lessonID
            )
            let vc = LessonViewController.newInstance(with: viewModel)
            vc.completionBlock = completion
            return .push(vc)
            
        case let .lessonDetail(id, isFavorites):
//            let viewModel = LessonViewModel(with: weakRouter, id: id, name: name, fieldId: fieldId, isFavorites: isFavorites)
//            let vc = LessonViewController.newInstance(with: viewModel)
            
            let viewModel = LessonDetailViewModel(with: weakRouter, lessonID: id, isFavorites: isFavorites)

            let vc = LessonDetailViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case let .reminder(observerReminder):
            let viewModel = ReminderViewModel(with: weakRouter, observerReminder: observerReminder)
            let vc = LessonReminderViewController.newInstance(with: viewModel)
            
            return .push(vc)
            
        case let .choiceAField(callback):
            let viewModel = ChooseAFieldViewModel(with: weakRouter, completionHandler: callback)
            let vc = ChooseAFieldViewController.newInstance(with: viewModel)
            
            return .push(vc)
            
        case let .choiceATopic(field, completion):
            let viewModel = ChooseTopicViewModel(
                with: weakRouter,
                field: field,
                completionHandler: completion
            )
            
            let vc = ChooseTopicViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case let .selectObjectDialog(callback, value):
            let vc = SelectObjectPopupViewController(nibName: "SelectObjectPopupViewController", bundle: nil)
            vc.selectObjectValue = value
            vc.dismissCallBack = callback
            
            return .presentPopup(vc)
            
        case let .priorityDialog(callback, value):
            let vc = PriorityPopupViewController(nibName: "PriorityPopupViewController", bundle: nil)
            vc.dismissCallBack = callback
            vc.prioritySelectedItem = value
            
            return .presentPopup(vc)
            
        case .createKeyword:
            let viewModel = KeywordViewModel(with: weakRouter)
            let vc = KeywordViewController.newInstance(with: viewModel)
            return .presentPopup(vc)
            
        case .createQuestion:
            let viewModel = QuestionViewModel(with: weakRouter)
            let vc = QuestionViewController.newInstance(with: viewModel)
            return .presentPopup(vc)
            
        case .learningGoal:
            let viewModel = LearningGoalViewModel(with: weakRouter)
            let vc = LearningGoalPopupViewController.newInstance(with: viewModel)
            return .presentPopup(vc)
            
        case let .editGoal(callback):
            let viewModel = LearningGoalViewModel(with: weakRouter)
            let vc = EditGoalPopupViewController.newInstance(with: viewModel)
            vc.dismissCallBack = callback
            
            return .presentPopup(vc)
            
        case .schedule:
            let viewModel = ScheduleViewModel(with: weakRouter)
            let vc = ScheduleViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case .invalidToken:
            let coordinator = AppCoordinator(initialRoute: .login)
            coordinator.rootViewController.modalPresentationStyle = .fullScreen
            AppDelegate.shared?.appCoordinator = coordinator
            return .presentOnRoot(coordinator, animation: .push)
            
            //MARK: - DIGITIZING
        case .digitizing:
            let viewModel = DigitizingViewModel(with: weakRouter)
            let digitizing = DigitizingViewController.newInstance(with: viewModel)
            return .push(digitizing)
            
        case let .textToSpeech(flow, model):
            if let model = model {
                let viewModel = TextToSpeechViewModel(with: weakRouter, flow: flow, model: model)
                let vc = TextToSpeechViewController.newInstance(with: viewModel)
                return .push(vc)
            } else {
                let viewModel = TextToSpeechViewModel(with: weakRouter, flow: flow)
                let vc = TextToSpeechViewController.newInstance(with: viewModel)
                return .push(vc)
            }
            
        case let .saveRecordDialog(inputTextSubject):
            let viewModel = BaseViewModel(with: weakRouter)
            let vc = SaveRecordDialogViewController(recordNameTrigger: inputTextSubject)
            vc.bind(to: viewModel)
            return .presentPopup(vc)
            
        case .imageToText:
            let viewModel = BaseViewModel(with: weakRouter)
            let vc = ImageToTextViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case let .imageToTextConvert(imageArray):
            let viewModel = ImageToTextConvertViewViewModel(with: weakRouter, images: imageArray)
            let vc = ImageToTextConvertViewController.newInstance(with: viewModel)
            return .push(vc)
            
            //MARK: - REVIEW
        case .review:
            let viewModel = ReviewViewModel(with: weakRouter)
            let review = ReviewViewController.newInstance(with: viewModel)
            return .push(review)
            
        case .favorite:
            let viewModel = FavoriteViewModel(with: weakRouter)
            let favorite = FavoriteViewController.newInstance(with: viewModel)
            return .push(favorite)
            
        case .addSchedule:
            let viewModel = AddScheduleViewModel(with: weakRouter)
            let vc = AddScheduleViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case let .editSchedule(model):
            let viewModel = AddScheduleViewModel(with: weakRouter, model: model)
            let vc = AddScheduleViewController.newInstance(with: viewModel)
            return .push(vc)
            
        case .community:
            let viewModel = CommunityViewModel(with: weakRouter)
            let homeVC = CommunityViewController.newInstance(with: viewModel)
            return .push(homeVC)
            
        case .authorDetail(let user):
            let viewModel = AuthorViewModel(authorId: user.id ?? 0, router: weakRouter)
            let authorVC = AuthorViewController.newInstance(with: viewModel)
            return .push(authorVC)
            
        case let .takeATest(questions, lessonId, repeats):
            let vc = TakeToTestViewController()
            vc.repeats = repeats
            vc.lessonId = lessonId
            vc.questions = questions
            vc.modalPresentationStyle = .fullScreen
            return .present(vc)
        case let .zoomContent(content, lesson_id):
            let vc  = LessonContentViewController()
            vc.lesson_id = lesson_id
            vc.contentLesson = content
            vc.modalPresentationStyle = .fullScreen
            return .present(vc)
            
        case .related(let lessonID,let  userId ):
            let viewModel = RelatedLessonViewModel(with: weakRouter, lessonID: lessonID, userId: userId)
            let viewController = RelatedLessonViewController.newInstance(with: viewModel)
            return .push(viewController)
            
        case let .pop(animation):
            return .pop(animation: animation)
        case .dismiss: return .dismiss()
        case .popToRoot: return .popToRoot()
            
        default: break
        }
        
        return .none()
    }
    // swiftlint:enable cyclomatic_complexity function_body_length
}
// swiftlint:enable type_body_length
