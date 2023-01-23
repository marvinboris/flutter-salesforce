class Dates {
  static List<String> weekDays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];
  static List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static String twoDigits(int number) =>
      (number < 10 ? '0' : '') + number.toString();

  static String weekDay(DateTime dateTime) => weekDays[dateTime.weekday];

  static String month(DateTime dateTime) =>
      months[dateTime.month - 1].toUpperCase().substring(0, 3);

  static String longMonth(DateTime dateTime) => months[dateTime.month - 1];

  static String time(DateTime dateTime) =>
      '${twoDigits(dateTime.hour)}:${twoDigits(dateTime.minute)}:${twoDigits(dateTime.second)}';

  static String date(DateTime dateTime) =>
      '${twoDigits(dateTime.day)}.${twoDigits(dateTime.month)}.${dateTime.year}';

  static String longDate(DateTime dateTime) =>
      '${weekDay(dateTime)}, ${dateTime.day} ${longMonth(dateTime)} ${dateTime.year}';
}
