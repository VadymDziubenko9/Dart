import 'package:built_value/built_value.dart';

part 'dash_portal_user_list_item.g.dart';

abstract class DashPortalUserListItem implements Built<DashPortalUserListItem, DashPortalUserListItemBuilder> {
  String? get role;

  String get name;

  String? get phoneNumber;

  String get email;

  bool get emailNotification;

  bool get smsNotification;


  DashPortalUserListItem._();

  factory DashPortalUserListItem([void Function(DashPortalUserListItemBuilder updates) f]) =
  _$DashPortalUserListItem;
}
