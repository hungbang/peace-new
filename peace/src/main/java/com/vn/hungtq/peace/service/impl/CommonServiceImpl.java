package com.vn.hungtq.peace.service.impl;

import com.vn.hungtq.peace.controller.APISearchUtils;
import com.vn.hungtq.peace.dao.EbayTokenDao;
import com.vn.hungtq.peace.entity.EbayToken;
import com.vn.hungtq.peace.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

/**
 * Created by KAI on 5/4/17.
 */
@Service
public class CommonServiceImpl implements CommonService {

    @Autowired
    EbayTokenDao ebayTokenDao;

    @Override
    public void saveEbayToken(EbayToken ebayToken) {
        ebayTokenDao.saveToken(ebayToken);
    }

    @Override
    public void updateEbayToken(EbayToken ebayToken) {
        ebayTokenDao.updateToken(ebayToken);
    }

    @Override
    public EbayToken findByToken(String usertoken) {
        return ebayTokenDao.findByToken(usertoken);
    }

    @Override
    public EbayToken findByUser(Integer user) {
        return ebayTokenDao.findByUser(user);
    }

    @Override
    @Cacheable(value = "amazonSearchKeyword")
    public String callAmazonAPIByKeyword(String keyword) {
        String result = APISearchUtils.amazonSearchKeyWord(keyword);
        return result;
    }
}
