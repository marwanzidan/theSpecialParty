import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/notificationmodel.dart';
import 'package:dio/dio.dart';
import 'package:TheSpecialParty/constants.dart' as globals;

class NotificationService {
  Future<NotificationModel> getNotification({String link}) async {
    Dio dio = Dio();
    NotificationModel tempNotificationModel = NotificationModel();
    String url =
        link == null ? globals.apiurl + '/general/notifications' : link;
    await dio
        .get(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userModel.accessToken}',
        },
      ),
    )
        .then(
      (value) {
        tempNotificationModel = NotificationModel.fromJson(value.data);
      },
    );
    return tempNotificationModel;
  }
}
