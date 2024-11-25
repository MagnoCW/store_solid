abstract class Notifier {
  void sendNotification(String message);
}

class EmailNotifier extends Notifier {
  @override
  void sendNotification(String message) {
    print("Sending email notification: $message");
  }
}

class SMSNotifier extends Notifier {
  @override
  void sendNotification(String message) {
    print("Sending SMS notification: $message");
  }
}
