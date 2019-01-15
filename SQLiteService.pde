/** //<>// //<>// //<>// //<>//
 * @description A Simple SQLite Helper class
 **/

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DatabaseMetaData;

public class SQLiteService {
  private Connection connection;
  public SQLiteService() throws ClassNotFoundException {

    try {
      Class.forName("org.sqlite.JDBC");
      connection = DriverManager.getConnection("jdbc:sqlite:/home/brume/DatabaseWithTUI/test.db");
    }
    catch(SQLException e) {
      print(e.getMessage());
    }
  }

  /**
   * @description Executes the single query
   **/
  public int execute(String text) throws SQLException {
    Statement query= connection.createStatement();
    query.setQueryTimeout(30);
    return query.executeUpdate(text);
  }

  public void readAllDatabase() throws SQLException {
    // Clear the ArrayList
    tableManager.clear();
    DatabaseMetaData metadata = connection.getMetaData();
    ResultSet resultSet = metadata.getTables(null, null, "%", null);
    while (resultSet.next()) {
      String tableName = resultSet.getString("TABLE_NAME");
      println(tableName);
      TableObject tableObject = new TableObject();
      tableObject.setName(tableName);
      //Fetch the columns
      ResultSet columnset = metadata.getColumns(null, null, tableName, null);
      while (columnset.next()) { //<>// //<>// //<>//
        tableObject.addColumnName(columnset.getString("COLUMN_NAME"));
        println(columnset.getString("COLUMN_NAME"));
      }
      // Fetch the keys
      ResultSet foreignKey = metadata.getImportedKeys(null, null, tableName);
      while (foreignKey.next()) {
        tableObject.setForeignKey(foreignKey.getString("PKTABLE_NAME"));
        println("FK:" + foreignKey.getString("PKTABLE_NAME"));
      }
      tableManager.add(tableObject);
    }
 
  }
}
