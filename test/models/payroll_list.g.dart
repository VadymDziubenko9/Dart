// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************


class _$Payroll extends Payroll {
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  factory _$Payroll([void Function(PayrollBuilder)? updates]) =>
      (new PayrollBuilder()..update(updates)).build();

  _$Payroll._(
      {required this.startDate,
      required this.endDate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(startDate, 'Payroll', 'startDate');
    BuiltValueNullFieldError.checkNotNull(endDate, 'Payroll', 'endDate');
  }

  @override
  Payroll rebuild(void Function(PayrollBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PayrollBuilder toBuilder() =>
      new PayrollBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Payroll &&
        startDate == other.startDate &&
        endDate == other.endDate;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, startDate.hashCode), endDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Payroll')
          ..add('startDate', startDate)
          ..add('endDate', endDate))
        .toString();
  }
}

class PayrollBuilder implements Builder<Payroll, PayrollBuilder> {
  _$Payroll? _$v;

  DateTime? _startDate;

  DateTime? get startDate => _$this._startDate;

  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;

  DateTime? get endDate => _$this._endDate;

  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  PayrollBuilder();

  PayrollBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Payroll other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Payroll;
  }

  @override
  void update(void Function(PayrollBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Payroll build() {
    final _$result = _$v ??
        new _$Payroll._(
            startDate: BuiltValueNullFieldError.checkNotNull(
                startDate, 'Payroll', 'startDate'),
            endDate: BuiltValueNullFieldError.checkNotNull(
                endDate, 'Payroll', 'endDate'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
