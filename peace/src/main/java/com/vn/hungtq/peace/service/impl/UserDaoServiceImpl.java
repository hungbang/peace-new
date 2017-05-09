package com.vn.hungtq.peace.service.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vn.hungtq.peace.common.CommonUtils;
import com.vn.hungtq.peace.entity.User;
import com.vn.hungtq.peace.service.UserDaoService;

public class UserDaoServiceImpl extends BaseDaoServiceImpl implements UserDaoService {
    static final Logger logger = LoggerFactory.getLogger(UserDaoServiceImpl.class);

    @Override
    public User findById(int id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public User findBySSO(String sso) {
        logger.info("SSO : {}", sso);
        Criteria crit = getCurrentSession().createCriteria(User.class);
        crit.add(Restrictions.eq("username", sso));
        User user = (User) crit.uniqueResult();
        if (user != null) {
            Hibernate.initialize(user.getUserRoles());
        }
        return user;
    }

    @Override
    public void save(User user) {
        // TODO Auto-generated method stub

    }

    @Override
    public void deleteBySSO(String sso) {
        // TODO Auto-generated method stub

    }

    @Override
    public List<User> findAllUsers() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public User getUserById(int userId) {
        @SuppressWarnings("unchecked")
        List<User> users = (List<User>) getCurrentSession().createQuery("from User where id=?")
                .setParameter(0, userId)
                .list();
        return users.get(0);
    }

    @Override
    public boolean isPasswordCorrect(int userId, String rawPassword) {
        @SuppressWarnings("unchecked")
        List<User> lstUser = getCurrentSession().createQuery("from User where id = ?")
                .setParameter(0, userId)
                .list();
        if (lstUser.size() > 0) {
            return CommonUtils.isSameHash(rawPassword, lstUser.get(0).getPassword());
        }

        return false;
    }

    @Override
    public void updateUser(User user) {
        getCurrentSession().update(user);
    }

    @Override
    public void updateLocation(User user) {
        String updateLocation = "update app_user set ebay_location = :location where id = :id";
        try {
            getCurrentSession().createSQLQuery(updateLocation).setParameter("location", user.getLocation())
                    .setParameter("id", user.getId()).executeUpdate();

        } catch (Exception e) {
            throw e;
        }
    }
}
