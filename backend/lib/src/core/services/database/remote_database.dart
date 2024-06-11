import 'package:postgres/postgres.dart';

abstract class RemoteDatabase {
  // Future<List<Map<String, Map<String, dynamic>>>> query(String queryText,
  //     {Map<String, String> variables = const {}});

  // Future<List<Map<String, Map<String, dynamic>>>> query2(String queryText) {
  //   // TODO: implement query
  //   throw UnimplementedError();
  // }
  @override
  Future<Result> execute(String queryText,
      {required Map<String, dynamic> parameters}) async {
    throw UnimplementedError();
    //final connection = conn;
    //return await conn.execute('SELECT * FROM public."User";');
    //return await conn.execute(queryText);
    //return await conn.execute(queryText);
  }
}
