package com.vn.hungtq.peace.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List; 
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.stream.Collectors; 

import javax.servlet.http.HttpServletRequest;

import com.vn.hungtq.peace.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody; 
import org.springframework.web.servlet.ModelAndView;

import com.vn.hungtq.peace.common.AjaxResponseResult;
import com.vn.hungtq.peace.common.CommonUtils;
import com.vn.hungtq.peace.common.Tuple;
import com.vn.hungtq.peace.entity.AreaSettingInfo;
import com.vn.hungtq.peace.entity.Country;
import com.vn.hungtq.peace.entity.CountryGroup; 
import com.vn.hungtq.peace.entity.CountryUserMap;
import com.vn.hungtq.peace.entity.EbayAreaShippingMethodMap;
import com.vn.hungtq.peace.entity.EbayDeliveryMethod;
import com.vn.hungtq.peace.entity.EbaySettingLayoutConfiguration;
import com.vn.hungtq.peace.entity.EbayShippingArea;
import com.vn.hungtq.peace.entity.EbayShippingFee;
import com.vn.hungtq.peace.entity.EbayShippingMethod;
import com.vn.hungtq.peace.entity.NotShippingCountry;
import com.vn.hungtq.peace.entity.ReturnWarrantyMethod;
import com.vn.hungtq.peace.entity.TimeUnitMapping;
import com.vn.hungtq.peace.service.AreaSettingInfoDaoService;
import com.vn.hungtq.peace.service.CountryDaoService; 
import com.vn.hungtq.peace.service.CountryUserMapDaoService;
import com.vn.hungtq.peace.service.EbayAreaShippingMethodMapDaoService;
import com.vn.hungtq.peace.service.EbayDeliveryMethodDaoService;
import com.vn.hungtq.peace.service.EbaySettingLayoutConfigurationDaoService;
import com.vn.hungtq.peace.service.EbayShippingAreaDaoService;
import com.vn.hungtq.peace.service.EbayShippingFeeDaoService;
import com.vn.hungtq.peace.service.NotShippingCountryDaoService;
import com.vn.hungtq.peace.service.ReturnWarrantyMethodDaoService;
import com.vn.hungtq.peace.service.TimeUnitMappingDaoService;
import com.vn.hungtq.peace.service.UserDaoService;

@Controller
public class EbayShippingSettingController { 
	
	@Autowired
	CountryDaoService countryDaoService; 
	
	@Autowired
	CountryUserMapDaoService countryUserMapDaoService;
	
	@Autowired
	NotShippingCountryDaoService notShippingCountryDaoService;
	
	@Autowired
	EbaySettingLayoutConfigurationDaoService ebaySettingLayoutConfigurationDaoService;
	
	@Autowired
	EbayAreaShippingMethodMapDaoService ebayAreaShippingMethodMapDaoService;
	
	@Autowired
	ReturnWarrantyMethodDaoService returnWarrantyMethodDaoService;
	
	@Autowired
	EbayDeliveryMethodDaoService ebayDeliveryMethodDaoService;
	
	@Autowired
	EbayShippingFeeDaoService ebayShippingFeeDaoService;
	
	@Autowired
	EbayShippingAreaDaoService ebayShippingAreaDaoService;
	
	@Autowired
	AreaSettingInfoDaoService areaSettingInfoDaoService;
	
	@Autowired
	TimeUnitMappingDaoService timeUnitMappingDaoService;
	
	@Autowired
	private UserDaoService userService;
	
	Authentication authentication;
	
	@RequestMapping(value ="/SaveNotShippingCountry" ,method=RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> saveNotShippingCountryConfiguration(@RequestBody NotShippingCountryConfigurationDto notShippingCountryConfig,HttpServletRequest request){
		authentication = SecurityContextHolder.getContext().getAuthentication();
		AjaxResponseResult<String> responseResult = new AjaxResponseResult<String>();
		
		UserDto user = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService);
		countryUserMapDaoService.saveUserConfiguration(notShippingCountryConfig,user.getId());
		responseResult.setStatus("OK"); 
		return responseResult;
	} 
	
	@RequestMapping("/TransportSetting")
	public ModelAndView transportSetting(){
		return new ModelAndView("pages/G_TransportSetting");
	}
	
	@RequestMapping(value ="/SaveEbayDeliveryMethod" ,method=RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> saveEbayDeliveryMethod(@RequestBody EbayDeliveryMethodDto ebayDeliveryMethodDto ,HttpServletRequest request){
		authentication = SecurityContextHolder.getContext().getAuthentication();
		AjaxResponseResult<String> responseResult = new AjaxResponseResult<String>();
		int userId = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService).getId();
		Tuple<Boolean,EbayDeliveryMethod> checkExistTuple = ebayDeliveryMethodDaoService.isExistDeliveryMethod(userId);
		if(checkExistTuple.getFirst()){
			EbayDeliveryMethod existEbayDeliveryMethod = checkExistTuple.getSecond();
			existEbayDeliveryMethod.setOtherAreaShippingMethodId(ebayDeliveryMethodDto.getOtherAreaShippingMethodId());
			existEbayDeliveryMethod.setUsShippingMethodId(ebayDeliveryMethodDto.getUsShippingMethodId());
			existEbayDeliveryMethod.setShippingDetail(ebayDeliveryMethodDto.getShippingDetail());
			existEbayDeliveryMethod.setReturnWarrantyMethodId(ebayDeliveryMethodDto.getReturnWarrantyMethodId());
			ebayDeliveryMethodDaoService.updateEbayDeliveryMethod(existEbayDeliveryMethod);
		}else{
			EbayDeliveryMethod ebayDeliveryMethod = new EbayDeliveryMethod();
			ebayDeliveryMethod.setUserId(userId);
			ebayDeliveryMethod.setOtherAreaShippingMethodId(ebayDeliveryMethodDto.getOtherAreaShippingMethodId());
			ebayDeliveryMethod.setUsShippingMethodId(ebayDeliveryMethodDto.getUsShippingMethodId());
			ebayDeliveryMethod.setShippingDetail(ebayDeliveryMethodDto.getShippingDetail());
			ebayDeliveryMethod.setReturnWarrantyMethodId(ebayDeliveryMethodDto.getReturnWarrantyMethodId());
			ebayDeliveryMethodDaoService.saveEbayDeliveryMethod(ebayDeliveryMethod);
		}
		responseResult.setStatus("OK");
		return responseResult;
	}
	
	@RequestMapping(value ="/SaveEbayShippingFee",method=RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> saveEbayShippingFee(@RequestBody EbayShippingFeeDto ebayShippingFeeDto ,HttpServletRequest request){
		authentication = SecurityContextHolder.getContext().getAuthentication();
		AjaxResponseResult<String> responseResult = new AjaxResponseResult<String>();
		responseResult.setStatus("OK");
		int userId = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService).getId();
		Tuple<Boolean,EbayShippingFee> checkExistTuple = ebayShippingFeeDaoService.checkExistEbayShippingFee(userId);
		
		//Get list of area with method
		List<ShippingAreaWithMethodDto> listOfAreaWithMethod = ebayShippingFeeDto.getListAreaWithMethod();
		
		if(checkExistTuple.getFirst()){
			//Update
			EbayShippingFee ebayShippingFee = checkExistTuple.getSecond();
 			ebayShippingFee.setNumberOfDayToShip(ebayShippingFeeDto.getNumberOfDayToShip());
 			listOfAreaWithMethod.stream().forEach(areaWithMethod ->{  
 				if(ebayShippingFee.getEbayShippingAreaByFirstGroupAreaId().getId().intValue() == areaWithMethod.getAreaId()){
 					ebayShippingFee.setFirstShippingMethodId(areaWithMethod.getMethodId());
 				}else if(ebayShippingFee.getEbayShippingAreaBySecondGroupAreaId().getId().intValue() == areaWithMethod.getAreaId()){
 					ebayShippingFee.setSecondShippingMethodId(areaWithMethod.getMethodId());
 				}else if(ebayShippingFee.getEbayShippingAreaByThirdGroupAreaId().getId().intValue() == areaWithMethod.getAreaId()){
 					ebayShippingFee.setThirdShippingMethodId(areaWithMethod.getMethodId());
 				}else if(ebayShippingFee.getEbayShippingAreaByFourGroupAreaId().getId().intValue() == areaWithMethod.getAreaId()){
 					ebayShippingFee.setFourShippingMethodId(areaWithMethod.getMethodId());
 				}
			});
 			
 			ebayShippingFeeDaoService.upadateEbayShippingFee(ebayShippingFee);
		}else{
			//Save new 
			EbayShippingFee ebayShippingFee = new EbayShippingFee();
			ebayShippingFee.setUserId(userId);
			ebayShippingFee.setNumberOfDayToShip(ebayShippingFeeDto.getNumberOfDayToShip()); 
			
			//Some complex operation
			int layoutAreaId = ebayShippingFeeDto.getLayoutAreaId();
			List<EbayShippingArea> lstEbaySettingLayoutConfig = ebaySettingLayoutConfigurationDaoService.getEbayShippingAreaFollowLayoutArea(layoutAreaId);
			int [] tempIndex ={0};
			lstEbaySettingLayoutConfig.stream().forEach(s ->{ 
				 int areaId = s.getId();
				 listOfAreaWithMethod.stream().forEach(areaWithMethod ->{
					 if(areaId ==areaWithMethod.getAreaId()){
						 if(tempIndex[0]==0){
							 ebayShippingFee.setEbayShippingAreaByFirstGroupAreaId(s);
							 ebayShippingFee.setFirstShippingMethodId(areaWithMethod.getMethodId());
						 }else if(tempIndex[0]==1){
							 ebayShippingFee.setEbayShippingAreaBySecondGroupAreaId(s);
							 ebayShippingFee.setSecondShippingMethodId(areaWithMethod.getMethodId());
						 }else if(tempIndex[0]==2){
							 ebayShippingFee.setEbayShippingAreaByThirdGroupAreaId(s);
							 ebayShippingFee.setThirdShippingMethodId(areaWithMethod.getMethodId());
						 }else if(tempIndex[0]==3){
							 ebayShippingFee.setEbayShippingAreaByFourGroupAreaId(s);
							 ebayShippingFee.setFourShippingMethodId(areaWithMethod.getMethodId());
						 } 
						 tempIndex[0]++;
					 }
				 });
			});
			
			ebayShippingFeeDaoService.addEbayShippingFee(ebayShippingFee);
		}
		return responseResult;
	}
	
	@RequestMapping(value ="/LoadEbayShippingFee",method=RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<EbayShippingFeeDto> getEbayShippingFee(HttpServletRequest request){
		authentication = SecurityContextHolder.getContext().getAuthentication();
		AjaxResponseResult<EbayShippingFeeDto> responseResult = new AjaxResponseResult<EbayShippingFeeDto>();
		responseResult.setStatus("OK");
		
		int userId = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService).getId();
		Tuple<Boolean,EbayShippingFee> checkExistTuple = ebayShippingFeeDaoService.checkExistEbayShippingFee(userId);
		if(checkExistTuple.getFirst()){
			EbayShippingFee ebayShippingFee = checkExistTuple.getSecond();
			EbayShippingFeeDto ebayShippingFeeDto = new EbayShippingFeeDto(); 
			
			//List of area with method
			List<ShippingAreaWithMethodDto> lstShippingAreaWithMethod = new ArrayList<ShippingAreaWithMethodDto>(4);
			lstShippingAreaWithMethod.add(new ShippingAreaWithMethodDto(ebayShippingFee.getEbayShippingAreaByFirstGroupAreaId().getId(),ebayShippingFee.getFirstShippingMethodId())); 
			lstShippingAreaWithMethod.add(new ShippingAreaWithMethodDto(ebayShippingFee.getEbayShippingAreaBySecondGroupAreaId().getId(),ebayShippingFee.getSecondShippingMethodId())); 
			lstShippingAreaWithMethod.add(new ShippingAreaWithMethodDto(ebayShippingFee.getEbayShippingAreaByThirdGroupAreaId().getId(),ebayShippingFee.getThirdShippingMethodId())); 
			lstShippingAreaWithMethod.add(new ShippingAreaWithMethodDto(ebayShippingFee.getEbayShippingAreaByFourGroupAreaId().getId(),ebayShippingFee.getFourShippingMethodId())); 
			ebayShippingFeeDto.setListAreaWithMethod(lstShippingAreaWithMethod);
			
			//Set number days of ship
			ebayShippingFeeDto.setNumberOfDayToShip(ebayShippingFee.getNumberOfDayToShip());
			
			//Set record id
			responseResult.setRecordId(ebayShippingFee.getId());
			
			//Set extra object to request
			responseResult.setExtraData(ebayShippingFeeDto);
			
		}else{
			responseResult.setRecordId(-1);
		}
		
		return responseResult;
	}
	
	@RequestMapping(value ="/GetEbayDeliveryMethod" ,method=RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<EbayDeliveryMethodDto> loadUserDeliveryMethod(HttpServletRequest request){
		authentication = SecurityContextHolder.getContext().getAuthentication();
		AjaxResponseResult<EbayDeliveryMethodDto> responseResult = new AjaxResponseResult<EbayDeliveryMethodDto>();
		responseResult.setStatus("OK");
		int userId = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService).getId();
		Tuple<Boolean,EbayDeliveryMethod> checkExistTuple = ebayDeliveryMethodDaoService.isExistDeliveryMethod(userId);
		if(checkExistTuple.getFirst()){
			EbayDeliveryMethod ebayDeliveryMethod = checkExistTuple.getSecond();
			EbayDeliveryMethodDto ebayDeliveryMethodDto = new EbayDeliveryMethodDto();
			ebayDeliveryMethodDto.setOtherAreaShippingMethodId(ebayDeliveryMethod.getOtherAreaShippingMethodId());
			ebayDeliveryMethodDto.setUsShippingMethodId(ebayDeliveryMethod.getUsShippingMethodId());
			ebayDeliveryMethodDto.setShippingDetail(ebayDeliveryMethod.getShippingDetail());
			ebayDeliveryMethodDto.setReturnWarrantyMethodId(ebayDeliveryMethod.getReturnWarrantyMethodId()); 
			responseResult.setExtraData(ebayDeliveryMethodDto); 
			responseResult.setRecordId(ebayDeliveryMethod.getId());
		}else{
			responseResult.setRecordId(-1);
		}
		return responseResult;
	} 
	
	@RequestMapping(value ="/GetReturnWarrantyMethods" ,method=RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<List<ReturnWarrantyMethodDto>> getListReturnWarrantyMethod(){
		AjaxResponseResult<List<ReturnWarrantyMethodDto>> ajaxResult = new AjaxResponseResult<List<ReturnWarrantyMethodDto>>();
		List<ReturnWarrantyMethod> lstReturnWarrantyMethod = returnWarrantyMethodDaoService.getAllReturnWarrantyMethod();
		List<ReturnWarrantyMethodDto> lstResult = lstReturnWarrantyMethod.stream().map(s->{
			return new ReturnWarrantyMethodDto(s.getId(),s.getName());
		}).collect(Collectors.toList());
		
		ajaxResult.setExtraData(lstResult);
		return ajaxResult;
	}
	
	@RequestMapping(value ="/GetNotShippingCountry" ,method=RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<NotShippingCountryDto> getNotShippingCountry(HttpServletRequest request){ 
		//http://ledpixel.com.vn/san-pham/led-lien-day-5mm-mau-dai-ly-phan-phoi-led-pixel/
		authentication = SecurityContextHolder.getContext().getAuthentication();
		//Response result
		AjaxResponseResult<NotShippingCountryDto> ajaxResult = new AjaxResponseResult<NotShippingCountryDto>();
		
		//Get user id
		UserDto user = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService);
		int userId = user.getId();
		
		//Get list of not shipping country 
		List<NotShippingCountry> lstNotShippingCountry = notShippingCountryDaoService.loadAllNotShippingCountry(); 
		if(lstNotShippingCountry.size()>0){ 
			
			//Java 8 stream api
			//Get list of country group id from list of not shipping country
			List<Integer> lstCountryGroupId = lstNotShippingCountry.stream()
																   .map(data ->data.getCountryGroupId())
																   .collect(Collectors.toList()); 
			
			//Get Map of country group with map of country 
			//Key is country groupid and value is the country 
			Map<CountryGroup, List<CountryUserMap>> mapGroupCountry = countryDaoService.getMapOfCountryByGroup(lstCountryGroupId,userId); 
			
			//Wrapping all to dto object then response to client
			//First create NotShippingCountryDto
			NotShippingCountryDto nscCountryDto = new NotShippingCountryDto();
			ajaxResult.setExtraData(nscCountryDto);
			
			List<CountryGroupDto> lstCoutryGroupDto =  mapGroupCountry.entrySet().stream().map(entries ->{ 
				//Get key and value
				CountryGroup countryGroup = entries.getKey();
				List<CountryUserMap> lstCountry  = entries.getValue();
				
				//Create dto object
				CountryGroupDto countryGroupDto = new CountryGroupDto();
				countryGroupDto.setId(countryGroup.getId());
				countryGroupDto.setName(countryGroup.getName());
				
				List<CountryDto> lstCountryDto = lstCountry.stream().map(countryUserMap ->{
					Country country = countryUserMap.getCountry();
					CountryDto countryDto = new CountryDto();
					countryDto.setId(country.getId());
					countryDto.setName(country.getName());
					countryDto.setUserId(userId);
					countryDto.setSelected(countryUserMap.getIsSelect());
					
					return countryDto;
				}).collect(Collectors.toList());
				
				countryGroupDto.setLstCountries(lstCountryDto); 
				return countryGroupDto;
			}).collect(Collectors.toList());
			
			nscCountryDto.setLstCountryGroup(lstCoutryGroupDto);
		}
		
		return ajaxResult;
	} 
	
	@RequestMapping(value="/GetLayoutAreaSetting/{layoutAreaId}",method =RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<List<EbayShippingAreaDto>> getLayoutAreaSetting(@PathVariable("layoutAreaId") int layoutAreaId){
		
		//Get list ebay setting layout config 
		List<EbaySettingLayoutConfiguration> lstEbaySettingLayoutConfig = ebaySettingLayoutConfigurationDaoService.getLayoutSettingConfig(layoutAreaId);
		
		//The response data
		AjaxResponseResult<List<EbayShippingAreaDto>> ajaxResult = new AjaxResponseResult<>(); 
		
		//The list id of shipping area  
		List<Integer> lstShippingAreaIds = lstEbaySettingLayoutConfig.stream().map(ebaySettingLayoutConfig ->{
													return ebaySettingLayoutConfig.getEbayShippingArea().getId();
										    }).collect(Collectors.toList());
		
		//Get the area mapping with shipping method
		//Follow the list of shipping area id
		//It return the concurrent collection 
		//Because latter use it on concurrent context
		CopyOnWriteArrayList<EbayAreaShippingMethodMap> lstEbayAreaShippingMethodMap = ebayAreaShippingMethodMapDaoService.getShippingMethodFollowArea(lstShippingAreaIds);
		
		//The map of shipping area with shipping method
		Map<EbayShippingArea,List<EbayShippingMethod>> mapAreaWithShippingMethod = new HashMap<>();
		lstEbayAreaShippingMethodMap.stream().peek(s ->{
			EbayShippingArea area = s.getEbayShippingArea();
			EbayShippingMethod shipMethod = s.getEbayShippingMethod();
			
			if(mapAreaWithShippingMethod.containsKey(area)){
				mapAreaWithShippingMethod.get(area).add(shipMethod);
			}else{
				List<EbayShippingMethod> lstEbayShippingMethod = new ArrayList<>();
				lstEbayShippingMethod.add(shipMethod);
				mapAreaWithShippingMethod.put(area, lstEbayShippingMethod);
			}
		}).count();
		
		//Process lstEbayShippingAreaDto
		List<EbayShippingAreaDto> lstEbayShippingAreaDto =
		mapAreaWithShippingMethod.entrySet().stream().map(s->{
			EbayShippingArea area = s.getKey();
			List<EbayShippingMethod> lstShipMethod = s.getValue();
			
			EbayShippingAreaDto ebayShippingAreaDto = new EbayShippingAreaDto();
			ebayShippingAreaDto.setAreaName(area.getName());
			ebayShippingAreaDto.setAreaId(area.getId());
			ebayShippingAreaDto.setLstEbayShippingMethods(lstShipMethod.stream()
																	   .map(sMethod->{
																				return new EbayShippingMethodDto(sMethod.getId(), sMethod.getName());
																		}).collect(Collectors.toList())); 
			
			return ebayShippingAreaDto;
		}).collect(Collectors.toList());
		
		//Set order for lstEbayShippingAreaDto
		List<Tuple<Integer, EbayShippingArea>> lstAreaWithOrder = ebaySettingLayoutConfigurationDaoService.getEbayShippingAreaOrder(layoutAreaId);
		lstAreaWithOrder.stream().forEach(first ->{
			lstEbayShippingAreaDto.stream().forEach(second->{
				EbayShippingArea ebayShippingArea = first.getSecond();
				Integer areaDtoId = second.getAreaId();
				if(ebayShippingArea.getId().equals(areaDtoId)){
					second.setOrderBy(first.getFirst());
				}
			});
		});
		
		//Set data to ajax result
		ajaxResult.setExtraData(lstEbayShippingAreaDto);
		return ajaxResult;
	}
	
	@RequestMapping(value="/LoadLayoutAreaSetting/{areaId}",method =RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<AreaSettingTableDto> loadLayoutAreaSetting(@PathVariable("areaId") int areaId,HttpServletRequest request){
		authentication = SecurityContextHolder.getContext().getAuthentication();
		AjaxResponseResult<AreaSettingTableDto> responseResult = new AjaxResponseResult<AreaSettingTableDto>();
		responseResult.setStatus("OK");
		
		//The list of timeunit mapping
		List<TimeUnitMapping> lstTimeUnitMapping ;
		
		//Get user id
		int userId = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService).getId();
		boolean isExist = areaSettingInfoDaoService.isExistAreaSettingInfoOfUser(userId,areaId);
		if(!isExist){
			
			//Load all time unit mapping 
			lstTimeUnitMapping = timeUnitMappingDaoService.loadTimeUnitMappingFollowArea(areaId);
			
			//Convert to list of area setting info
			List<AreaSettingInfo> lstAreaSettingInfo = lstTimeUnitMapping.stream().map(s->{
				AreaSettingInfo areaSettingInfo = new AreaSettingInfo();
				areaSettingInfo.setTimeUnitMapping(s);
				areaSettingInfo.setTimeShipping(s.getPlaceHolder());
				areaSettingInfo.setUserId(userId); 
				areaSettingInfo.setUseOnArea(areaId);
				return areaSettingInfo;
			}).collect(Collectors.toList());
			
			//Save to db
			areaSettingInfoDaoService.batchInsertAreaSettingInfo(lstAreaSettingInfo);			
		}
		
		//Load area setting info for user
		List<AreaSettingInfo> lstAreaSettingInfos = areaSettingInfoDaoService.loadAreaSettingInfoFollowUser(userId,areaId)
																			 .stream()
																			 .collect(Collectors.toCollection(CopyOnWriteArrayList::new)); 
		//Map of shipping method with area setting
		Map<EbayShippingMethod,List<AreaSettingInfo>> mapOfSMethodWithAreaSetting = new HashMap<>();
		lstAreaSettingInfos.stream().peek(s->{
			EbayShippingMethod eSMethod = s.getTimeUnitMapping().getEbayShippingMethod();
			if(mapOfSMethodWithAreaSetting.containsKey(eSMethod)){
				mapOfSMethodWithAreaSetting.get(eSMethod).add(s);
			}else{
				List<AreaSettingInfo> tempList = new ArrayList<>();
				tempList.add(s);
				mapOfSMethodWithAreaSetting.put(eSMethod, tempList);
			}
		}).count();
		
		//Now process to convert
		List<AreaSettingInfoDto> listOfAreaSettingInfo = 
		mapOfSMethodWithAreaSetting.entrySet().stream().map(s->{
			
			//Get key and value
			EbayShippingMethod eSMethod = s.getKey();
			List<AreaSettingInfo> lstAreaSettingInfo = s.getValue();
			
			//Create new AreaSettingInfoDto
			AreaSettingInfoDto asInfoDto = new AreaSettingInfoDto();
			asInfoDto.setShippingMethodName(eSMethod.getName());
			
			//Because group of area setting info has same ischoice value 
			asInfoDto.setIsChoice(lstAreaSettingInfo.get(0).getIsChoice());
			
			//Process to convert lstAreaSettingInfo to list listOfAreaTimeUnitMapping
			List<AreaTimeUnitMappingDto> lstAreaTimeUnitMappingDto =
			lstAreaSettingInfo.stream().map(areaSettingInfo->{
				
				AreaTimeUnitMappingDto atmDto = new AreaTimeUnitMappingDto();
				atmDto.setRecordId(areaSettingInfo.getId());
				atmDto.setTimeShipping(areaSettingInfo.getTimeShipping());
				boolean isFree 		 = CommonUtils.getBooleanValue(areaSettingInfo.getIsFree());
				boolean isAsk  		 = CommonUtils.getBooleanValue(areaSettingInfo.getIsAsk());
				boolean isNoShipping = CommonUtils.getBooleanValue(areaSettingInfo.getIsNoShipping());
				
				int valueOfFreeAskNoShipping = -1;
				if(isFree){
					valueOfFreeAskNoShipping = 0;
				}else if(isAsk){
					valueOfFreeAskNoShipping = 1;
				}else if(isNoShipping){
					valueOfFreeAskNoShipping =2;
				}
				
				atmDto.setValueOfAskFreeAndNoShipping(valueOfFreeAskNoShipping);
				
				TimeUnitMapping tuMapping = areaSettingInfo.getTimeUnitMapping();
				atmDto.setMoneyName(tuMapping.getMoneyName());
				atmDto.setPlaceHolder(tuMapping.getPlaceHolder());
				atmDto.setAreaName(tuMapping.getEbayShippingArea().getName());
				atmDto.setTimeUnitMappingId(tuMapping.getId());
				
				return atmDto;
			}).collect(Collectors.toList());
			
			//Set list
			asInfoDto.setListOfAreaTimeUnitMapping(lstAreaTimeUnitMappingDto); 
			return asInfoDto;
		}).collect(Collectors.toList());
		
		//Get list of column header
		List<String> listOfColumnHeader = new ArrayList<String>();
		listOfColumnHeader.add("Shipping Method"); 
		mapOfSMethodWithAreaSetting.entrySet().stream().peek(s->{
			List<AreaSettingInfo> lstAreaSettingInfo = s.getValue();
			lstAreaSettingInfo.stream().peek(areaSettingInfo ->{
				listOfColumnHeader.add(areaSettingInfo.getTimeUnitMapping().getEbayShippingArea().getName());
			}).count();
			
		}).limit(1L).count(); 
		
		//Create AreaSettingTableDto object
		AreaSettingTableDto asTableDto = new AreaSettingTableDto();
		asTableDto.setLstAreaSettingDto(listOfAreaSettingInfo);
		asTableDto.setLstColumnHeader(listOfColumnHeader);
		
		//Set extra data for response
		responseResult.setExtraData(asTableDto);
		
		//Ret
		return responseResult;
	}

	@RequestMapping(value="/LoadLayoutAreaSettingByWeight/{areaId}/{weight}",method =RequestMethod.GET)
	public @ResponseBody List<CostShippingDto> loadLayoutAreaSettingByWeight(@PathVariable("areaId") int areaId, @PathVariable("weight") int weight, HttpServletRequest request){
		authentication = SecurityContextHolder.getContext().getAuthentication();
		List<CostShippingDto> lstDataShipping = new ArrayList<CostShippingDto>() ;

		//Get user id
		int userId = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService).getId();
		boolean isExist = areaSettingInfoDaoService.isExistAreaSettingInfoOfUser(userId,areaId);
		if(isExist){

			lstDataShipping = areaSettingInfoDaoService.getShippingArea(areaId, weight);
		}

		return lstDataShipping;
	}
	
	@RequestMapping("/NotShippingCountrySetting")
	public ModelAndView notShippingCountrySetting(){
		return new ModelAndView("pages/G_NotShippingCountry");
	}
	
	@RequestMapping(value ="/SaveUserAreaSetting" ,method=RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> saveUserAreaSettting(@RequestBody List<AreaSettingInfoDto> lstAreaSettingDto,HttpServletRequest request){
		authentication = SecurityContextHolder.getContext().getAuthentication();
		
		AjaxResponseResult<String> responseResult = new AjaxResponseResult<String>();
		responseResult.setStatus("OK");
		
		//Get user id
		int userId =CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService).getId();
		
		//Get all time unit mapping id follow the client post data
		List<Integer> lstTimeUnitMappingIds=
		lstAreaSettingDto.stream().map(areaSettingDto ->{
			return areaSettingDto.getListOfAreaTimeUnitMapping();
		}).map(lstAreaTimeMappingDto ->{
			return lstAreaTimeMappingDto.stream().map(areaTimeMappingDto ->{
				return areaTimeMappingDto.getTimeUnitMappingId();
			}).collect(Collectors.toList());
		}).flatMap(s->s.stream()).collect(Collectors.toList());
		
		
		//Get list of time unit mapping follow list of ids
		List<TimeUnitMapping> lstTimeUnitMapping = timeUnitMappingDaoService.loadTimeUnitMappingFollowIds(lstTimeUnitMappingIds);
		Map<Integer, List<TimeUnitMapping>> mapIdWithTimeUnitMapping = lstTimeUnitMapping.stream().collect(Collectors.groupingBy(TimeUnitMapping::getId));
		
		//Convert dto to list update entity
		List<AreaSettingInfo> lstUpdateAreaSettingInfos =
		lstAreaSettingDto.stream().map(s->{
			List<AreaTimeUnitMappingDto> listOfAreaTimeUnitMapping = s.getListOfAreaTimeUnitMapping();
			List<AreaSettingInfo> lstAreaSettingInfos = 
			listOfAreaTimeUnitMapping.stream().map(areaTimeUnit->{
				
				//Create area setting info object
				AreaSettingInfo areaSettingInfo = new AreaSettingInfo();
				areaSettingInfo.setIsChoice(s.getIsChoice());
				
				boolean isAsk  = false;
				boolean isFree = false;
				boolean isNoShipping  = false;
				int valueOfAskFreeNoShipping = areaTimeUnit.getValueOfAskFreeAndNoShipping();
				if(valueOfAskFreeNoShipping==0){
					isFree = true;
				}else if(valueOfAskFreeNoShipping ==1){
					isAsk = true;
				}else if(valueOfAskFreeNoShipping ==2){
					isNoShipping = true;
				}
				areaSettingInfo.setIsAsk(isAsk);
				areaSettingInfo.setIsFree(isFree);
				areaSettingInfo.setIsNoShipping(isNoShipping); 
				areaSettingInfo.setId(areaTimeUnit.getRecordId());
				areaSettingInfo.setUserId(userId); 
				areaSettingInfo.setTimeShipping(areaTimeUnit.getTimeShipping()); 
				
				//Get time unit mapping from map
				List<TimeUnitMapping> tmpLstTimeUnitMapping = mapIdWithTimeUnitMapping.get(areaTimeUnit.getTimeUnitMappingId());
				TimeUnitMapping timeUnitMapping = tmpLstTimeUnitMapping.get(0);
				areaSettingInfo.setTimeUnitMapping(timeUnitMapping);
				
				//Ret
				return areaSettingInfo;
			}).collect(Collectors.toList());
			
			return lstAreaSettingInfos;
		}).flatMap(lst->lst.stream()).collect(Collectors.toList());
		
		//Update to db
		areaSettingInfoDaoService.updateListAreaSettingInfo(lstUpdateAreaSettingInfos);
		return responseResult;
	}  
}