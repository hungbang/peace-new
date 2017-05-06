package com.vn.hungtq.peace.service;

import com.vn.hungtq.peace.entity.EbayToken;

/**
 * Created by KAI on 5/4/17.
 */

public interface CommonService {
    void saveEbayToken(EbayToken ebayToken);

    void updateEbayToken(EbayToken ebayToken);

    EbayToken findByToken(String usertoken);

    EbayToken findByUser(Integer user);
}
