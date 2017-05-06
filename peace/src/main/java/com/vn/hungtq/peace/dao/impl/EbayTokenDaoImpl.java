package com.vn.hungtq.peace.dao.impl;

import com.vn.hungtq.peace.dao.EbayTokenDao;
import com.vn.hungtq.peace.entity.EbayToken;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * Created by KAI on 5/4/17.
 */
@Repository
public class EbayTokenDaoImpl implements EbayTokenDao{

    @Autowired
    private SessionFactory sessionFactory;

    protected Session getCurrentSession(){
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void saveToken(EbayToken ebayToken) {
        getCurrentSession().saveOrUpdate(ebayToken);
    }

    @Override
    public void updateToken(EbayToken ebayToken) {
        getCurrentSession().saveOrUpdate(ebayToken);
    }
}
