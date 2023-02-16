class NotificationModel {
  String? notificationDay;
  String? notificationText;
  String? notificationUserName;
  String? notificationUserImg;
  String? notificationTime;
  bool? isRead;

  NotificationModel(
    this.notificationDay,
    this.notificationUserName,
    this.notificationText,
    this.notificationUserImg,
    this.notificationTime,
    this.isRead,
  );
}
