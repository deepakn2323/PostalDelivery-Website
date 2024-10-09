package com.postaldelivery.model.core;
public class PostCard {
	private static int idIncrement;
    private int id;
    private int senderId;
    private String senderName;
    private String senderAddress;
    private String senderCity;
    private String receiverName;
    private String receiverAddress;
    private String receiverCity;
    private String message;
    private String status;
    //customer sendpost
    public PostCard( int senderId, String senderName, String senderAddress, String senderCity, String receiverName,String receiverAddress, String receiverCity,String message) {
        this.id = ++idIncrement;
    	this.senderId = senderId;
    	this.senderName = senderName;
		this.senderAddress = senderAddress;
		this.senderCity = senderCity;
        this.receiverName = receiverName;
        this.receiverAddress = receiverAddress;
        this.receiverCity = receiverCity;
        this.message = message;
        this.status = "Not Delivered";
    }

//    getPostcardById
	public PostCard(int id, String senderName, String senderAddress, String senderCity, String receiverName,String receiverAddress, String receiverCity, String message, String status) {
		this.id = id;
		this.senderName = senderName;
		this.senderAddress = senderAddress;
		this.senderCity = senderCity;
        this.receiverName = receiverName;
        this.receiverAddress = receiverAddress;
        this.receiverCity = receiverCity;
        this.message = message;
        this.status = status;
		// TODO Auto-generated constructor stub
	}
	
	
//	getUndeliveredPostcardsForPostOffice
	public PostCard(int id,int senderId, String senderName, String senderAddress, String senderCity, String receiverName,String receiverAddress, String receiverCity, String status) {
		this.id = id;
		this.senderId = senderId;
		this.senderName = senderName;
		this.senderAddress = senderAddress;
		this.senderCity = senderCity;
        this.receiverName = receiverName;
        this.receiverAddress = receiverAddress;
        this.receiverCity = receiverCity;
        this.status = status;
		// TODO Auto-generated constructor stub
	}
	
	public void setId(int id) {
		this.id = id;
	}
	public int getSenderId() {
		// TODO Auto-generated method stub
		return senderId;
	}
	
	public int getId() {
		return id;
	}

	public void id(int id) {
		this.id = id;
	}

	public void setSenderId(int senderId) {
		this.senderId = senderId;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getSenderAddress() {
		return senderAddress;
	}

	public void setSenderAddress(String senderAddress) {
		this.senderAddress = senderAddress;
	}

	public String getSenderCity() {
		return senderCity;
	}

	public void setSenderCity(String senderCity) {
		this.senderCity = senderCity;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public String getReceiverAddress() {
		return receiverAddress;
	}

	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}

	public String getReceiverCity() {
		return receiverCity;
	}

	public void setReceiverCity(String receiverCity) {
		this.receiverCity = receiverCity;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	

	

	
	

    // Getters and Setters
    
}
