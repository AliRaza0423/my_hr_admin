import 'dart:convert';

// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final serverKey =
    'AAAAShwzBFk:APA91bGwF6bonQQSzLT8mIufPkzKhw0Pl8Wh1Lv8midNngd3x90N4fYJDARhk4eQZPNdk7A_4Fhnw_KaNfIJm39SuBqI6fg3ED9-a3J1Dx95Ra-ZxJx4DGotkcepyFKmb6Tx3eekUPyi';
final url = 'https://fcm.googleapis.com/fcm/send';

Future<void> send(String title, String body, String fcmtoken) async {
  print('1111111111111111111111111111111111111111111111');
  final response = await http.post(
    Uri.parse(url),
    body: json.encode({
      "to": '/topics/all',
      "notification": {
        "body": body,
        "title": title,
      },
      "priority": 'high',
      "data": {
        "id": 1,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "status": "done",
      }
    }),
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'key=$serverKey',
    },
  );
  print('333333333333333333');
  print(jsonDecode(response.body));
  print('222222222222222222222222222222222222222222222222');
}
