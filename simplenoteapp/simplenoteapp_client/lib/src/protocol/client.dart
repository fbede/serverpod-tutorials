/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:simplenoteapp_client/src/protocol/notes.dart' as _i3;
import 'dart:io' as _i4;
import 'protocol.dart' as _i5;

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );

  _i2.Future<String> helloMe(String name) => caller.callServerEndpoint<String>(
        'example',
        'helloMe',
        {'name': name},
      );
}

class _EndpointNotes extends _i1.EndpointRef {
  _EndpointNotes(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notes';

  _i2.Future<List<_i3.Note>> getNotes() =>
      caller.callServerEndpoint<List<_i3.Note>>(
        'notes',
        'getNotes',
        {},
      );

  _i2.Future<List<_i3.Note>> updateNote(_i3.Note note) =>
      caller.callServerEndpoint<List<_i3.Note>>(
        'notes',
        'updateNote',
        {'note': note},
      );

  _i2.Future<List<_i3.Note>> createNote(_i3.Note note) =>
      caller.callServerEndpoint<List<_i3.Note>>(
        'notes',
        'createNote',
        {'note': note},
      );

  _i2.Future<List<_i3.Note>> deleteNote(_i3.Note note) =>
      caller.callServerEndpoint<List<_i3.Note>>(
        'notes',
        'deleteNote',
        {'note': note},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i4.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i5.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    example = _EndpointExample(this);
    notes = _EndpointNotes(this);
  }

  late final _EndpointExample example;

  late final _EndpointNotes notes;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'notes': notes,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
