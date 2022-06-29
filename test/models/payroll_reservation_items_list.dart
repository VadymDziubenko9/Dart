import 'package:built_value/built_value.dart';
part 'payroll_reservation_items_list.g.dart';

abstract class PayrollReservationList implements Built<PayrollReservationList, PayrollReservationListBuilder> {

  String get agent;

  String get owner;

  String get guest;

  String get ownerRate;

  String get guestRate;

  String get spread;

  DateTime get guestPaymentDate;

  PayrollReservationList._();

  factory PayrollReservationList([void Function(PayrollReservationListBuilder updates) f]) = _$PayrollReservationList;

}