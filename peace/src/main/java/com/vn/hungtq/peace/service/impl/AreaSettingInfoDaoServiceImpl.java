package com.vn.hungtq.peace.service.impl;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.vn.hungtq.peace.dto.CostShippingDto;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import com.vn.hungtq.peace.entity.AreaSettingInfo; 
import com.vn.hungtq.peace.service.AreaSettingInfoDaoService;

public class AreaSettingInfoDaoServiceImpl extends BaseDaoServiceImpl implements AreaSettingInfoDaoService {

	@Override
	public void batchInsertAreaSettingInfo(List<AreaSettingInfo> lstAreaSettingInfo) {
		//Transaction to batch insert --Cannot use batch-fix later
		Session session = sessionFactory.openSession();
		
		//Loop to add batch
		for(AreaSettingInfo areaSettingInfo:lstAreaSettingInfo){
			session.save(areaSettingInfo);
		} 
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AreaSettingInfo> loadAreaSettingInfoFollowUser(int userId,int areaId) {
		return getCurrentSession().createQuery("from AreaSettingInfo where userId =? and timeUnitMapping.useOnArea = ?")
								  .setParameter(0, userId)
								  .setParameter(1, areaId)
								  .list();
	}

	@Override
	public boolean isExistAreaSettingInfoOfUser(int userId,int areaId) {
		List<AreaSettingInfo> lstAreaSettingInfoOfUser = this.loadAreaSettingInfoFollowUser(userId,areaId);
		return lstAreaSettingInfoOfUser.size()>0;
	}

	@Override
	public void updateListAreaSettingInfo(List<AreaSettingInfo> lstAreaSettingInfo) {
		//Transaction to batch update --Cannot use batch-fix later
		Session session = sessionFactory.openSession();
		
		//Loop to add batch
		for(AreaSettingInfo areaSettingInfo:lstAreaSettingInfo){
			session.update(areaSettingInfo);
		} 
		
		session.flush();
	}

	@Override
	public List<CostShippingDto> getShippingArea(int areaId, int weight) {
		List<CostShippingDto> lst = new ArrayList<CostShippingDto>();
		SQLQuery query = getCurrentSession().createSQLQuery("SELECT si.time_shipping, mp.place_holder FROM area_setting_info si , time_unit_mapping mp, ebay_shipping_method sm" +
				", (select name, min(name - 6) from ebay_shipping_method \n" +
				"where name - "+weight+" >= 0) t  where si.time_unit_mapping_id = mp.time_unit_id and mp.use_on_area = "+areaId+" and mp.shipping_method_id= sm.id and sm.name = t.name ;");
		query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
		List data = query.list();
		for(Object object : data)
		{
			Map row = (Map)object;
			CostShippingDto dto = new CostShippingDto();
			dto.setTimeShipping(row.get("time_shipping").toString());
			dto.setPlaceHolder(row.get("place_holder").toString());
			lst.add(dto);
		}
		return lst;
	}
}
