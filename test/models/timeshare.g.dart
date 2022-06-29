// GENERATED CODE - DO NOT MODIFY BY HAND


// **************************************************************************

// **************************************************************************
// BuiltValueGenerator

part of 'timeshare.dart';

class _$Timeshare extends Timeshare {
  @override
  final String owner;
  @override
  final String property;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? bedrooms;
  @override
  final String? bathrooms;
  @override
  final String view;
  @override
  final String? netPrice;
  @override
  final String? salePrice;
  @override
  final String? reedWeekId;
  @override
  final DateTime? expirationDate;
  @override
  final String? notes;

  factory _$Timeshare([void Function(TimeshareBuilder)? updates]) =>
      (new TimeshareBuilder()..update(updates)).build();

  _$Timeshare._(
      {required this.owner,
      required this.property,
      this.startDate,
      this.endDate,
      this.bedrooms,
      this.bathrooms,
      required this.view,
      this.netPrice,
      this.salePrice,
      this.reedWeekId,
      this.expirationDate,
      this.notes})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(owner, 'Timeshare', 'owner');
    BuiltValueNullFieldError.checkNotNull(property, 'Timeshare', 'property');
    BuiltValueNullFieldError.checkNotNull(view, 'Timeshare', 'view');
  }

  @override
  Timeshare rebuild(void Function(TimeshareBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimeshareBuilder toBuilder() => new TimeshareBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Timeshare &&
        owner == other.owner &&
        property == other.property &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        bedrooms == other.bedrooms &&
        bathrooms == other.bathrooms &&
        view == other.view &&
        netPrice == other.netPrice &&
        salePrice == other.salePrice &&
        reedWeekId == other.reedWeekId &&
        expirationDate == other.expirationDate &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, owner.hashCode),
                                                property.hashCode),
                                            startDate.hashCode),
                                        endDate.hashCode),
                                    bedrooms.hashCode),
                                bathrooms.hashCode),
                            view.hashCode),
                        netPrice.hashCode),
                    salePrice.hashCode),
                reedWeekId.hashCode),
            expirationDate.hashCode),
        notes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Timeshare')
          ..add('owner', owner)
          ..add('property', property)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('bedrooms', bedrooms)
          ..add('bathrooms', bathrooms)
          ..add('view', view)
          ..add('netPrice', netPrice)
          ..add('salePrice', salePrice)
          ..add('reedWeekId', reedWeekId)
          ..add('expirationDate', expirationDate)
          ..add('notes', notes))
        .toString();
  }
}

class TimeshareBuilder implements Builder<Timeshare, TimeshareBuilder> {
  _$Timeshare? _$v;

  String? _owner;
  String? get owner => _$this._owner;
  set owner(String? owner) => _$this._owner = owner;

  String? _property;
  String? get property => _$this._property;
  set property(String? property) => _$this._property = property;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  String? _bedrooms;
  String? get bedrooms => _$this._bedrooms;
  set bedrooms(String? bedrooms) => _$this._bedrooms = bedrooms;

  String? _bathrooms;
  String? get bathrooms => _$this._bathrooms;
  set bathrooms(String? bathrooms) => _$this._bathrooms = bathrooms;

  String? _view;
  String? get view => _$this._view;
  set view(String? view) => _$this._view = view;

  String? _netPrice;
  String? get netPrice => _$this._netPrice;
  set netPrice(String? netPrice) => _$this._netPrice = netPrice;

  String? _salePrice;
  String? get salePrice => _$this._salePrice;
  set salePrice(String? salePrice) => _$this._salePrice = salePrice;

  String? _reedWeekId;
  String? get reedWeekId => _$this._reedWeekId;
  set reedWeekId(String? reedWeekId) => _$this._reedWeekId = reedWeekId;

  DateTime? _expirationDate;
  DateTime? get expirationDate => _$this._expirationDate;
  set expirationDate(DateTime? expirationDate) => _$this._expirationDate = expirationDate;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;


  TimeshareBuilder();

  TimeshareBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _owner = $v.owner;
      _property = $v.property;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _bedrooms = $v.bedrooms;
      _bathrooms = $v.bathrooms;
      _view = $v.view;
      _netPrice = $v.netPrice;
      _salePrice = $v.salePrice;
      _reedWeekId = $v.reedWeekId;
      _expirationDate = $v.expirationDate;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Timeshare other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Timeshare;
  }

  @override
  void update(void Function(TimeshareBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Timeshare build() {
    _$Timeshare _$result;
      _$result = _$v ??
          new _$Timeshare._(
              owner: BuiltValueNullFieldError.checkNotNull(
                  owner, 'Timeshare', 'owner'),
              property: BuiltValueNullFieldError.checkNotNull(
                  property, 'Timeshare', 'property'),
              startDate: startDate,
              endDate: endDate,
              bedrooms: bedrooms,
              bathrooms: bathrooms,
              view: BuiltValueNullFieldError.checkNotNull(
                  view, 'Timeshare', 'view'),
              netPrice: netPrice,
              salePrice: salePrice,
              reedWeekId: reedWeekId,
              expirationDate: expirationDate,
              notes: notes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
