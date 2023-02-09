class MessageModel {
  String? location_id;
  String? location_name;
  String? location_user_count;
  String? user_last_online;
  bool? isOnline;
  String? message_count;
  String? location_image;

  MessageModel(
      this.location_id,
      this.location_name,
      this.location_user_count,
      this.user_last_online,
      this.isOnline,
      this.message_count,
      this.location_image);
}
