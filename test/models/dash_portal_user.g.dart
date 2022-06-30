// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dash_portal_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashPortalUser extends DashPortalUser {
  @override
  final String role;
  @override
  final String email;
  @override
  final String password;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String phone;
  @override
  final bool smsNotification;
  @override
  final bool emailNotification;

  factory _$DashPortalUser([void Function(DashPortalUserBuilder)? updates]) =>
      (new DashPortalUserBuilder()..update(updates))._build();

  _$DashPortalUser._(
      {required this.role,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.smsNotification,
      required this.emailNotification})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(role, r'DashPortalUser', 'role');
    BuiltValueNullFieldError.checkNotNull(email, r'DashPortalUser', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, r'DashPortalUser', 'password');
    BuiltValueNullFieldError.checkNotNull(
        firstName, r'DashPortalUser', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        lastName, r'DashPortalUser', 'lastName');
    BuiltValueNullFieldError.checkNotNull(phone, r'DashPortalUser', 'phone');
    BuiltValueNullFieldError.checkNotNull(
        smsNotification, r'DashPortalUser', 'smsNotification');
    BuiltValueNullFieldError.checkNotNull(
        emailNotification, r'DashPortalUser', 'emailNotification');
  }

  @override
  DashPortalUser rebuild(void Function(DashPortalUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashPortalUserBuilder toBuilder() =>
      new DashPortalUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashPortalUser &&
        role == other.role &&
        email == other.email &&
        password == other.password &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        phone == other.phone &&
        smsNotification == other.smsNotification &&
        emailNotification == other.emailNotification;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, role.hashCode), email.hashCode),
                            password.hashCode),
                        firstName.hashCode),
                    lastName.hashCode),
                phone.hashCode),
            smsNotification.hashCode),
        emailNotification.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashPortalUser')
          ..add('role', role)
          ..add('email', email)
          ..add('password', password)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('phone', phone)
          ..add('smsNotification', smsNotification)
          ..add('emailNotification', emailNotification))
        .toString();
  }
}

class DashPortalUserBuilder
    implements Builder<DashPortalUser, DashPortalUserBuilder> {
  _$DashPortalUser? _$v;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  bool? _smsNotification;
  bool? get smsNotification => _$this._smsNotification;
  set smsNotification(bool? smsNotification) =>
      _$this._smsNotification = smsNotification;

  bool? _emailNotification;
  bool? get emailNotification => _$this._emailNotification;
  set emailNotification(bool? emailNotification) =>
      _$this._emailNotification = emailNotification;

  DashPortalUserBuilder();

  DashPortalUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _email = $v.email;
      _password = $v.password;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _phone = $v.phone;
      _smsNotification = $v.smsNotification;
      _emailNotification = $v.emailNotification;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashPortalUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DashPortalUser;
  }

  @override
  void update(void Function(DashPortalUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashPortalUser build() => _build();

  _$DashPortalUser _build() {
    final _$result = _$v ??
        new _$DashPortalUser._(
            role: BuiltValueNullFieldError.checkNotNull(
                role, r'DashPortalUser', 'role'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'DashPortalUser', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'DashPortalUser', 'password'),
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'DashPortalUser', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'DashPortalUser', 'lastName'),
            phone: BuiltValueNullFieldError.checkNotNull(
                phone, r'DashPortalUser', 'phone'),
            smsNotification: BuiltValueNullFieldError.checkNotNull(
                smsNotification, r'DashPortalUser', 'smsNotification'),
            emailNotification: BuiltValueNullFieldError.checkNotNull(
                emailNotification, r'DashPortalUser', 'emailNotification'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
