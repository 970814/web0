package data;

import java.util.ArrayList;

/**
 * Created by pc on 2016/12/17.
 */
public class Book {
    public  int id;
   public String name;
    public double price;
    public  int number;
    public BookType type = BookType.other;
    public  String author;
    public  String src;
    public  String publishTime;
    public  ArrayList<String> comments;

    public Book(int id, String name, double price, int number, BookType type, String author, String src, String publishTime) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.number = number;
        this.type = type;
        this.author = author;
        this.src = src;
        this.publishTime = publishTime;
    }

    public Book(String name, double price, int number, int id,
                ArrayList<String> comments, String author, String src, String publishTime, BookType type) {
        this.name = name;
        this.price = price;
        this.number = number;
        this.id = id;
        this.comments = comments;
        this.author = author;
        this.src = src;
        this.publishTime = publishTime;
        this.type = type;
    }

    public Book(String name, double price, int number,
                String author, String src, String publishTime, BookType type) {
        this(name, price, number, -1, null, author, src, publishTime, type);
    }



    public String getPrice() {
        return String.format("%.2f", price);
    }

    public String getPublishTime() {
        return publishTime.substring(0, 10);
    }
}
