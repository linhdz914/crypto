//
//  AppRouter.swift
//  Thrive
//

import Foundation
import RxSwift
import RxCocoa

enum AppRoute: Route {
    
    //MARK: - SELECT LANGUAGE
    case selectLanguage
    case welcome
    
    //MARK: - AUTH
    case login
    case forgotPassword(String)
    case mainRegister
    case subRegisger(String)
    case createNewPassword(String, String)
    case tabbar
    case dismiss

    //MARK: - HOME
    case home
    case notify
    case setting
    case topicDetails(Topic,Int?,Bool)
    case topics(FieldOfStudyModel)
    case createTopic(fieldID: Int, () -> Void)
    case editTopic(Topic, (Topic) -> Void)
    case newFieldOfStudy
    case notifyDetails(NotifyModel)
    case profile(User)
    case changePassword(User)
    case language
    case helpCenter
    case contactSupport
    case logout
    case invite(Int)
    case newLesson(LessonMode, Int)
    case editLesson(Int, Int, () -> Void)
    case reminder(BehaviorRelay<[LessonReminder]>)
    case selectObjectDialog((String?)->(), AudienceObj?)
    case takeATest(questions: [QuestionModel], lessonId: Int, repeats: [Int]?)
    case zoomContent(String, Int)
    case priorityDialog((String?)->(), Priority?)
    case createKeyword
    case createQuestion
    case learningGoal
    case editGoal((String?)->())
    case schedule
    case editField(Int, String)
    case lessonDetail(lessonID: Int, isFavorite: Bool)
    case searchDetail(String)
    case choiceAField((Topic?)->())
    case choiceATopic(field: FieldOfStudyModel, completion: CompletionBlock<Topic?>)
    case related(lessonID: Int, userId : Int)
    
    //MARK: - DIGITIZING
    case digitizing
    case textToSpeech(TextToSpeechFlow, ArchiveModel?)
    case saveRecordDialog(PublishSubject<String>)
    case imageToText
    case imageToTextConvert([UIImage])
    
    //MARK: - REVIEW
    case review
    case favorite
    
    //MARK: - COMMUNITY
    case community
    case communityList
    case authorDetail(user: User)
    
    case addSchedule
    case editSchedule(ScheduleModel)
    case invalidToken
    
    case pop(Animation? = nil)
    case popToRoot
}
