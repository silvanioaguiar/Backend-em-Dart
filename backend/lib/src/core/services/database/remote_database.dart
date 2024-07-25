import 'package:postgres/postgres.dart';

abstract class RemoteDatabase {
  Future<Result> executeMap(dynamic queryText,
      {required Map<String, dynamic> parameters}) async {
    throw UnimplementedError();
  }

  Future<Result> executeList(dynamic queryText,
      {required List<dynamic> parameters}) async {
    throw UnimplementedError();
  }

  Future<List<Map<String, dynamic>>> query(String sql, [List<dynamic> values]);
  
}
