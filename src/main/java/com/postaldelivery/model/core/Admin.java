package com.postaldelivery.model.core;

public class Admin {

    private int id;       
    private String name;  
    private String password;  

    // Constructor with id
    public Admin(int id, String name, String password) {
        this.id = id;
        this.name = name;
        this.password = password;
    }

    // Constructor without id (for creating new admins without knowing the ID)
    public Admin(String name, String password) {
        this.name = name;
        this.password = password;
    }

    // Getters and Setters for id, name, and password
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

	@Override
	public String toString() {
		return "Admin [id=" + id + ", name=" + name + ", password=" + password + "]";
	}
    
    
}
