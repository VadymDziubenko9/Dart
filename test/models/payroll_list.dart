import 'package:built_value/built_value.dart';

part 'payroll_list.g.dart';

abstract class Payroll implements Built<Payroll, PayrollBuilder> {

  DateTime get startDate;

  DateTime get endDate;

  Payroll._();

  factory Payroll([void Function(PayrollBuilder updates) f]) = _$Payroll;

}
