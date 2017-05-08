package com.vn.hungtq.peace.dto;

public class EbayProductToAdd {
	private String itemId;
	private String title;
	private String globalId;
	private String categoryId;
	private String categoryName;
	private String imageUrl;
	private String paymentMethod;
	private String viewItemUrl;
	private boolean autoPay;
	private String portalCode;
	private String location;
	private String country;
	private String currencyId;
	private String shippingCost;
	private String shippingType;
	private String shippingToLocation;
	private String expeditedShipping;
	private boolean oneDayShippingAvailable;
	private String handingTime;
	private String currentPrice ;

	public EbayProductToAdd(){}

	public EbayProductToAdd(Builder builder) {
		itemId = builder.itemId;
		title = builder.title;
		globalId = builder.globalId;
		categoryId = builder.categoryId;
		categoryName = builder.categoryName;
		imageUrl = builder.imageUrl;
		paymentMethod = builder.paymentMethod;
		viewItemUrl = builder.viewItemUrl;
		autoPay = builder.autoPay;
		portalCode = builder.portalCode;
		location = builder.location;
		country = builder.country;
		currencyId = builder.currencyId;
		shippingCost = builder.shippingCost;
		shippingType = builder.shippingType;
		shippingToLocation = builder.shippingToLocation;
		expeditedShipping = builder.expeditedShipping;
		oneDayShippingAvailable = builder.oneDayShippingAvailable;
		handingTime = builder.handingTime;
		currentPrice = builder.currentPrice;
	}

	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getGlobalId() {
		return globalId;
	}
	public void setGlobalId(String globalId) {
		this.globalId = globalId;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public boolean isAutoPay() {
		return autoPay;
	}
	public void setAutoPay(boolean autoPay) {
		this.autoPay = autoPay;
	}
	public String getPortalCode() {
		return portalCode;
	}
	public void setPortalCode(String portalCode) {
		this.portalCode = portalCode;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCurrencyId() {
		return currencyId;
	}
	public void setCurrencyId(String currencyId) {
		this.currencyId = currencyId;
	}
	public String getShippingCost() {
		return shippingCost;
	}
	public void setShippingCost(String shippingCost) {
		this.shippingCost = shippingCost;
	}
	public String getShippingType() {
		return shippingType;
	}
	public void setShippingType(String shippingType) {
		this.shippingType = shippingType;
	}
	public String getShippingToLocation() {
		return shippingToLocation;
	}
	public void setShippingToLocation(String shippingToLocation) {
		this.shippingToLocation = shippingToLocation;
	}
	public String getExpeditedShipping() {
		return expeditedShipping;
	}
	public void setExpeditedShipping(String expeditedShipping) {
		this.expeditedShipping = expeditedShipping;
	}
	public boolean isOneDayShippingAvailable() {
		return oneDayShippingAvailable;
	}
	public void setOneDayShippingAvailable(boolean oneDayShippingAvailable) {
		this.oneDayShippingAvailable = oneDayShippingAvailable;
	}
	public String getHandingTime() {
		return handingTime;
	}
	public void setHandingTime(String handingTime) {
		this.handingTime = handingTime;
	}
	public String getCurrentPrice() {
		return currentPrice;
	}
	public void setCurrentPrice(String currentPrice) {
		this.currentPrice = currentPrice;
	}
	public String getViewItemUrl() {
		return viewItemUrl;
	}
	public void setViewItemUrl(String viewItemUrl) {
		this.viewItemUrl = viewItemUrl;
	} 

	public static class Builder{
		private String itemId;
		private String title;
		private String globalId;
		private String categoryId;
		private String categoryName;
		private String imageUrl;
		private String paymentMethod;
		private String viewItemUrl;
		private boolean autoPay;
		private String portalCode;
		private String location;
		private String country;
		private String currencyId;
		private String shippingCost;
		private String shippingType;
		private String shippingToLocation;
		private String expeditedShipping;
		private boolean oneDayShippingAvailable;
		private String handingTime;
		private String currentPrice ;

		public Builder(){}
		public Builder currentPrice(String val){
			currentPrice = val; return this;
		}
		public Builder handingTime(String val){
			handingTime = val; return this;
		}
		public Builder categoryName(String val){
			categoryName = val; return this;
		}
		public Builder oneDayShippingAvailable(boolean val){
			oneDayShippingAvailable = val; return this;
		}
		public Builder expeditedShipping(String val){
			expeditedShipping = val; return this;
		}
		public Builder shippingToLocation(String val){
			shippingToLocation = val; return this;
		}
		public Builder shippingType(String val){
			shippingType = val; return this;
		}
		public Builder shippingCost(String val){
			shippingCost = val; return this;
		}
		public Builder currencyId(String val){
			currencyId = val; return this;
		}

		public Builder country(String val){
			country = val; return this;
		}
		public Builder location(String val){
			location = val; return this;
		}
		public Builder portalCode(String val){
			portalCode = val; return this;
		}
		public Builder autoPay(boolean val){
			autoPay = val; return this;
		}
		public Builder itemId(String val){
			itemId = val; return this;
		}
		public Builder title(String val){
			title = val; return this;
		}
		public Builder globalId(String val){
			globalId = val; return this;
		}
		public Builder categoryId(String val){
			categoryId = val; return this;
		}
		public Builder imageUrl(String val){
			imageUrl = val; return this;
		}
		public Builder paymentMethod(String val){
			paymentMethod = val; return this;
		}
		public Builder viewItemUrl(String val){
			viewItemUrl = val; return this;
		}

		public EbayProductToAdd build(){
			return new EbayProductToAdd(this);
		}

	}

}
