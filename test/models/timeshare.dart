import 'package:built_value/built_value.dart';

import '../utils.dart';

part 'timeshare.g.dart';

abstract class Timeshare implements Built<Timeshare, TimeshareBuilder> {
   String get owner;

   String get property;

   DateTime? get startDate;

   DateTime? get endDate;

   String? get bedrooms;

   String? get bathrooms;

   String? get view;

   String? get netPrice;

   String? get salePrice;

   String? get reedWeekId;

   DateTime? get expirationDate;

   String? get notes;

  Timeshare._();

  factory Timeshare([void Function(TimeshareBuilder) f]) = _$Timeshare;


   static Timeshare hardCodeTimeshare = Timeshare(
         (b) => b
       ..owner = 'Simon Says'
       ..property = 'Buka'
       ..startDate = standardDateFormat.parse('01/01/2020')
       ..endDate = standardDateFormat.parse('01/01/2020')
       ..bedrooms = '4'
       ..bathrooms = '2'
       ..view = 'Pool'
       ..netPrice = '5000'
       ..salePrice = '7500'
       ..reedWeekId = '1522809'
       ..expirationDate = standardDateFormat.parse('01/01/2020')
       ..notes = 'do not touch',
   );
}
