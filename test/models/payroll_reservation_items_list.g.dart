// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_reservation_items_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayrollReservationList extends PayrollReservationList {
  @override
  final String agent;
  @override
  final String owner;
  @override
  final String guest;
  @override
  final String ownerRate;
  @override
  final String guestRate;
  @override
  final String spread;
  @override
  final DateTime guestPaymentDate;

  factory _$PayrollReservationList(
          [void Function(PayrollReservationListBuilder)? updates]) =>
      (new PayrollReservationListBuilder()..update(updates)).build();

  _$PayrollReservationList._(
      {required this.agent,
      required this.owner,
      required this.guest,
      required this.ownerRate,
      required this.guestRate,
      required this.spread,
      required this.guestPaymentDate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        agent, 'PayrollReservationList', 'agent');
    BuiltValueNullFieldError.checkNotNull(
        owner, 'PayrollReservationList', 'owner');
    BuiltValueNullFieldError.checkNotNull(
        guest, 'PayrollReservationList', 'guest');
    BuiltValueNullFieldError.checkNotNull(
        ownerRate, 'PayrollReservationList', 'ownerRate');
    BuiltValueNullFieldError.checkNotNull(
        guestRate, 'PayrollReservationList', 'guestRate');
    BuiltValueNullFieldError.checkNotNull(
        spread, 'PayrollReservationList', 'spread');
    BuiltValueNullFieldError.checkNotNull(
        guestPaymentDate, 'PayrollReservationList', 'guestPaymentDate');
  }

  @override
  PayrollReservationList rebuild(
          void Function(PayrollReservationListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PayrollReservationListBuilder toBuilder() =>
      new PayrollReservationListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollReservationList &&
        agent == other.agent &&
        owner == other.owner &&
        guest == other.guest &&
        ownerRate == other.ownerRate &&
        guestRate == other.guestRate &&
        spread == other.spread &&
        guestPaymentDate == other.guestPaymentDate;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, agent.hashCode), owner.hashCode),
                        guest.hashCode),
                    ownerRate.hashCode),
                guestRate.hashCode),
            spread.hashCode),
        guestPaymentDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PayrollReservationList')
          ..add('agent', agent)
          ..add('owner', owner)
          ..add('guest', guest)
          ..add('ownerRate', ownerRate)
          ..add('guestRate', guestRate)
          ..add('spread', spread)
          ..add('guestPaymentDate', guestPaymentDate))
        .toString();
  }
}

class PayrollReservationListBuilder
    implements Builder<PayrollReservationList, PayrollReservationListBuilder> {
  _$PayrollReservationList? _$v;

  String? _agent;
  String? get agent => _$this._agent;
  set agent(String? agent) => _$this._agent = agent;

  String? _owner;
  String? get owner => _$this._owner;
  set owner(String? owner) => _$this._owner = owner;

  String? _guest;
  String? get guest => _$this._guest;
  set guest(String? guest) => _$this._guest = guest;

  String? _ownerRate;
  String? get ownerRate => _$this._ownerRate;
  set ownerRate(String? ownerRate) => _$this._ownerRate = ownerRate;

  String? _guestRate;
  String? get guestRate => _$this._guestRate;
  set guestRate(String? guestRate) => _$this._guestRate = guestRate;

  String? _spread;
  String? get spread => _$this._spread;
  set spread(String? spread) => _$this._spread = spread;

  DateTime? _guestPaymentDate;
  DateTime? get guestPaymentDate => _$this._guestPaymentDate;
  set guestPaymentDate(DateTime? guestPaymentDate) => _$this._guestPaymentDate = guestPaymentDate;


  PayrollReservationListBuilder();

  PayrollReservationListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agent = $v.agent;
      _owner = $v.owner;
      _guest = $v.guest;
      _ownerRate = $v.ownerRate;
      _guestRate = $v.guestRate;
      _spread = $v.spread;
      _guestPaymentDate = $v.guestPaymentDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollReservationList other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PayrollReservationList;
  }

  @override
  void update(void Function(PayrollReservationListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PayrollReservationList build() {
    final _$result = _$v ??
        new _$PayrollReservationList._(
            agent: BuiltValueNullFieldError.checkNotNull(
                agent, 'BillingInvoice', 'agent'),
            owner: BuiltValueNullFieldError.checkNotNull(
                owner, 'BillingInvoice', 'owner'),
            guest: BuiltValueNullFieldError.checkNotNull(
                guest, 'BillingInvoice', 'guest'),
            ownerRate: BuiltValueNullFieldError.checkNotNull(
                ownerRate, 'BillingInvoice', 'ownerRate'),
            guestRate: BuiltValueNullFieldError.checkNotNull(
                guestRate, 'BillingInvoice', 'guestRate'),
            spread: BuiltValueNullFieldError.checkNotNull(
                spread, 'BillingInvoice', 'spread'),
            guestPaymentDate: BuiltValueNullFieldError.checkNotNull(
                guestPaymentDate, 'BillingInvoice', 'guestPaymentDate'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
