import 'dart:async';
import 'dart:convert';
import 'package:backend/src/core/services/database/remote_database.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/user', _getAllUser),
        Route.get('/user/:id', _getUserByid),
        Route.post('/user', _createUser),
        Route.put('/user', _updateUser),
        //Route.delete('/user/:id', _deleteUser),
      ];

  FutureOr<Response> _getAllUser(Injector injector) async {
    final database = injector.get<RemoteDatabase>();
    final result =
        await database.execute('SELECT * FROM public."User";', parameters: {});
    final userList = result.toList();

    print(result);
    return Response.ok(jsonEncode(userList));
  }

  FutureOr<Response> _getUserByid(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];
    final database = injector.get<RemoteDatabase>();
    final result =
        //await database.execute('SELECT * FROM public."User" WHERE id = $id;');
        await database.execute(
            Sql.named('SELECT * FROM public."User" WHERE id = @id'),
            parameters: {'id': id});
    print(result);
    return Response.ok(jsonEncode(result));
  }

  FutureOr<Response> _createUser(
      ModularArguments arguments, Injector injector) async {
    final userParams = (arguments.data as Map).cast<String, dynamic>();

    final userParams2 = {
      "name": "Teste5",
      "email": "teste@teste5.com",
      "password": "123456",
    };

    userParams.remove('id');

    final database = injector.get<RemoteDatabase>();
    final result = await database.execute(
      //r'INSERT INTO "User" (name, email, password) VALUES ( @name, @email, @password) RETURNING id,email,role,name',
      'INSERT INTO public."User" (User.name, User.email, User.password)'
      'VALUES (@"User.name", @"User.email", @"User.password")',
      parameters: {
        'nome': 'Teste5',
        'email': 'teste@teste5.com',
        'password': '123456',
      },
      //parameters: userParams2,
    );
    return Response.ok(jsonEncode(result));
  }

  FutureOr<Response> _updateUser(ModularArguments arguments) {
    return Response.ok('Updated user: ${arguments.data}');
  }

  // FutureOr<Response> _deleteUser(
  //     ModularArguments arguments, Injector injector) async {
  //   final id = arguments.params['id'];
  //   final database = injector.get<RemoteDatabase>();
  //   final result =
  //       await database.execute('DELETE FROM public."User" WHERE id = $id;');
  //   print(result);
  //   return Response.ok(jsonEncode({'message': 'deleted $id'}));
  // }
}
