import 'db_connection.dart';

class TableOperations {
  Future<List<Map<String, dynamic>>> getAvailableTables() async {
    final conn = await DatabaseConnection().getConnection();
    try {
      final result =
          await conn.query('SELECT * FROM tables WHERE is_empty = 1');
      final tableList = result.toList();
      final mappedTableList = tableList.map((table) => table.fields).toList();
      return mappedTableList;
    } catch (e) {
      print('Error getting available tables: $e');
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<void> updateTable(int tableId, int orderId, bool isEmpty) async {
    final conn = await DatabaseConnection().getConnection();
    await conn.query(
        'UPDATE tables SET order_id = ?, is_empty = ? WHERE table_id = ?', [
      orderId,
      isEmpty ? 1 : 0,
      tableId,
    ]);
    await conn.close();
  }
}
