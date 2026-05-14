import 'package:freezed_annotation/freezed_annotation.dart';

part 'managed_urge_event.freezed.dart';
part 'managed_urge_event.g.dart';

@freezed
class ManagedUrgeEvent with _$ManagedUrgeEvent {
  const factory ManagedUrgeEvent({
    required String id,
    required String source, // 'sos', 'silent_reply_vault', 'silent_reply_wait', 'support_wait'
    required DateTime createdAt,
  }) = _ManagedUrgeEvent;

  factory ManagedUrgeEvent.fromJson(Map<String, dynamic> json) => _$ManagedUrgeEventFromJson(json);
}
