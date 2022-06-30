// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_request_items_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResrvationsRequestItemsList extends ResrvationsRequestItemsList {
  @override
  final String property;
  @override
  final String guest;
  @override
  final String agents;

  factory _$ResrvationsRequestItemsList(
          [void Function(ResrvationsRequestItemsListBuilder)? updates]) =>
      (new ResrvationsRequestItemsListBuilder()..update(updates))._build();

  _$ResrvationsRequestItemsList._(
      {required this.property, required this.guest, required this.agents})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        property, r'ResrvationsRequestItemsList', 'property');
    BuiltValueNullFieldError.checkNotNull(
        guest, r'ResrvationsRequestItemsList', 'guest');
    BuiltValueNullFieldError.checkNotNull(
        agents, r'ResrvationsRequestItemsList', 'agents');
  }

  @override
  ResrvationsRequestItemsList rebuild(
          void Function(ResrvationsRequestItemsListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResrvationsRequestItemsListBuilder toBuilder() =>
      new ResrvationsRequestItemsListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResrvationsRequestItemsList &&
        property == other.property &&
        guest == other.guest &&
        agents == other.agents;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, property.hashCode), guest.hashCode), agents.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResrvationsRequestItemsList')
          ..add('property', property)
          ..add('guest', guest)
          ..add('agents', agents))
        .toString();
  }
}

class ResrvationsRequestItemsListBuilder
    implements
        Builder<ResrvationsRequestItemsList,
            ResrvationsRequestItemsListBuilder> {
  _$ResrvationsRequestItemsList? _$v;

  String? _property;
  String? get property => _$this._property;
  set property(String? property) => _$this._property = property;

  String? _guest;
  String? get guest => _$this._guest;
  set guest(String? guest) => _$this._guest = guest;

  String? _agents;
  String? get agents => _$this._agents;
  set agents(String? agents) => _$this._agents = agents;

  ResrvationsRequestItemsListBuilder();

  ResrvationsRequestItemsListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _property = $v.property;
      _guest = $v.guest;
      _agents = $v.agents;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResrvationsRequestItemsList other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ResrvationsRequestItemsList;
  }

  @override
  void update(void Function(ResrvationsRequestItemsListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResrvationsRequestItemsList build() => _build();

  _$ResrvationsRequestItemsList _build() {
    final _$result = _$v ??
        new _$ResrvationsRequestItemsList._(
            property: BuiltValueNullFieldError.checkNotNull(
                property, r'ResrvationsRequestItemsList', 'property'),
            guest: BuiltValueNullFieldError.checkNotNull(
                guest, r'ResrvationsRequestItemsList', 'guest'),
            agents: BuiltValueNullFieldError.checkNotNull(
                agents, r'ResrvationsRequestItemsList', 'agents'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
