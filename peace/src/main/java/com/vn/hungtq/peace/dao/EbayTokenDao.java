package com.vn.hungtq.peace.dao;

import com.vn.hungtq.peace.entity.EbayToken;

/**
 * Created by KAI on 5/4/17.
 */
public interface EbayTokenDao {

    void saveToken(EbayToken ebayToken);
    void updateToken(EbayToken ebayToken);

    EbayToken findByToken(String usertoken);

    EbayToken findByUser(Integer user);
}
