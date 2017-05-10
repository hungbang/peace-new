package com.vn.hungtq.peace.common;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by napt2017 on 3/24/2017.
 */
public class AmazonProductSearch {
    private  String name;
    private  String price;
    private  String imageUrl;
    private  String link;
    private  String sin;
    private  Map<String,String> productAttribute;
    private  int index;
    private String stock;


    public AmazonProductSearch(){}

    public AmazonProductSearch(String name, String price,String link ,String imageUrl,String sin,int index) {
        this.setName(name);
        this.setPrice(price);
        this.setImageUrl(imageUrl);
        this.setLink(link);
        this.setSin(sin);
        this.setIndex(index);
        this.setProductAttribute(new HashMap<String, String>());
    }

    public String getSin() {
        return sin;
    }

    public String getLink() {
        return link;
    }

    public void addProductAttribute(String key, String value){
        this.getProductAttribute().put(key,value);
    }

    public Map<String,String> getProductAttribute(){
        return this.productAttribute;
    }

    public String getName() {
        return name;
    }

    public String getPrice() {
        return price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public int getIndex() {
        return index;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public void setSin(String sin) {
        this.sin = sin;
    }

    public void setProductAttribute(Map<String, String> productAttribute) {
        this.productAttribute = productAttribute;
    }

    public void setIndex(int index) {
        this.index = index;
    }
}
