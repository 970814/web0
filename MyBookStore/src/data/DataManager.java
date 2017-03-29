package data;

import java.util.LinkedList;
import java.util.Random;

import static data.RandomData.*;

/**
 * Created by pc on 2016/12/17.
 */
public class DataManager extends LinkedList<Book> {

    public static DataManager dataManager = new DataManager();


    private DataManager() {
        initialize();
    }



    private void initialize() {
        for (int i = 0; i < 100; i++) {
            add(randomType());
        }
    }

    private void add(BookType bookType) {
//        String name;
//        double price;
//        int number;
//        String author;
//        String src;
//        String publishTime;

        Book book = new Book(randomName()
                , randomPrice()
                , randomNumber()
                , randomAuthor()
                , randomSrc()
                , randomPublishTime()
                , bookType);
        add(book);
    }


    public static Book findBookByName(String name) {
        for (Book book : dataManager) {
            if (book.name.equals(name)) {
                return book;
            }
        }
        throw new RuntimeException("impossible");
    }

    public void showAll() {
        forEach(book -> System.out.println(book.name + ", " + book.price + ", " + book.author + ", " + book.type));
        System.out.println("The number of books: " + size());
    }
}
