import 'package:intl/intl.dart';

var onlyDate = DateFormat("yyyy-MM-dd"); // 20-04-03
var date = DateFormat.yMd(); // 7/10/2020
var monthNameDate = DateFormat.yMMMd('en_US'); // Nov 10, 1996
var dayMonthYear = DateFormat.yMMMEd(); // Fri, Apr 3, 2020
var onlyMonth = DateFormat.MMM(); // Jan
var onlyDay = DateFormat('EEEE'); // Sunday
var onlyTime = DateFormat('h:mm a'); // 10:10 AM
var dateAndTime = DateFormat.yMd().add_jm(); // 7/10/1996 5:08 PM
var onlyHrs = DateFormat.Hm(); // 17:08
var day = DateFormat('dd');
var month = DateFormat('MM');
var year = DateFormat('yyyy');

formatRelativeTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'Online';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
  }
  // else {
  //   // You can customize this part based on your needs for longer periods
  //   final formatter = RelativeTimeFormat('en');
  //   return formatter.format(difference, 'short');
  // }
}
