package com.postaldelivery.model.core;

public class PostMan {
	private int id;
    private String name;
    private String city;
    private int postOfficeId;
    private String password;

    public PostMan(int id, String name, String city, String password, int postOfficeId) {
        this.id = id;
        this.name = name;
        this.city = city;
        this.password = password;
        this.postOfficeId = postOfficeId;
    }

    public int getPostOfficeId() {
        return postOfficeId; 
    }

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

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "PostMan [id=" + id + ", name=" + name + ", city=" + city + ", postOfficeId=" + postOfficeId
				+ ", password=" + password + "]";
	}

	

    
}
