import 'package:intl/intl.dart';

/// Date format example: "31/12/2014 15:00:00"
const dateComplete = "dd/MM/yyyy HH:mm:ss";

class CustomDateUtils {
  static String parseDateMillis(int millis, String format) {
    var dateFormat = DateFormat(format);
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(millis));
  }
}
