package data;

import java.util.Date;
import java.util.LinkedList;
import java.util.Queue;

import static data.DataManager.dataManager;
import static data.RandomData.bookTypes;
import static data.RandomData.types;

/**
 * Created by pc on 2016/12/18.
 */
public class DataSearcher {
    public static LinkedList<Book> search(String bookName
            , String src
            , String author
            , String bookType
            , String minPrice
            , String maxPrice
            , String startTime
            , String endTime) {
        LinkedList<Book> books = (LinkedList<Book>) dataManager.clone();
        filterBook(books, bookName);
        filterSrc(books, src);
        filterAuthor(books, author);
        filterType(books, bookType);
        filterMinPrice(books, minPrice);
        filterMaxPrice(books, maxPrice);
        filterStartTime(books, startTime);
        filterEndTime(books, endTime);
        return books;
    }

    private static void filterEndTime(LinkedList<Book> books, String endTime) {
        if (endTime == null || endTime.equals("")) {
            return;
        }
        final int time = Integer.parseInt(endTime);
        for (int i = 0; i < books.size(); i++) {
            int time2 = Integer.parseInt(books.get(i).publishTime);
            if (time2 > time) {
                books.remove(i--);
            }
        }
    }

    private static void filterStartTime(LinkedList<Book> books, String startTime) {
    /*    Date date = new Date();
        date.setYear(Integer.parseInt(startTime.substring(0, 4)));
        date.setMonth(Integer.parseInt(startTime.substring(4, 6)));
        date.setDate(Integer.parseInt(startTime.substring(6, 8)));*/
        if (startTime == null || startTime.equals("")) {
            return;
        }
        final int time = Integer.parseInt(startTime);
        for (int i = 0; i < books.size(); i++) {
            int time2 = Integer.parseInt(books.get(i).publishTime);
            if (time2 < time) {
                books.remove(i--);
            }
        }
    }

    private static void filterMaxPrice(LinkedList<Book> books, String maxPrice) {
        if (maxPrice == null || maxPrice.equals("")) {
            return;
        }
        double max = Double.parseDouble(maxPrice);
        for (int i = 0; i < books.size(); i++) {
            if (books.get(i).price > max) {
                books.remove(i--);
            }
        }
    }

    private static void filterMinPrice(LinkedList<Book> books, String minPrice) {
        if (minPrice == null || minPrice.equals("")) {
            return;
        }
        double min = Double.parseDouble(minPrice);
        for (int i = 0; i < books.size(); i++) {
            if (books.get(i).price < min) {
                books.remove(i--);
            }
        }
    }

    private static void filterType(LinkedList<Book> books, String bookType) {
        if (bookType == null || bookType.equals("")) {
            return;
        }
        BookType type = null;
        for (int i = 0; i < types.length; i++) {
            if (types[i].equals(bookType)) {
                type = bookTypes[i];
                break;
            }
        }
        if (type == null) {
            type = BookType.valueOf(bookType);
        }
        for (int i = 0; i < books.size(); i++) {
            if (!books.get(i).type.equals(type)) {
                books.remove(i--);
            }
        }
    }

    private static void filterAuthor(LinkedList<Book> books, String author) {
        if (author == null || author.equals("")) {
            return;
        }
        for (int i = 0; i < books.size(); i++) {
            if (!books.get(i).author.equals(author)) {
                books.remove(i--);
            }
        }
    }

    private static void filterSrc(LinkedList<Book> books, String src) {
        if (src == null || src.equals("")) {
            return;
        }
        for (int i = 0; i < books.size(); i++) {
            if (!books.get(i).src.equals(src)) {
                books.remove(i--);
            }
        }
    }

    private static void filterBook(LinkedList<Book> books, String bookName) {
        if (bookName == null || bookName.equals("")) {
            return;
        }
        for (int i = 0; i < books.size(); i++) {
            if (!books.get(i).name.equals(bookName)) {
                books.remove(i--);
            }
        }
    }
}
