
import 'package:json_annotation/json_annotation.dart';
import 'package:uber_clone/models/OverviewPolyline.dart';

part 'Route.g.dart';

@JsonSerializable(explicitToJson: true)
class Route {

  @JsonKey(name: 'overview_polyline')
  OverviewPolyline polyline;

  Route(this.polyline);

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  Map<String, dynamic> toJson() => _$RouteToJson(this);

}
