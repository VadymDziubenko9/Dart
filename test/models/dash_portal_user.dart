import 'package:built_value/built_value.dart';

import 'dash_portal_user_list_item.dart';

part 'dash_portal_user.g.dart';

abstract class DashPortalUser implements Built<DashPortalUser, DashPortalUserBuilder> {
  String get role;

  String get email;

  String get password;

  String get firstName;

  String get lastName;

  String get phone;

  bool get smsNotification;

  bool get emailNotification;

  DashPortalUser._();

  factory DashPortalUser([void Function(DashPortalUserBuilder) f]) = _$DashPortalUser;

  DashPortalUserListItem toListAdmins() {
    return DashPortalUserListItem(
          (b) => b
            ..role = role
            ..name = firstName.padRight(6, ' ') + lastName
            ..email = email
            ..phoneNumber = phone
            ..smsNotification = smsNotification
            ..emailNotification = emailNotification,
    );
  }

  DashPortalUserListItem toListOwners() {
    return DashPortalUserListItem(
          (b) => b
            ..name = firstName.padRight(6, ' ') + lastName
            ..email = email
            ..phoneNumber = phone
            ..smsNotification = smsNotification
            ..emailNotification = emailNotification,
    );
  }

  DashPortalUserListItem toListGuests() {
    return DashPortalUserListItem(
          (b) => b
            ..name = firstName.padRight(3, ' ') + lastName
            ..email = email
            ..phoneNumber = phone
            ..smsNotification = smsNotification
            ..emailNotification = emailNotification,
    );
  }

  static final vadymDashweekAdmin = DashPortalUser(
    (b) => b
      ..role = 'Admin'
      ..firstName = 'Vadym'
      ..lastName = 'Dziubenko'
      ..email = 'vadymdziubenko99@gmail.com'
      ..password = 'Ps@!2009'
      ..phone = '+380 (63) 997 97 79'
      ..smsNotification = true
      ..emailNotification = true,
  );

  static final vadymDashweekAgent = DashPortalUser(
    (b) => b
      ..role = 'Admin'
      ..firstName = 'Vadym'
      ..lastName = 'Dziubenko'
      ..email = 'vadymdziubenko99@gmail.com'
      ..password = 'Ps@!2009'
      ..phone = '+38 (063) 997-9779'
      ..smsNotification = true
      ..emailNotification = true,
  );

  static final vadymDashweekOwner = DashPortalUser(
    (b) => b
      ..role = 'Owner'
      ..firstName = 'Vadym'
      ..lastName = 'Dziubenko'
      ..email = 'vadymdziubenko99+zack@gmail.com'
      ..password = 'Ps@!2009'
      ..phone = '+380 (639) 979-779'
      ..smsNotification = true
      ..emailNotification = true,
  );

  static final vadymDashweekGuest = DashPortalUser(
    (b) => b
      ..role = 'Guest'
      ..firstName = 'QA'
      ..lastName = 'Guest'
      ..email = 'vadymdziubenko99+dash@gmail.com'
      ..password = 'Ps@!2009'
      ..phone = '+38 (063) 997-9779'
      ..smsNotification = true
      ..emailNotification = true,
  );
}
