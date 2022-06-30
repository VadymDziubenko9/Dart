// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties_items_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PropertyItemsList extends PropertyItemsList {
  @override
  final String property;
  @override
  final String destination;
  @override
  final String country;
  @override
  final String region;
  @override
  final String agents;

  factory _$PropertyItemsList(
          [void Function(PropertyItemsListBuilder)? updates]) =>
      (new PropertyItemsListBuilder()..update(updates))._build();

  _$PropertyItemsList._(
      {required this.property,
      required this.destination,
      required this.country,
      required this.region,
      required this.agents})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        property, r'PropertyItemsList', 'property');
    BuiltValueNullFieldError.checkNotNull(
        destination, r'PropertyItemsList', 'destination');
    BuiltValueNullFieldError.checkNotNull(
        country, r'PropertyItemsList', 'country');
    BuiltValueNullFieldError.checkNotNull(
        region, r'PropertyItemsList', 'region');
    BuiltValueNullFieldError.checkNotNull(
        agents, r'PropertyItemsList', 'agents');
  }

  @override
  PropertyItemsList rebuild(void Function(PropertyItemsListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PropertyItemsListBuilder toBuilder() =>
      new PropertyItemsListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PropertyItemsList &&
        property == other.property &&
        destination == other.destination &&
        country == other.country &&
        region == other.region &&
        agents == other.agents;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, property.hashCode), destination.hashCode),
                country.hashCode),
            region.hashCode),
        agents.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PropertyItemsList')
          ..add('property', property)
          ..add('destination', destination)
          ..add('country', country)
          ..add('region', region)
          ..add('agents', agents))
        .toString();
  }
}

class PropertyItemsListBuilder
    implements Builder<PropertyItemsList, PropertyItemsListBuilder> {
  _$PropertyItemsList? _$v;

  String? _property;
  String? get property => _$this._property;
  set property(String? property) => _$this._property = property;

  String? _destination;
  String? get destination => _$this._destination;
  set destination(String? destination) => _$this._destination = destination;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _region;
  String? get region => _$this._region;
  set region(String? region) => _$this._region = region;

  String? _agents;
  String? get agents => _$this._agents;
  set agents(String? agents) => _$this._agents = agents;

  PropertyItemsListBuilder();

  PropertyItemsListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _property = $v.property;
      _destination = $v.destination;
      _country = $v.country;
      _region = $v.region;
      _agents = $v.agents;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PropertyItemsList other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PropertyItemsList;
  }

  @override
  void update(void Function(PropertyItemsListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PropertyItemsList build() => _build();

  _$PropertyItemsList _build() {
    final _$result = _$v ??
        new _$PropertyItemsList._(
            property: BuiltValueNullFieldError.checkNotNull(
                property, r'PropertyItemsList', 'property'),
            destination: BuiltValueNullFieldError.checkNotNull(
                destination, r'PropertyItemsList', 'destination'),
            country: BuiltValueNullFieldError.checkNotNull(
                country, r'PropertyItemsList', 'country'),
            region: BuiltValueNullFieldError.checkNotNull(
                region, r'PropertyItemsList', 'region'),
            agents: BuiltValueNullFieldError.checkNotNull(
                agents, r'PropertyItemsList', 'agents'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
