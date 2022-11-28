// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryAdapter extends TypeAdapter<Country> {
  @override
  final int typeId = 0;

  @override
  Country read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Country(
      countryCode: fields[0] as String?,
      countryName: fields[1] as String?,
      isoNumeric: fields[2] as String?,
      isoAlpha3: fields[3] as String?,
      fipsCode: fields[4] as String?,
      continent: fields[5] as String?,
      continentName: fields[6] as String?,
      capital: fields[7] as String?,
      areaInSqKm: fields[8] as String?,
      population: fields[9] as String?,
      currencyCode: fields[10] as String?,
      languages: fields[11] as String?,
      geonameId: fields[12] as String?,
      west: fields[13] as String?,
      north: fields[14] as String?,
      east: fields[15] as String?,
      south: fields[16] as String?,
      postalCodeFormat: fields[17] as String?,
      exchangeRate: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Country obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.countryCode)
      ..writeByte(1)
      ..write(obj.countryName)
      ..writeByte(2)
      ..write(obj.isoNumeric)
      ..writeByte(3)
      ..write(obj.isoAlpha3)
      ..writeByte(4)
      ..write(obj.fipsCode)
      ..writeByte(5)
      ..write(obj.continent)
      ..writeByte(6)
      ..write(obj.continentName)
      ..writeByte(7)
      ..write(obj.capital)
      ..writeByte(8)
      ..write(obj.areaInSqKm)
      ..writeByte(9)
      ..write(obj.population)
      ..writeByte(10)
      ..write(obj.currencyCode)
      ..writeByte(11)
      ..write(obj.languages)
      ..writeByte(12)
      ..write(obj.geonameId)
      ..writeByte(13)
      ..write(obj.west)
      ..writeByte(14)
      ..write(obj.north)
      ..writeByte(15)
      ..write(obj.east)
      ..writeByte(16)
      ..write(obj.south)
      ..writeByte(17)
      ..write(obj.postalCodeFormat)
      ..writeByte(18)
      ..write(obj.exchangeRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
