// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Route _$RouteFromJson(Map<String, dynamic> json) {
  return Route(
    json['overview_polyline'] == null
        ? null
        : OverviewPolyline.fromJson(
            json['overview_polyline'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
      'overview_polyline': instance.polyline?.toJson(),
    };
