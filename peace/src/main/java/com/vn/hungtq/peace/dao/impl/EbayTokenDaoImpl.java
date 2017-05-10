package com.vn.hungtq.peace.dao.impl;

import com.vn.hungtq.peace.dao.EbayTokenDao;
import com.vn.hungtq.peace.entity.EbayToken;
import org.apache.xmlbeans.impl.xb.xsdschema.RestrictionDocument;
import org.hibernate.NonUniqueResultException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;

import javax.transaction.Transactional;

/**
 * Created by KAI on 5/4/17.
 */
@Transactional
public class EbayTokenDaoImpl implements EbayTokenDao{


    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sf){
        this.sessionFactory = sf;
    }



    @Override
    public void saveToken(EbayToken ebayToken) {
        getCurrentSession().save(ebayToken);
    }

    @Override
    public void updateToken(EbayToken ebayToken) {
        getCurrentSession().saveOrUpdate(ebayToken);
    }

    @Override
    public EbayToken findByToken(String usertoken) {
        EbayToken obj;
        try{
            obj = (EbayToken)getCurrentSession().createQuery("Select e from EbayToken e where e.token = :token").setParameter("token", usertoken).uniqueResult();

        }catch (NonUniqueResultException e){
            return null;
        }
        return obj;
    }

    @Override
    public EbayToken findByUser(Integer user) {
        EbayToken ebayToken;
        try{
            ebayToken = (EbayToken)getCurrentSession().createCriteria(EbayToken.class)
                    .add(Restrictions.eq("userId", user)).uniqueResult();
        }catch (NonUniqueResultException e){
            return null;
        }

        return ebayToken;
    }

    public Session getCurrentSession() {
        return this.sessionFactory.getCurrentSession();
    }
}
