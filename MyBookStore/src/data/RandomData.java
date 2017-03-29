package data;

import java.util.Date;
import java.util.Random;

import static java.lang.Character.toUpperCase;

/**
 * Created by pc on 2016/12/17.
 */
public class RandomData {
    public static String[] types = new String[]{
            "科技",
            "少儿",
            "经管",
            "励志",
            "生活",
            "艺术",
            "人文",
            "考试",
            "进口",
            "其他",
    };
    public static Random random = new Random();
    public static BookType[] bookTypes = BookType.values();

    public static BookType randomType() {
        return bookTypes[random.nextInt(bookTypes.length)];
    }

    public static String randomName() {
        return randomSentence(2, 4).toString();
    }

    public static double randomPrice() {
        return Math.random() * 300 + 50;
    }

    public static int randomNumber() {
        return random.nextInt(9500) + 500;
    }

    public static String randomAuthor() {
        return randomSentence(2, 4).toString();
    }

    public static String randomSrc() {
        return randomSentence(5, 5).toString();
    }

    public static String randomPublishTime() {
        Date date = new Date(System.currentTimeMillis() - randomDate());
        int year = date.getYear() + 1900;
        String time = year + String.format("%02d%02d", date.getMonth() + 1, date.getDate());
        return time;
    }

    public static String randomPublishTime0() {
        return new StringBuilder().append(random.nextInt(116) + 1900)
                .append(String.format("%02d%02d", random.nextInt(12) + 1, random.nextInt(28 + 1))).toString();
    }

    @Deprecated
    public static long randomDate() {
        long t = random.nextInt(50) * yearLength() + random.nextInt(365) * dayLength();
        return System.currentTimeMillis() - t;
    }

    public static long randomDate0() {
        long t = random.nextInt(80) * yearLength() + random.nextInt(365) * dayLength();
        return System.currentTimeMillis() - t;
    }

    public static long yearLength() {
        return 365 * dayLength();
    }

    public static long dayLength() {
        return 1000 * 3600 * 24;
    }

    public static StringBuilder randomSentence(int p, int q) {
        StringBuilder sentence = randomWord(q);
        int n = random.nextInt(p) + 1;
        for (int i = 0; i < n - 1; i++) {
            sentence.append(randomWord(q)).append(' ');
        }
        return sentence.append(randomWord(q));
    }


    private static StringBuilder randomWord(int k) {
        int n = random.nextInt(k) + 2;
        StringBuilder word = new StringBuilder();
        word.append(toUpperCase(randomChar()));
        for (int i = 0; i < n; i++) {
            word.append(randomChar());
        }
        return word;
    }

    private static char randomChar() {
        return (char) ('a' + random.nextInt(26));
    }
}
