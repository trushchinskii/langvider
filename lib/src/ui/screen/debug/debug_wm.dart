import 'package:langvider/src/interactor/notification/notification_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/utils/consts.dart';

class DebugScreenWm extends BaseWidgetModel {
  DebugScreenWm(
    WmDependencies dependencies,
    this._notificationInteractor,
  ) : super(dependencies);

  final NotificationInteractor _notificationInteractor;

  final displayNotificationAction = Action();
  final displayNotificationAfter5SecondsAction = Action();

  @override
  void initListeners() {
    listen(displayNotificationAction, (_) => _displayNotification());
    listen(
      displayNotificationAfter5SecondsAction,
      (_) => _displayNotificationAfter5Seconds(),
    );
  }

  void _displayNotification() {
    _notificationInteractor.displayNotification(
      id: 0,
      title: 'Test Notification',
      body: 'Displayed from now',
      payload: emptyString,
    );
  }

  void _displayNotificationAfter5Seconds() {
    _notificationInteractor.scheduleNotification(
      id: 0,
      title: 'Test Notification',
      body: 'Displayed from now',
      payload: emptyString,
      date: DateTime.now().add(const Duration(seconds: 5)),
    );
  }
}
