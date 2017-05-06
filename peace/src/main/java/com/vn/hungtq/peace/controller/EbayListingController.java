package com.vn.hungtq.peace.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import jdk.nashorn.internal.runtime.URIUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ebay.sdk.ApiContext;
import com.ebay.sdk.call.AddItemCall;
import com.ebay.sdk.call.GetCategorySpecificsCall;
import com.ebay.sdk.util.eBayUtil;
import com.ebay.soap.eBLBaseComponents.AmountType;
import com.ebay.soap.eBLBaseComponents.BuyerPaymentMethodCodeType;
import com.ebay.soap.eBLBaseComponents.CategoryType;
import com.ebay.soap.eBLBaseComponents.CountryCodeType;
import com.ebay.soap.eBLBaseComponents.CurrencyCodeType;
import com.ebay.soap.eBLBaseComponents.FeesType;
import com.ebay.soap.eBLBaseComponents.ItemType;
import com.ebay.soap.eBLBaseComponents.ListingTypeCodeType;
import com.ebay.soap.eBLBaseComponents.NameValueListArrayType;
import com.ebay.soap.eBLBaseComponents.NameValueListType;
import com.ebay.soap.eBLBaseComponents.PictureDetailsType;
import com.ebay.soap.eBLBaseComponents.RecommendationsType;
import com.ebay.soap.eBLBaseComponents.ReturnPolicyType;
import com.ebay.soap.eBLBaseComponents.ShippingDetailsType;
import com.ebay.soap.eBLBaseComponents.ShippingServiceOptionsType;
import com.ebay.soap.eBLBaseComponents.ShippingTypeCodeType;
import com.vn.hungtq.peace.common.AjaxResponseResult;
import com.vn.hungtq.peace.common.CommonUtils;
import com.vn.hungtq.peace.common.EbayServiceInfo;
import com.vn.hungtq.peace.common.Tuple;
import com.vn.hungtq.peace.dto.EbayCategory;
import com.vn.hungtq.peace.dto.EbayItemDto;
import com.vn.hungtq.peace.entity.ItemInfomation;
import com.vn.hungtq.peace.entity.User;
import com.vn.hungtq.peace.service.ItemInfomationDaoService;
import com.vn.hungtq.peace.service.UserDaoService;
import com.vn.hungtq.peace.service.UserTemplateDaoService;
import org.springframework.web.util.UriUtils;

@Controller
public class EbayListingController {

	private final Logger logger = LoggerFactory.getLogger(EbayListingController.class);



	@Autowired
	EbayServiceInfo ebayServiceInfo;
	
	@Autowired
	UserDaoService userDaoService;
	
	@Autowired
	UserTemplateDaoService userTemplateDaoService;
	
	@Autowired
	ItemInfomationDaoService itemInfomationDaoService;
	
	private final static String COOKIE_EBAY_TOKEN = "PeaceEbayToken";
	
	@RequestMapping(value="/Sell",method= RequestMethod.GET)
	public ModelAndView sell(){
		return new ModelAndView("pages/G_Sell");
	}
	
	@RequestMapping(value="/SellDetail",method= RequestMethod.GET)
	public ModelAndView sellDetail(){
		return new ModelAndView("pages/G_SellDetail");
	}
	
	@RequestMapping(value="/AddItem",method= RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> addItem(@RequestBody EbayItemDto ebayItemDto ,@CookieValue(value=COOKIE_EBAY_TOKEN ,defaultValue="") String ebayToken){
		AjaxResponseResult<String> responseResult = new AjaxResponseResult<String>();
		if (ebayToken == null) {
			responseResult.setStatus("FAILED");
			responseResult.setCause("Login Ebay First!");
		}
		try {
			ApiContext ctx = CommonUtils.getApiContext(ebayToken, ebayServiceInfo);
			AddItemCall api = new AddItemCall(ctx);
			ItemType item = buildItemFromDto(ebayItemDto);
			api.setItem(item);
			FeesType fees = api.addItem();
			double listingFee = eBayUtil.findFeeByName(fees.getFee(), "ListingFee").getFee().getValue();
			responseResult.setMsg("Add item success with id:"+item.getItemID());
		} catch (Exception e) {
			e.printStackTrace();
 			responseResult.setStatus("FAILED");
			responseResult.setCause(e.getMessage());
		}
		
		return responseResult;
	} 
	
	/**
	 * Get Category Ebay
	 * @param ebayToken
	 * @return
	 */
	@RequestMapping(value="/GetCategory",method= RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<List<EbayCategory>> getCategory(@RequestBody EbayCategory ebayCategory, @CookieValue(value=COOKIE_EBAY_TOKEN ,defaultValue="") String ebayToken){
		AjaxResponseResult<List<EbayCategory>> responseResult = new AjaxResponseResult<List<EbayCategory>>();
		logger.info("ebayToken: "+ ebayToken);

		if(StringUtils.isEmpty(ebayToken)){
			responseResult.setStatus("FAILED");
			responseResult.setCause("You must login to ebay site to init the ebay token");
		}else{    
			//Get api context
			ApiContext apiContext = CommonUtils.getApiContext(ebayToken, ebayServiceInfo);
			try {
				
				Tuple<Boolean,List<EbayCategory>> tupleCategory = null;
				if (ebayCategory.getId() == 0) {
					tupleCategory = CommonUtils.getListCategories(apiContext, ebayCategory.getCategoryLevel(), null);
				} else {
					tupleCategory = CommonUtils.getListCategories(apiContext, ebayCategory.getCategoryLevel(), String.valueOf(ebayCategory.getId()));
				}
				
				if (Boolean.TRUE == tupleCategory.getFirst() ) {
					responseResult.setExtraData(tupleCategory.getSecond());
				}
			} catch (Exception e) { 
				responseResult.setStatus("FAILED");
				responseResult.setCause(e.getMessage());
			} 
		}
		
		return responseResult;
	}
	
	/**
	 * Get Data template
	 * @param ebayToken
	 * @return
	 */
	@RequestMapping(value="/GetDataTemplate",method= RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<EbayItemDto> getDataTemplate(@RequestBody EbayItemDto itemDto){
		AjaxResponseResult<EbayItemDto> responseResult = new AjaxResponseResult<EbayItemDto>();
		
		// Get user sso
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		org.springframework.security.core.userdetails.User userSSO = (org.springframework.security.core.userdetails.User) authentication.getPrincipal();
		
		// Get user from db
		User user = userDaoService.findBySSO(userSSO.getUsername());
		// Description
		String htmlCode = userTemplateDaoService.getUserTemplateById(user.getId()).getHtmlCode();
		try {
			htmlCode  = UriUtils.decode(htmlCode,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		ItemInfomation itemInfomation = itemInfomationDaoService.getItemInfomationByUserId(user.getId());
		htmlCode = htmlCode.replaceAll("<!---- Title ---->", itemDto.getTitle());
		htmlCode = htmlCode.replaceAll("<!---- Description ---->", itemDto.getDescription());
		// con thieu xu ly cho block shipping
		htmlCode = htmlCode.replaceAll("<!---- Term of Sale ---->", itemInfomation.getTermsOfSale());
		htmlCode = htmlCode.replaceAll("<!---- International Buyers - Please Note ---->", itemInfomation.getInternationalBuyerNote());
		htmlCode = htmlCode.replaceAll("<!---- About Us ---->", itemInfomation.getAboutUs());
		htmlCode = htmlCode.replaceAll("<!---- Payment ---->",itemInfomation.getPayment());
		htmlCode = htmlCode.replaceAll("<!---- shipping ---->","Free shipping!");
		String img = "<img src='"+itemDto.getImageUrl()+"' />";
		htmlCode = htmlCode.replaceAll("<!---- Photo ---->", img);
		itemDto.setDescription(htmlCode);
		responseResult.setStatus("OK");
		responseResult.setExtraData(itemDto);
		return responseResult;
	}
	
	
	/**
	 * Get Category Ebay
	 * @param ebayToken
	 * @return
	 */
	@RequestMapping(value="/GetCategorySpecifics",method= RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<RecommendationsType[]> getCategorySpecifics(HttpServletRequest request, @CookieValue(value=COOKIE_EBAY_TOKEN ,defaultValue="") String ebayToken){
		AjaxResponseResult<RecommendationsType[]> responseResult = new AjaxResponseResult<RecommendationsType[]>();
		String categoryId = request.getParameter("categoryId");
		if(StringUtils.isEmpty(ebayToken)){
			responseResult.setStatus("FAILED");
			responseResult.setCause("You must login to ebay site to init the ebay token");
		}else{    
			//Get api context
			ApiContext apiContext = CommonUtils.getApiContext(ebayToken, ebayServiceInfo);
			try {
				GetCategorySpecificsCall getCategorySpecificsCall = new GetCategorySpecificsCall(apiContext);
				String[] categoryIds = {categoryId};
				getCategorySpecificsCall.setCategoryID(categoryIds);
				
				RecommendationsType[] recommendationsType = getCategorySpecificsCall.getCategorySpecifics();
				responseResult.setStatus("OK");
				responseResult.setExtraData(recommendationsType);
			} catch (Exception e) { 
				responseResult.setStatus("FAILED");
				responseResult.setCause(e.getMessage());
			} 
		}
		
		return responseResult;
	}
	
	/**
	 * Fill data to model Item
	 * @param itemDto
	 * @return
	 */
	private ItemType buildItemFromDto(EbayItemDto itemDto){
		ItemType itemType = new ItemType();
		if (itemDto != null) {
			
			// Get user sso
			final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			org.springframework.security.core.userdetails.User userSSO = (org.springframework.security.core.userdetails.User) authentication.getPrincipal();
			
			// Get user from db
			User user = userDaoService.findBySSO(userSSO.getUsername());
			
			BeanUtils.copyProperties(itemDto, itemType);
			
			// Category Id
			CategoryType categoryType = new CategoryType();
			categoryType.setCategoryID(itemDto.getCategoryId());
			itemType.setPrimaryCategory(categoryType);
			
			// Location
			itemType.setPostalCode("95125");
			
			// Condition
			itemType.setConditionID(Integer.valueOf(itemDto.getConditionID()));
			
			// Description
			String htmlCode = userTemplateDaoService.getUserTemplateById(user.getId()).getHtmlCode();
//			htmlCode = StringEscapeUtils.unescapeHtml3(htmlCode);
			ItemInfomation itemInfomation = itemInfomationDaoService.getItemInfomationByUserId(user.getId());
			htmlCode = htmlCode.replaceAll("<!---- Title ---->", itemDto.getTitle());
			htmlCode = htmlCode.replaceAll("<!---- Description ---->", itemDto.getDescription());
			htmlCode = htmlCode.replaceAll("<!---- PaymentContent ---->", itemInfomation.getPayment());
			htmlCode = htmlCode.replaceAll("<!---- TermOfSaleContent ---->", itemInfomation.getTermsOfSale());
			htmlCode = htmlCode.replaceAll("<!---- InternationalBuyersContent ---->", itemInfomation.getInternationalBuyerNote());
			htmlCode = htmlCode.replaceAll("<!---- AboutUsContent ---->", itemInfomation.getAboutUs());
			
			String img = "<img src='"+itemDto.getImageUrl()+"' />";
			htmlCode = htmlCode.replaceAll("<!---- Photo ---->", img);
			StringBuilder description = new StringBuilder();
			description.append("<![CDATA[");
			description.append(htmlCode);
			description.append("]]>");
			itemType.setDescription(description.toString());
			
			
			// Picture
			PictureDetailsType pictureDetailsType = new PictureDetailsType();
			pictureDetailsType.setPictureURL(new String[] {itemDto.getImageUrl()});
			itemType.setPictureDetails(pictureDetailsType);
			
			if (itemDto.getNameValueListTypes() != null) {
				NameValueListArrayType paramNameValueListArrayType = new NameValueListArrayType();
				paramNameValueListArrayType.setNameValueList (itemDto.getNameValueListTypes().toArray(new NameValueListType[itemDto.getNameValueListTypes().size()]));
				
				itemType.setItemSpecifics(paramNameValueListArrayType);
			}
			
			itemType.setCountry(CountryCodeType.valueOf(itemDto.getCountry()));
			itemType.setListingType(ListingTypeCodeType.valueOf(itemDto.getRadListingType()));
			
			
			
			if(itemDto.getStartPrice() != null) {
				AmountType amount = new AmountType();
				amount.setValue(Double.valueOf(itemDto.getStartPrice()));
				itemType.setStartPrice(amount);
			}
			
			if(itemDto.getBuyItNow() != null) {
				AmountType amount = new AmountType();
				amount.setValue(Double.valueOf(itemDto.getBuyItNow()));
				itemType.setBuyItNowPrice(amount);
			}
			
			itemType.setListingDuration(itemDto.getDuration());
			
			itemType.setCurrency(CurrencyCodeType.USD);
			
			itemType.setDispatchTimeMax(3);
			
			// Payment
			itemType.setPaymentMethods(new BuyerPaymentMethodCodeType[]{BuyerPaymentMethodCodeType.PAY_PAL});
			itemType.setPayPalEmailAddress("quanghung.aptech.89@gmail.com");
			
			// Return Policy
			ReturnPolicyType returnPolicyType = new ReturnPolicyType();
			returnPolicyType.setReturnsAcceptedOption("ReturnsAccepted");
			returnPolicyType.setRefundOption("MoneyBack");
			returnPolicyType.setReturnsWithinOption("Days_30");
			returnPolicyType.setDescription("If you are not satisfied, return the book for refund.");
			returnPolicyType.setShippingCostPaidByOption("Buyer");
			itemType.setReturnPolicy(returnPolicyType);
			 
			// Set shipping
			ShippingDetailsType shippingDetailsType = new ShippingDetailsType();
			shippingDetailsType.setShippingType(ShippingTypeCodeType.FLAT);
			  
			ShippingServiceOptionsType shippingServiceOptionsType = new ShippingServiceOptionsType();
			shippingServiceOptionsType.setShippingServicePriority(1);
			shippingServiceOptionsType.setShippingService("USPSMedia");
			AmountType amount = new AmountType();
			amount.setValue(Double.valueOf("2.5"));
			shippingServiceOptionsType.setShippingServiceCost(amount);
			
			ShippingServiceOptionsType[] shippingServiceOptionsTypes = {shippingServiceOptionsType};
			shippingDetailsType.setShippingServiceOptions(shippingServiceOptionsTypes);
			itemType.setShippingDetails(shippingDetailsType);
			
			
			
		}
		
		
		return itemType;
	}
}
