String formatDate(DateTime date, {bool showDay = false}) {
  final now = DateTime.now();

  if (date.day == now.day &&
      date.month == now.month &&
      date.year == now.year &&
      showDay) {
    return "Today";
  }
  final difference = now.difference(date).inDays;

  if (difference < 7 &&
      difference >= 0 &&
      date.weekday != now.weekday &&
      showDay) {
    // If the date is within the last week but not today, return the day name
    return _dayOfWeek(date.weekday);
  } else {
    // Otherwise, return the full date in yyyy-MM-dd format
    return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
  }
}

String _dayOfWeek(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'Monday';
    case DateTime.tuesday:
      return 'Tuesday';
    case DateTime.wednesday:
      return 'Wednesday';
    case DateTime.thursday:
      return 'Thursday';
    case DateTime.friday:
      return 'Friday';
    case DateTime.saturday:
      return 'Saturday';
    case DateTime.sunday:
      return 'Sunday';
    default:
      return '';
  }
}

String _twoDigits(int n) {
  return n.toString().padLeft(2, '0');
}

bool isSameDay(DateTime old, DateTime newD) {
  return (old.day == newD.day &&
      old.month == newD.month &&
      old.year == newD.year);
}
