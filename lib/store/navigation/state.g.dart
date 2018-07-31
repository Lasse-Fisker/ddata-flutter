// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationState _$NavigationStateFromJson(Map<String, dynamic> json) {
  return new NavigationState($enumDecodeNullable(
      'NavigationPage', NavigationPage.values, json['activePage'] as String));
}

abstract class _$NavigationStateSerializerMixin {
  NavigationPage get activePage;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'activePage': activePage?.toString()?.split('.')?.last};
}
