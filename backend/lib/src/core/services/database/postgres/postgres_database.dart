import 'dart:async';
import 'package:backend/src/core/services/database/remote_database.dart';
import 'package:backend/src/core/services/dot_env/dot_env_service.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf_modular/shelf_modular.dart';

class PostgresDatabase implements RemoteDatabase, Disposable {
  final completer = Completer<Connection>();
  final DotEnvService dotEnv;

  PostgresDatabase(this.dotEnv) {
    _init();
  }

  _init() async {
    final url = dotEnv['DATABASE_URL']!;
    final uri = Uri.parse(url);
    // final name = 'Nome do usuário';
    // final email = 'silvanio123@teste.com';
    // final password = '123';

    var conn = await Connection.open(
      Endpoint(
        port: uri.port,
        host: uri.host,
        database: uri.pathSegments.first,
        username: uri.userInfo.split(':').first,
        password: uri.userInfo.split(':').last,
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );
    completer.complete(conn);
    print('has connection!');

    final result0 = await conn.execute('SELECT * FROM public."User";');
    final result1 = await conn
        .execute(Sql.named('SELECT * FROM public."User" WHERE id = 5;'));
    // final result2 = await conn.execute(
    //     'INSERT INTO "User" (name, email, password) VALUES ( \'$name\', \'$email\', \'$password\') RETURNING id,email,name');

    print(result0);
    print(result1);
  }

  // @override
  // Future<Result> execute(String queryText) async {
  //   final conn = await completer.future;
  //   //final connection = conn;
  //   return await conn.execute(queryText);
  //   //return await conn.execute(queryText);
  //   //return await conn.execute(queryText);
  // }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<Result> executeMap(dynamic queryText,
      {required Map<String, dynamic> parameters}) async {
    final conn = await completer.future;

    return await conn.execute(queryText);
  }

  @override
  Future<Result> executeList(dynamic queryText,
      {required List<dynamic> parameters}) async {
    final conn = await completer.future;

    return await conn.execute(queryText);
  }

  @override
  Future<List<Map<String, dynamic>>> query(String sql,
      [List<dynamic>? values]) async {
    final conn = await completer.future;
    return await conn.query(sql, values);
  }
}
