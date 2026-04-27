package model;

import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private String customerName;
    private String phone;
    private String address;
    private String note;
    private double total;
    private String status;
    private Date orderDate;
    private List<OrderItem> items;
    
    // Constructors
    public Order() {}
    
    public Order(int id, int userId, String customerName, String phone, String address, 
                 double total, String status, Date orderDate) {
        this.id = id;
        this.userId = userId;
        this.customerName = customerName;
        this.phone = phone;
        this.address = address;
        this.total = total;
//        this.status = status;
        this.orderDate = orderDate;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
    
//    public String getStatus() { return status; }
//    public void setStatus(String status) { this.status = status; }
    
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
    
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
}