import 'package:json_annotation/json_annotation.dart';
part 'state.g.dart';

enum NavigationPage { AVERAGES, DAYS, DISTRIBUTION, SETTINGS }

// State
@JsonSerializable()
class NavigationState extends Object with _$NavigationStateSerializerMixin {
  final NavigationPage activePage;

  NavigationState(this.activePage);

  factory NavigationState.empty() =>
      new NavigationState(NavigationPage.AVERAGES);

  factory NavigationState.fromJson(Map<String, dynamic> json) =>
      _$NavigationStateFromJson(json);
}
