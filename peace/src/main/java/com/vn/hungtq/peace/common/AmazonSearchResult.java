package com.vn.hungtq.peace.common;

import java.util.ArrayList; 
import java.util.List;

/**
 * Created by napt2017 on 3/24/2017.
 */
public class AmazonSearchResult {
    private  List<AmazonProductSearch> lstProductSearch;
    private int totalPage;
    private int currentPage;

    public AmazonSearchResult() {
        this.setLstProductSearch(new ArrayList<AmazonProductSearch>(26));
    }

    public void addAllProductSearch(List<AmazonProductSearch> lstSubProductSearch){
        this.getLstProductSearch().addAll(lstSubProductSearch);
    }


    public List<AmazonProductSearch> getLstProductSearch() {
        return lstProductSearch;
    }

    public void setLstProductSearch(List<AmazonProductSearch> lstProductSearch) {
        this.lstProductSearch = lstProductSearch;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
}
