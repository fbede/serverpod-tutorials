/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class Response extends _i1.SerializableEntity {
  Response({
    required this.success,
    required this.message,
  });

  factory Response.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Response(
      success:
          serializationManager.deserialize<bool>(jsonSerialization['success']),
      message: serializationManager
          .deserialize<String>(jsonSerialization['message']),
    );
  }

  bool success;

  String message;

  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}
