package test;

import data.Book;
import data.BookType;
import data.DataManager;

import java.util.Date;

/**
 * Created by pc on 2016/12/17.
 */
public class Test {
    public static void main(String[] args) {
//        for (BookType type : BookType.values()) {
//            System.out.println(type.toString());
//        }
//        System.out.println(BookType.valueOf("Other"));

//        long t = 5 * 365L * 1000 * 3600 * 24;
//        Date date = new Date(System.currentTimeMillis() - t);
//        String[] str = date.toString().split(" ");
//        String time = str[str.length - 1] + String.format("%2d%2d", date.getMonth() + 1, date.getDate());
//        System.out.println(time);

        for (int i = 0; i < 10; i++) {
            for (Book book : DataManager.dataManager) {
                System.out.println(1);
                break;
            }
        }

    }

}
