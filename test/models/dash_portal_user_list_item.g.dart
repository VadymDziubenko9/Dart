// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dash_portal_user_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashPortalUserListItem extends DashPortalUserListItem {
  @override
  final String? role;
  @override
  final String name;
  @override
  final String? phoneNumber;
  @override
  final String email;
  @override
  final bool emailNotification;
  @override
  final bool smsNotification;

  factory _$DashPortalUserListItem(
          [void Function(DashPortalUserListItemBuilder)? updates]) =>
      (new DashPortalUserListItemBuilder()..update(updates))._build();

  _$DashPortalUserListItem._(
      {this.role,
      required this.name,
      this.phoneNumber,
      required this.email,
      required this.emailNotification,
      required this.smsNotification})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        name, r'DashPortalUserListItem', 'name');
    BuiltValueNullFieldError.checkNotNull(
        email, r'DashPortalUserListItem', 'email');
    BuiltValueNullFieldError.checkNotNull(
        emailNotification, r'DashPortalUserListItem', 'emailNotification');
    BuiltValueNullFieldError.checkNotNull(
        smsNotification, r'DashPortalUserListItem', 'smsNotification');
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
        role == other.role &&
        name == other.name &&
        phoneNumber == other.phoneNumber &&
        email == other.email &&
        emailNotification == other.emailNotification &&
        smsNotification == other.smsNotification;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, role.hashCode), name.hashCode),
                    phoneNumber.hashCode),
                email.hashCode),
            emailNotification.hashCode),
        smsNotification.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashPortalUserListItem')
          ..add('role', role)
          ..add('name', name)
          ..add('phoneNumber', phoneNumber)
          ..add('email', email)
          ..add('emailNotification', emailNotification)
          ..add('smsNotification', smsNotification))
        .toString();
  }
}

class DashPortalUserListItemBuilder
    implements Builder<DashPortalUserListItem, DashPortalUserListItemBuilder> {
  _$DashPortalUserListItem? _$v;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _emailNotification;
  bool? get emailNotification => _$this._emailNotification;
  set emailNotification(bool? emailNotification) =>
      _$this._emailNotification = emailNotification;

  bool? _smsNotification;
  bool? get smsNotification => _$this._smsNotification;
  set smsNotification(bool? smsNotification) =>
      _$this._smsNotification = smsNotification;

  DashPortalUserListItemBuilder();

  DashPortalUserListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _name = $v.name;
      _phoneNumber = $v.phoneNumber;
      _email = $v.email;
      _emailNotification = $v.emailNotification;
      _smsNotification = $v.smsNotification;
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
  DashPortalUserListItem build() => _build();

  _$DashPortalUserListItem _build() {
    final _$result = _$v ??
        new _$DashPortalUserListItem._(
            role: role,
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'DashPortalUserListItem', 'name'),
            phoneNumber: phoneNumber,
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'DashPortalUserListItem', 'email'),
            emailNotification: BuiltValueNullFieldError.checkNotNull(
                emailNotification,
                r'DashPortalUserListItem',
                'emailNotification'),
            smsNotification: BuiltValueNullFieldError.checkNotNull(
                smsNotification, r'DashPortalUserListItem', 'smsNotification'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
