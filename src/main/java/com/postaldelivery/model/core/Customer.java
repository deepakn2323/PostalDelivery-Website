package com.postaldelivery.model.core;

public class Customer {
    private int id;
    private String name;
    private String aadharNumber;
    private String address;
    private int cityId;
    private String city;
    private String password;

    public Customer(String name, String aadharNumber, String address, int cityId, String password) {
        this.name = name;
        this.aadharNumber = aadharNumber;
        this.address = address;
        this.cityId = cityId;
        this.password=password;
    }

    public Customer(int id, String name, String aadharNumber, String address, int cityId, String password) {
		// TODO Auto-generated constructor stub
    	this.id=id;
    	this.name = name;
        this.aadharNumber = aadharNumber;
        this.address = address;
        this.cityId = cityId;
        this.password=password;
	}
    
    public Customer(int id, String name, String aadharNumber, String address, String city, String password) {
		// TODO Auto-generated constructor stub
    	this.id=id;
    	this.name = name;
        this.aadharNumber = aadharNumber;
        this.address = address;
        this.setCity(city);
        this.password=password;
	
    }

	

	// Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAadharNumber() {
		return aadharNumber;
	}

	public void setAadharNumber(String aadharNumber) {
		this.aadharNumber = aadharNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getCityId() {
		return cityId;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "Customer [id=" + id + ", name=" + name + ", aadharNumber=" + aadharNumber + ", address=" + address
				+ ", cityId=" + cityId + ", password=" + password + "]";
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	

    
}
