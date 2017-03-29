package db;

import data.Book;
import data.BookType;
import data.RandomData;
import data.User;

import java.sql.*;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Queue;

import static data.RandomData.*;

/**
 * Created by L on 2016/12/18.
 */
public class MysqlDB {

    static final String url = "jdbc:mysql://localhost:3307/jian?user=root&password=123456" +
            "&useServerPrepStmts=true&cachePrepStmts=true";
    static String driver = "com.mysql.jdbc.Driver";
    public static Connection connection;

    static {
        try {
            Class.forName(driver);
            connection = getConnection(url);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection(String url) throws SQLException {
        return connection = DriverManager.getConnection(url);
    }

    public static void main(String[] args) throws SQLException {
//        selectAllData();
        randomInsert();
//        for (int i = 0; i < 20; i++) {
//            randomInsertToUsersBook("1");
//        }
//        randomInsertUser();
//        for (int i = 0; i < 5; i++) {
//            randomInsertComment();
//        }

    }



    private static void randomInsertUser() throws SQLException {
        Statement statement = connection.createStatement();
        for (int i = 0; i < 40; i++) {
            String sqlInsertBuilder = "Insert into bookUser(" +
                    "name, " +
                    "email, " +
                    "phone," +
                    "password," +
                    "money"+
                    ")values(" +
                    "'" + randomName() + "'," +
                    "'" + randomName() + "'," +
                    "'" + randomName() + "'," +
                    "'" + 123456 + "'," +
                    "'" + 1000 + "')";
            statement.executeUpdate(sqlInsertBuilder);
        }
        statement.close();
    }

    public static void selectDataByType(String science) throws SQLException {
        selectDataByType(BookType.valueOf(science));
    }

    public static void randomInsert() throws SQLException {
     /*   ArrayList<String> comments;
        String name;
        double price;
        int number;
        BookType type;
        String author;
        String src;
        String publishTime;*/
        StringBuilder sqlInsertBuilder = new StringBuilder();
//        insert into books(name,price,number,type,author,src,publishTime) values('Introduction To Algorithms',188.88,950,'science','knuth','new york','19970814');
        Statement statement = connection.createStatement();
        for (int i = 0; i < 20000; i++) {
            sqlInsertBuilder.append("Insert into books(")
                    .append("name, ")
                    .append("price, ")
                    .append("number, ")
                    .append("type, ")
                    .append("author, ")
                    .append("src, ")
                    .append("publishTime")
                    .append(")values(")
                    .append("'").append(randomName()).append("',")
                    .append("'").append(randomPrice()).append("',")
                    .append("'").append(randomNumber()).append("',")
                    .append("'").append(randomType()).append("',")
                    .append("'").append(randomAuthor()).append("',")
                    .append("'").append(randomSrc()).append("',")
                    .append("'").append(randomPublishTime0()).append("')");
            System.out.println(sqlInsertBuilder);
            statement.executeUpdate(sqlInsertBuilder.toString());
            sqlInsertBuilder.setLength(0);
        }
        statement.close();
    }

    public static void randomInsertComment() throws SQLException {

        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery("SELECT max(id) FROM bookUser");
        int k = 0;
        if (set.next()) {
            k = Integer.parseInt(set.getString(1));
            set.close();
        }
         set = statement.executeQuery("SELECT max(id) FROM books");
        int k2 = 0;
        if (set.next()) {
            k2 = Integer.parseInt(set.getString(1));
            set.close();
        }
        for (int i = 0; i < 40; i++) {
            String sqlInsertBuilder = "Insert into bookComments(" +
                    "bookId, " +
                    "userId, " +
                    "comment" +
                    ")values(" +
                    "'" + (random.nextInt(k2) + 1) + "'," +
                    "'" + (random.nextInt(k) + 1) + "'," +
                    "'" + randomSentence(3, 3) + "')";
            statement.executeUpdate(sqlInsertBuilder);
        }
    }


    public static void insertComment(String bookId, String userId, String comments) throws SQLException {
        Statement statement = connection.createStatement();
        String sqlInsertBuilder = "Insert into bookComments(" +
                "bookId, " +
                "userId, " +
                "comment" +
                ")values(" +
                "'" + bookId + "'," +
                "'" + userId + "'," +
                "'" + comments + "')";
        System.out.println(sqlInsertBuilder);
        statement.executeUpdate(sqlInsertBuilder);
        statement.close();
    }

    public static ResultSet selectDataByType(BookType type) throws SQLException {
        //select * from books where type = 'science' order by publishTime;
        String sqlSelectBuilder = "Select * " +
                "from books " +
                "where " +
                "type " +
                "=" +
                "'" + type + "'";
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery(sqlSelectBuilder);
        return set;
    }

    public static void selectAllData() throws SQLException {
        for (int i = 0; i < bookTypes.length; i++) {
            ResultSet set = selectDataByType(bookTypes[i]);
            System.out.println(bookTypes[i]);
            while (set.next()) {
                StringBuilder b = new StringBuilder();
                for (int j = 1; j <= 8; j++) {
                    b.append(set.getString(j)).append(", ");
                }
                System.out.println("\t" + b);
            }
            set.close();
        }
    }

    public static Book findBookById(String id) throws SQLException {
        String sqlSelectBuilder = "Select * " +
                "from books " +
                "where " +
                "id " +
                "=" +
                "'" + id + "'";
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery(sqlSelectBuilder);
        if (set.next()) {
            String name = set.getString(2);
            double price = Double.parseDouble(set.getString(3));
            int number = Integer.parseInt(set.getString(4));
            BookType type = BookType.valueOf(set.getString(5));
            String author = set.getString(6);
            String src = set.getString(7);
            String publishTime = set.getString(8);
            set.close();
            statement.close();
            return new Book(Integer.parseInt(id), name, price, number, type, author, src, publishTime);
        }
        throw new RuntimeException("impossible");
    }

    public static ResultSet search(String name
            , String src
            , String author
            , String type
            , String minPrice
            , String maxPrice
            , String startTime
            , String endTime
            , String sort
            , String order) throws SQLException {
        StringBuilder sqlSearchBuilder = new StringBuilder();
        sqlSearchBuilder.append("Select * ")
                .append("from books ");
        boolean first = true;
        if (name != null && name.length() > 0) {
            first = false;
            sqlSearchBuilder.append("where name=")
                    .append("'").append(name).append("' ");
        }
        if (src != null && src.length() > 0) {
            sqlSearchBuilder.append(first ? "where " : "and ")
                    .append("src=")
                    .append("'").append(src).append("' ");
            first = false;
        }
        if (author != null && author.length() > 0) {
            sqlSearchBuilder.append(first ? "where " : "and ")
                    .append("author=")
                    .append("'").append(author).append("' ");
            first = false;
        }
        if (type != null && type.length() > 0) {
            sqlSearchBuilder.append(first ? "where " : "and ")
                    .append("type=")
                    .append("'").append(type).append("' ");
            first = false;
        }
        if (minPrice != null && minPrice.length() > 0) {
            sqlSearchBuilder.append(first ? "where " : "and ")
                    .append("price>=")
                    .append("'").append(minPrice).append("' ");
            first = false;
        }
        if (maxPrice != null && maxPrice.length() > 0) {
            sqlSearchBuilder.append(first ? "where " : "and ")
                    .append("price<=")
                    .append("'").append(maxPrice).append("' ");
            first = false;
        }
        if (startTime != null && startTime.length() > 0) {
            sqlSearchBuilder.append(first ? "where " : "and ")
                    .append("publishTime>=")
                    .append("'").append(startTime).append("' ");
            first = false;
        }
        if (endTime != null && endTime.length() > 0) {
            sqlSearchBuilder.append(first ? "where " : "and ")
                    .append("publishTime<=")
                    .append("'").append(endTime).append("' ");
            first = false;
        }
        sqlSearchBuilder.append("order by ")
                .append(sort.equals("price") ? "price" : "publishTime")
                .append(order.equals("up") ? " " : " desc");
        System.out.println(sqlSearchBuilder);
        return connection.createStatement().executeQuery(sqlSearchBuilder.toString());
    }

    public static void insert(User user) throws SQLException {
        Statement statement = connection.createStatement();
        StringBuilder insertBuilder = new StringBuilder();
        insertBuilder.append("Insert into bookUser(")
                .append("name, ")
                .append("email, ")
                .append("phone, ")
                .append("password, ")
                .append("money")
                .append(")values(")
                .append("'").append(user.name).append("',")
                .append("'").append(user.email).append("',")
                .append("'").append(user.phone).append("',")
                .append("'").append(user.password).append("',")
                .append("'").append(user.money).append("')");
        System.out.println(insertBuilder);
        statement.executeUpdate(insertBuilder.toString());
        statement.close();
    }

    public static User findUserById(String id) throws SQLException {
        String sqlSelectBuilder = "Select * " +
                "from bookUser " +
                "where " +
                "id " +
                "=" +
                "'" + id + "'";
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery(sqlSelectBuilder);
        if (set.next()) {


            String name = set.getString(2);
            String email = set.getString(3);
            String phone = set.getString(4);
            String password = set.getString(5);
            double money = Double.parseDouble(set.getString(6));
            set.close();
            statement.close();
            return new User(Integer.parseInt(id), name, email, phone, password, money);
        }
        return null;
//        throw new RuntimeException("impossible");
    }

    public static ResultSet searchAllBookByUserId(String userId) throws SQLException {
        String sql = "Select * from usersBook where userId='" + userId + "'";
        return connection.createStatement().executeQuery(sql);
    }

    public static void randomInsertToUsersBook(String userId) throws SQLException {
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery("SELECT max(id) FROM books");
        if (set.next()) {
            String maxBookId = set.getString(1);
            for (int i = 0; i < 10; i++) {
                int bookId = random.nextInt(Integer.parseInt(maxBookId)) + 1;
                buyBook(bookId, userId, statement,random.nextInt(3)+1);
            }
        }
        set.close();
        statement.close();
    }

    public static void buyBook(int bookId, String userId, Statement statement, int number) throws SQLException {

        String sql = "select id from usersBook where userId='" + userId + "' and bookId='" + bookId + "' ";
        ResultSet set = statement.executeQuery(sql);
        StringBuilder insertBuilder = new StringBuilder();
        if (set.next()) {
            insertBuilder.append("update usersBook set number = number + " + number + " where id =" + set.getString(1));
        } else {
            insertBuilder.append("Insert into usersBook(")
                    .append("userId, ")
                    .append("bookId, ")
                    .append("number")
                    .append(")values(")
                    .append("'").append(userId).append("',")
                    .append("'").append(bookId).append("',")
                    .append("'").append(number).append("')");
        }
        String update = ("update books set number = number - " + number + " where id =" + bookId);
        statement.executeUpdate(update);
        System.out.println(update);
        System.out.println(insertBuilder);
        statement.executeUpdate(insertBuilder.toString());
    }

    public static User findUserByName(String name) throws SQLException {
        String sqlSelectBuilder = "Select * " +
                "from bookUser " +
                "where " +
                "name " +
                "=" +
                "'" + name + "'";
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery(sqlSelectBuilder);
        if (set.next()) {
            String id = set.getString(1);
            String email = set.getString(3);
            String phone = set.getString(4);
            String password = set.getString(5);
            double money = Double.parseDouble(set.getString(6));
            set.close();
            statement.close();
            return new User(Integer.parseInt(id), name, email, phone, password, money);
        }
        return null;
    }

    public static Queue<String> getAllComments(String bookId) throws SQLException {
        String sqlSelectBuilder = "Select * " +
                "from bookComments " +
                "where " +
                "bookId " +
                "=" +
                "'" + bookId + "'";
        Queue<String> msgs = new ArrayDeque<>();
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery(sqlSelectBuilder);
        while (set.next()) {
            String userId = set.getString(2);
            String comment = set.getString(3);
            User user = findUserById(userId);
            if (user != null) {
                msgs.offer(user.name + " : " + comment);
                System.out.println(user.name + " : " + comment);
            }

        }
        set.close();
        statement.close();
        return msgs;
    }

}
