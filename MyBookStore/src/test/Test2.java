package test;

import data.Book;
import data.DataManager;
import data.DataSearcher;

import java.util.LinkedList;
import java.util.Scanner;

import static data.DataManager.dataManager;
import static data.DataSearcher.*;

/**
 * Created by pc on 2016/12/18.
 */
public class Test2 {
    public static void main(String[] args) {
        dataManager.showAll();
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.println("bookName >>>");
            String bookName = scanner.nextLine();
            System.out.println("src >>>");
            String src= scanner.nextLine();
            System.out.println("author >>>");
            String author= scanner.nextLine();
            System.out.println("bookType >>>");
            String bookType= scanner.nextLine();
            System.out.println("minPrice >>>");
            String minPrice = scanner.nextLine();
            System.out.println("maxPrice >>>");
            String maxPrice = scanner.nextLine();
            System.out.println("startTime >>>");
            String startTime= scanner.nextLine();
            System.out.println("endTime >>>");
            String endTime= scanner.nextLine();
            System.out.println("accepted...");
            DataManager books = (DataManager) search(bookName, src, author, bookType, minPrice, maxPrice, startTime, endTime);
            books.showAll();

        }

    }
}
