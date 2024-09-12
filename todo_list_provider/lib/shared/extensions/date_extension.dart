extension DateExtension on DateTime {
  String get formatDate {
    final String formatDay = day.toString().padLeft(2, '0');
    final String formatMonth = month.toString().padLeft(2, '0');
    final String formatYear = year.toString().padLeft(4, '0');

    return '$formatDay/$formatMonth/$formatYear';
  }
}