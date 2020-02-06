
import 'package:json_annotation/json_annotation.dart';
import 'package:uber_clone/models/Route.dart';
part 'Trajet.g.dart';

@JsonSerializable(explicitToJson: true)
class Trajet {

  List<Route> routes;

  Trajet(this.routes);

  factory Trajet.fromJson(Map<String, dynamic> json) => _$TrajetFromJson(json);

  Map<String, dynamic> toJson() => _$TrajetToJson(this);
}
