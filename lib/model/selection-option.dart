import 'package:json_annotation/json_annotation.dart';

part 'selection-option.g.dart';

@JsonSerializable()
class SelectionOption {
  String name;
  List<String> _values;
  double price;
  String _selected;

  SelectionOption();

  List<String> get values => _values;
  set values(List<String> values) {
    _values = values?.map((e) => e.trim())?.toList();
  }

  String get selected => _selected != null ? _selected : values[0];

  set selected(String selected) {
    _selected = selected;
  }

  factory SelectionOption.fromJson(Map<String, dynamic> json) =>
      _$SelectionOptionFromJson(json);

  Map<String, dynamic> toJson() => _$SelectionOptionToJson(this);

    @override
  bool operator == (Object other) =>
    identical(this, other) ||
    other is SelectionOption &&
    runtimeType == other.runtimeType &&
    name == other.name && other.selected == selected;
}
