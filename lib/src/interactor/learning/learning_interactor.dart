import 'package:langvider/src/interactor/learning/manager/learning_manager.dart';
import 'package:langvider/src/interactor/notification/notification_interactor.dart';

const _learningNotificationId = 0;
const _learningNotificationTitle = 'Пора учить слова!';
const _learningNotificationBody = 'Вам доступны слова для повторения!';
const _learningNotificationPayload = 'learning-words';

class LearningInteractor {
  LearningInteractor(
    this._learningManager,
    this._notificationInteractor,
  );

  final LearningManager _learningManager;
  final NotificationInteractor _notificationInteractor;

  Future<bool> get hasLearningWords => _learningManager.hasLearningWords;

  Future<void> scheduleNextLearningNotification() async {
    final nextLearningDate = await _learningManager.getNextLearningDate();

    if (nextLearningDate != null && nextLearningDate.isAfter(DateTime.now())) {
      await _notificationInteractor.cancelNotification(_learningNotificationId);

      await _notificationInteractor.scheduleNotification(
        id: _learningNotificationId,
        title: _learningNotificationTitle, // TODO Use strings
        body: _learningNotificationBody, // TODO Use strings
        payload: _learningNotificationPayload,
        date: nextLearningDate,
      );
    }
  }
}
