// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservations_items_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReservationItemsList extends ReservationItemsList {
  @override
  final String property;
  @override
  final String agent;
  @override
  final String owner;
  @override
  final String guest;
  @override
  final String createdAt;

  factory _$ReservationItemsList(
          [void Function(ReservationItemsListBuilder)? updates]) =>
      (new ReservationItemsListBuilder()..update(updates))._build();

  _$ReservationItemsList._(
      {required this.property,
      required this.agent,
      required this.owner,
      required this.guest,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        property, r'ReservationItemsList', 'property');
    BuiltValueNullFieldError.checkNotNull(
        agent, r'ReservationItemsList', 'agent');
    BuiltValueNullFieldError.checkNotNull(
        owner, r'ReservationItemsList', 'owner');
    BuiltValueNullFieldError.checkNotNull(
        guest, r'ReservationItemsList', 'guest');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'ReservationItemsList', 'createdAt');
  }

  @override
  ReservationItemsList rebuild(
          void Function(ReservationItemsListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReservationItemsListBuilder toBuilder() =>
      new ReservationItemsListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReservationItemsList &&
        property == other.property &&
        agent == other.agent &&
        owner == other.owner &&
        guest == other.guest &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, property.hashCode), agent.hashCode), owner.hashCode),
            guest.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReservationItemsList')
          ..add('property', property)
          ..add('agent', agent)
          ..add('owner', owner)
          ..add('guest', guest)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ReservationItemsListBuilder
    implements Builder<ReservationItemsList, ReservationItemsListBuilder> {
  _$ReservationItemsList? _$v;

  String? _property;
  String? get property => _$this._property;
  set property(String? property) => _$this._property = property;

  String? _agent;
  String? get agent => _$this._agent;
  set agent(String? agent) => _$this._agent = agent;

  String? _owner;
  String? get owner => _$this._owner;
  set owner(String? owner) => _$this._owner = owner;

  String? _guest;
  String? get guest => _$this._guest;
  set guest(String? guest) => _$this._guest = guest;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  ReservationItemsListBuilder();

  ReservationItemsListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _property = $v.property;
      _agent = $v.agent;
      _owner = $v.owner;
      _guest = $v.guest;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReservationItemsList other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReservationItemsList;
  }

  @override
  void update(void Function(ReservationItemsListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReservationItemsList build() => _build();

  _$ReservationItemsList _build() {
    final _$result = _$v ??
        new _$ReservationItemsList._(
            property: BuiltValueNullFieldError.checkNotNull(
                property, r'ReservationItemsList', 'property'),
            agent: BuiltValueNullFieldError.checkNotNull(
                agent, r'ReservationItemsList', 'agent'),
            owner: BuiltValueNullFieldError.checkNotNull(
                owner, r'ReservationItemsList', 'owner'),
            guest: BuiltValueNullFieldError.checkNotNull(
                guest, r'ReservationItemsList', 'guest'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'ReservationItemsList', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
