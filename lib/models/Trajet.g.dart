// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Trajet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trajet _$TrajetFromJson(Map<String, dynamic> json) {
  return Trajet(
    (json['routes'] as List)
        ?.map(
            (e) => e == null ? null : Route.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TrajetToJson(Trajet instance) => <String, dynamic>{
      'routes': instance.routes?.map((e) => e?.toJson())?.toList(),
    };
