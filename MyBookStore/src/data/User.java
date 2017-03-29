package data;

/**
 * Created by L on 2016/12/19.
 */
public class User {
    public int id;
    public String name;
    public String email;
    public String phone;
    public String password;
    public double money;

    public User(String name, String email, String phone, String password, double money) {
        this(-1, name, email, phone, password, money);
    }

    public User(int id, String name, String email, String phone, String password, double money) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.money = money;
    }

    public String getMoney() {
        return String.format("%.2f", money);
    }
}
