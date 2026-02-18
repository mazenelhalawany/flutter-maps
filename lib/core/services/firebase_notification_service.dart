// import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_application_api_bloc/core/services/local_notification.dart';

// class FirebaseNotification {
//   static final FirebaseMessaging _firebaseNotification =
//       FirebaseMessaging.instance;
//   static Future<void> initFirebaseMessaging() async {
//     await _firebaseNotification.requestPermission();
//     String? token = await _firebaseNotification.getToken();
//     log(token ?? "null");
//     //background or terminated
//     FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage);
//     //foreground
//     handleforegroundMessage();
//   }

//   static Future<void> handlebackgroundMessage(RemoteMessage message) async {
//     await Firebase.initializeApp();
//     log(message.notification!.title.toString());
//   }

//   static handleforegroundMessage() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       LocalNotificationService.showBasicNotification(message);
//     });
//   }
// }







// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:timezone/data/latest.dart' as tz;
// // import 'package:timezone/timezone.dart' as tz;

// // // 🧠 handler للتعامل مع الرسائل في الخلفية
// // @pragma('vm:entry-point')
// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp();
// //   print('📨 Handling a background message: ${message.messageId}');
// // }

// // class FirebaseNotification {
// //   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
// //   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();

// //   Future<void> initFirebaseMessaging() async {
// //     tz.initializeTimeZones();

// //     // ✅ إعداد استقبال الرسائل في الخلفية
// //     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// //     // ✅ طلب الإذن
// //     NotificationSettings settings = await _fcm.requestPermission(
// //       alert: true,
// //       badge: true,
// //       sound: true,
// //     );
// //     print('🔔 Notification permission: ${settings.authorizationStatus}');

// //     // ✅ الحصول على Token
// //     final token = await _fcm.getToken();
// //     print('📱 FCM Token: $token');

// //     // ✅ إعداد local notifications
// //     const AndroidInitializationSettings androidInit =
// //         AndroidInitializationSettings('@mipmap/ic_launcher');

// //     const InitializationSettings initSettings =
// //         InitializationSettings(android: androidInit);

// //     await _flutterLocalNotificationsPlugin.initialize(initSettings);

// //     // ✅ استقبال إشعار والتطبيق مفتوح
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       print('🔥 Foreground message: ${message.notification?.title}');
// //       _showNotification(message);
// //     });

// //     // ✅ لما المستخدم يضغط على الإشعار
// //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// //       print('🚀 Message clicked: ${message.data}');
// //     });
// //   }

// //   // 🧩 دالة لعرض الإشعار محليًا
// //   Future<void> _showNotification(RemoteMessage message) async {
// //     final notification = message.notification;
// //     if (notification == null) return;

// //     const AndroidNotificationDetails androidDetails =
// //         AndroidNotificationDetails(
// //       'default_channel',
// //       'General Notifications',
// //       channelDescription: 'Used for displaying basic notifications',
// //       importance: Importance.max,
// //       priority: Priority.high,
// //     );

// //     const NotificationDetails notificationDetails =
// //         NotificationDetails(android: androidDetails);

// //     await _flutterLocalNotificationsPlugin.show(
// //       notification.hashCode,
// //       notification.title,
// //       notification.body,
// //       notificationDetails,
// //     );
// //   }

// //   Future<void> scheduleTaskNotification({
// //     required String title,
// //     required String body,
// //     required DateTime taskTime,
// //   }) async {
// //     final scheduledTime =
// //         taskTime.subtract(const Duration(hours: 1)); // قبلها بساعة

// //     await _flutterLocalNotificationsPlugin.zonedSchedule(
// //       0,
// //       title,
// //       body,
// //       tz.TZDateTime.from(scheduledTime, tz.local),
// //       const NotificationDetails(
// //         android: AndroidNotificationDetails(
// //           'task_channel',
// //           'Task Notifications',
// //           channelDescription: 'Notifications for scheduled tasks',
// //           importance: Importance.max,
// //           priority: Priority.high,
// //         ),
// //       ),
// //       // ✅ التغييرات هنا 👇
// //       matchDateTimeComponents: DateTimeComponents.time, // لضبط التوقيت بدقة
// //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
// //       payload: 'task_reminder', // ممكن تستخدمها لو حابب تمرر بيانات
// //     );

// //     print('⏰ Scheduled notification at: $scheduledTime');
// //   }
// // }
