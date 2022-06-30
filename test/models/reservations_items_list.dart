import 'package:built_value/built_value.dart';
part 'reservations_items_list.g.dart';

abstract class ReservationItemsList implements Built<ReservationItemsList, ReservationItemsListBuilder> {

  String get property;

  String get agent;

  String get owner;

  String get guest;

  String get createdAt;
  
  ReservationItemsList._();

  factory ReservationItemsList([void Function(ReservationItemsListBuilder updates) f]) = _$ReservationItemsList;

}