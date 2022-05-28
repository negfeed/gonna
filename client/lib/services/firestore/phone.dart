import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

@JsonSerializable()
class Phone {

  String? profileId;

  Phone({this.profileId});

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneToJson(this);
}
