import 'package:built_value/built_value.dart';
part 'reservation_request_items_list.g.dart';

abstract class ResrvationsRequestItemsList implements Built<ResrvationsRequestItemsList, ResrvationsRequestItemsListBuilder> {

  String get property;

  String get guest;

  String get agents;

  ResrvationsRequestItemsList._();

  factory ResrvationsRequestItemsList([void Function(ResrvationsRequestItemsListBuilder updates) f]) = _$ResrvationsRequestItemsList;

}