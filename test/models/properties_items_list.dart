import 'package:built_value/built_value.dart';
part 'properties_items_list.g.dart';

abstract class PropertyItemsList implements Built<PropertyItemsList, PropertyItemsListBuilder> {

  String get property;

  String get destination;

  String get country;

  String get region;

  String get agents;

  PropertyItemsList._();

  factory PropertyItemsList([void Function(PropertyItemsListBuilder updates) f]) = _$PropertyItemsList;

}