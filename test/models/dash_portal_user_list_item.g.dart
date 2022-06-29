// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

part of 'dash_portal_user_list_item.dart';

class _$DashPortalUserListItem extends DashPortalUserListItem {
  @override
  final String email;
  @override
  final String name;
  @override
  final String? phoneNumber;
  @override
  final String? role;
  @override
  final bool smsNotification;
  @override
  final bool emailNotification;

  factory _$DashPortalUserListItem(
      [void Function(DashPortalUserListItemBuilder)? updates]) =>
      (new DashPortalUserListItemBuilder()..update(updates)).build();

  _$DashPortalUserListItem._(
      {required this.email,
        required this.name,
         this.phoneNumber,
        required this.smsNotification,
        required this.emailNotification,
         this.role})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, 'DashPortalUserListItem', 'email');
    BuiltValueNullFieldError.checkNotNull(
        name, 'DashPortalUserListItem', 'name');
    BuiltValueNullFieldError.checkNotNull(
        smsNotification, 'DashPortalUserListItem', 'smsNotification');
    BuiltValueNullFieldError.checkNotNull(
        emailNotification, 'DashPortalUserListItem', 'emailNotification');
  }

  @override
  DashPortalUserListItem rebuild(
      void Function(DashPortalUserListItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashPortalUserListItemBuilder toBuilder() =>
      new DashPortalUserListItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashPortalUserListItem &&
        email == other.email &&
        name == other.name &&
        phoneNumber == other.phoneNumber &&
        smsNotification == other.smsNotification &&
        emailNotification == other.emailNotification &&
        role == other.role;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, role.hashCode), name.hashCode),
                    smsNotification.hashCode),
                emailNotification.hashCode),
            email.hashCode),
        phoneNumber.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashPortalUserListItem')
      ..add('role', role)
      ..add('name', name)
      ..add('smsNotification', smsNotification)
      ..add('emailNotification', emailNotification)
      ..add('email', email)
      ..add('client', phoneNumber))
        .toString();
  }
}

class DashPortalUserListItemBuilder
    implements
        Builder<DashPortalUserListItem, DashPortalUserListItemBuilder> {
  _$DashPortalUserListItem? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  bool? _smsNotification;
  bool? get smsNotification => _$this._smsNotification;
  set smsNotification(bool? smsNotification) =>
      _$this._smsNotification = smsNotification;

  bool? _emailNotification;
  bool? get emailNotification => _$this._emailNotification;
  set emailNotification(bool? emailNotification) =>
      _$this._emailNotification = emailNotification;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  DashPortalUserListItemBuilder();

  DashPortalUserListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _name = $v.name;
      _phoneNumber = $v.phoneNumber;
      _smsNotification = $v.smsNotification;
      _emailNotification = $v.emailNotification;
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashPortalUserListItem other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DashPortalUserListItem;
  }

  @override
  void update(void Function(DashPortalUserListItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DashPortalUserListItem build() {
    final _$result = _$v ??
        new _$DashPortalUserListItem._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'DashPortalUserListItem', 'email'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'DashPortalUserListItem', 'name'),
            smsNotification: BuiltValueNullFieldError.checkNotNull(
                smsNotification, 'DashPortalUserListItem', 'smsNotification'),
            emailNotification: BuiltValueNullFieldError.checkNotNull(
                emailNotification, 'DashPortalUserListItem', 'emailNotification'),
            phoneNumber: phoneNumber,
            role: role);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
