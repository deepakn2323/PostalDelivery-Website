package com.postaldelivery.model.core;

public class PostOffice {
    private int id;
    private int cityId;  
    private String city;
    public PostOffice(int id, int cityId) {
        this.id = id;
        this.cityId = cityId;
    }
    public PostOffice(int id,int cityId, String city) {
        this.id = id;
        this.cityId = cityId;
        this.city = city;
    }

    public PostOffice(int cityId) {
        this.cityId = cityId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCityId() {
        return cityId;
    }

    public void setCity(String city) {
        this.cityId = cityId;
    }
    
	public String getCity() {
		return city;
	}
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}
	@Override
	public String toString() {
		return "PostOffice [id=" + id + ", cityid=" + cityId + "]";
	}
    
    
}
