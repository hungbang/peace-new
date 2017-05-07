package com.vn.hungtq.peace.dto;

/**
 * Created by Minh on 07/05/2017.
 */
public class YahooProductAuctionSearch {

    private String auctionID;
    private String title;
    private String currentPrice;
    private String image;
    private String itemUrl;
    private String auctionItemUrl;
    private String bidOrBuy;

    public String getAuctionID() {
        return auctionID;
    }

    public void setAuctionID(String auctionID) {
        this.auctionID = auctionID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(String currentPrice) {
        this.currentPrice = currentPrice;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getItemUrl() {
        return itemUrl;
    }

    public void setItemUrl(String itemUrl) {
        this.itemUrl = itemUrl;
    }

    public String getAuctionItemUrl() {
        return auctionItemUrl;
    }

    public void setAuctionItemUrl(String auctionItemUrl) {
        this.auctionItemUrl = auctionItemUrl;
    }

    public String getBidOrBuy() {
        return bidOrBuy;
    }

    public void setBidOrBuy(String bidOrBuy) {
        this.bidOrBuy = bidOrBuy;
    }
}
