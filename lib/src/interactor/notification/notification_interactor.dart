import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:langvider/src/interactor/common/logger/logger.dart';

class NotificationInteractor {
  final _notificationPlugin = FlutterLocalNotificationsPlugin();

  Future<bool> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      'ic_notification',
    );
    final iosSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    final initializationSettings = InitializationSettings(
      androidSettings,
      iosSettings,
    );
    return _notificationPlugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  Future<void> displayNotification({
    @required int id,
    @required String title,
    @required String body,
    @required String payload,
  }) async {
    assert(id != null);
    assert(title != null);
    assert(body != null);
    assert(payload != null);

    final platformChannelSpecifics = NotificationDetails(
      _AndroidNotificationDetails(),
      const IOSNotificationDetails(),
    );

    await _notificationPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> scheduleNotification({
    @required int id,
    @required String title,
    @required String body,
    @required String payload,
    @required DateTime date,
  }) async {
    assert(id != null);
    assert(title != null);
    assert(body != null);
    assert(payload != null);
    assert(date != null);

    final platformChannelSpecifics = NotificationDetails(
      _AndroidNotificationDetails(),
      const IOSNotificationDetails(),
    );

    await _notificationPlugin.schedule(
      id,
      title,
      body,
      date,
      platformChannelSpecifics,
      payload: payload,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelNotification(int notificationId) {
    return _notificationPlugin.cancel(notificationId);
  }

  Future<void> cancelAllNotification() {
    return _notificationPlugin.cancelAll();
  }

  Future<NotificationAppLaunchDetails> getNotificationAppLaunchDetails() {
    return _notificationPlugin.getNotificationAppLaunchDetails();
  }

  Future<dynamic> _onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {
    log
      ..i('Notification _onDidReceiveLocalNotification()')
      ..i('id: $id, title: $title, body: $body, payload: $payload');
  }

  Future<dynamic> _onSelectNotification(String payload) async {
    log.i('Notification _onSelectNotification(payload: $payload)');
  }
}

class _AndroidNotificationDetails extends AndroidNotificationDetails {
  _AndroidNotificationDetails()
      : super(
          'langvider-channel-id',
          'Langvider',
          'Remember words',
          importance: Importance.Max,
          priority: Priority.High,
          ticker: 'Words training',
        );
}
