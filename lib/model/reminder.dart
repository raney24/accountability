import 'partner.dart';

class Reminder {
  final Partner partner;
  final String note;
  final bool done;
  final DateTime dateCreated;
  final DateTime alertTime;

  Reminder(
    this.partner,
    {
      this.note,
      this.done = false,
      dateCreated,
      this.alertTime
    }
  ) : dateCreated = dateCreated ?? DateTime.now();
}