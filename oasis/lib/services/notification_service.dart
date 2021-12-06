import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final NotificationService _instance =
      NotificationService._constructor();
  factory NotificationService() {
    return _instance;
  }

  NotificationService._constructor();
}
