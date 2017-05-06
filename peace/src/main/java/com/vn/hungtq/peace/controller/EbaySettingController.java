package com.vn.hungtq.peace.controller;

import java.io.*;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vn.hungtq.peace.entity.EbayToken;
import com.vn.hungtq.peace.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.vn.hungtq.peace.common.AjaxResponseResult;
import com.vn.hungtq.peace.common.CommonUtils;
import com.vn.hungtq.peace.common.EbayServiceInfo;
import com.vn.hungtq.peace.common.Tuple;
import com.vn.hungtq.peace.dto.ItemInfomationDto;
import com.vn.hungtq.peace.dto.UserDto;
import com.vn.hungtq.peace.dto.UserTemplateDto;
import com.vn.hungtq.peace.ebay.FetchTokenCall;
import com.vn.hungtq.peace.ebay.GetSessionIDCall;
import com.vn.hungtq.peace.entity.ItemInfomation;
import com.vn.hungtq.peace.entity.UserTemplate;
import com.vn.hungtq.peace.service.ItemInfomationDaoService;
import com.vn.hungtq.peace.service.UserDaoService;
import com.vn.hungtq.peace.service.UserTemplateDaoService;

@Controller
@Scope("session")
public class EbaySettingController {
	private final Logger logger = LoggerFactory.getLogger(EbaySettingController.class);
	
	private final static String VIEW_LOGIN_EBAY = "/pages/G_SetEbayLogin";
	private final static String COOKIE_EBAY_SESSION = "PeaceEbaySessionId";
	private final static String COOKIE_EBAY_TOKEN = "PeaceEbayToken";
	
	@Autowired
	UserTemplateDaoService userTemplateDaoService;
	
	@Autowired
	ItemInfomationDaoService itemInfomationDaoService; 
	
	@Autowired
	EbayServiceInfo ebayServiceInfo; 
	
	@Autowired
	private UserDaoService userService;

	@Autowired
	private CommonService commonService;
	
	private Authentication authentication;

	@Autowired
	ServletContext context;
	
	@RequestMapping("/ListTemplate")
	public ModelAndView actionListTemplate(){
		return new ModelAndView("/pages/G_SetTemplate");
	}
	
	@RequestMapping("/CustomTemplate")
	public ModelAndView actionCustomTemplate(){
		return new ModelAndView("/pages/G_SetCustomTemplate");
	}
	
	@RequestMapping("/SetItemInfo")
	public ModelAndView actionSetItemInfo(){
		return new ModelAndView("/pages/G_SetItemInfo");
	}
	
	@RequestMapping("/SetShip")
	public ModelAndView actionSetShip(){
		return new ModelAndView("/pages/G_SetShip");
	}
	
	@RequestMapping("/SetBuyer")
	public ModelAndView actionSetBuyer(){
		return new ModelAndView("/pages/G_SetBuyer");
	} 
	
	@RequestMapping("/ListResearchAll")
	public ModelAndView listSearchAll(){ 
		return new ModelAndView("/pages/G_ListResearchAll");
	}
	
	@RequestMapping(value = "/LoadItemInfomation",method = RequestMethod.GET)
	public @ResponseBody ItemInfomationDto loadItemInfomation(HttpServletRequest request){ 
		authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDto user = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService);
		int userId = user.getId();
		
		ItemInfomation itemInfomation = itemInfomationDaoService.getItemInfomationByUserId(userId);
		if(itemInfomation!=null){
			return new ItemInfomationDto().copyFrom(itemInfomation);
		}
		return new ItemInfomationDto().withDefaultId();
	}

	@RequestMapping(value = "/UpdateDefaultTemplate/{id}",method = RequestMethod.GET)
	public void actionUpdateDefaultTemplate(@PathVariable("id") int id){
		userTemplateDaoService.updateDefaultTemplate(id);
	}

	@RequestMapping(value = "/DownloadTemplate",method = RequestMethod.GET)
	public void actionDownloadSampleTemplate(HttpServletResponse response){
		String templateFilePath = context.getRealPath("../resources/sampletemplate.html");
		Path tempPath = Paths.get(templateFilePath);
		if(Files.exists(tempPath)){
			String mimeType = URLConnection.guessContentTypeFromName(templateFilePath);
			if(mimeType==null){
				mimeType= "application/octet-stream";
			}
			response.setContentType(mimeType);

			File tempFile = tempPath.toFile();
			response.setHeader("Content-Disposition", String.format("inline; filename=\"" + tempFile.getName() +"\""));
			response.setContentLength((int)tempFile.length());
			try(final InputStream inputStream = new FileInputStream(tempFile)){
                FileCopyUtils.copy(inputStream,response.getOutputStream());
			} catch (FileNotFoundException e) {
                logger.debug("Exception when read template file :"+e.getMessage());
            } catch (IOException e) {
                logger.debug("Exception when read template file :"+e.getMessage());
            }
        }else{
			logger.debug("Cannot found template file in path:"+ templateFilePath);
		}
	}
	
	@RequestMapping(value ="/AddItemInfomation",method=RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> addNewItemInfomation(@RequestBody ItemInfomationDto itemInfomation,HttpServletRequest request){ 
		//Log
		logger.debug("Item infomation :"+itemInfomation.getInternationalBuyersNote());
		
		Tuple<Boolean, String> validateResult = CommonUtils.tryToValidateItemInfomation(itemInfomation);
		AjaxResponseResult<String> ajaxResult = new AjaxResponseResult<String>();
		if(validateResult.getFirst()){ 
			ItemInfomation dbItemInfomation = new ItemInfomation();
			dbItemInfomation.setAboutUs(itemInfomation.getAboutUs());
			dbItemInfomation.setInternationalBuyerNote(itemInfomation.getInternationalBuyersNote());
			dbItemInfomation.setPayment(itemInfomation.getPayment());
			dbItemInfomation.setTermsOfSale(itemInfomation.getTermsOfSale()); 
			
			authentication = SecurityContextHolder.getContext().getAuthentication();
			UserDto user = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService);
			int userId = user.getId();
			dbItemInfomation.setUserId(userId);
			if(itemInfomation.getItemId()!=-1){
				//Update
				dbItemInfomation.setId(itemInfomation.getItemId());
				itemInfomationDaoService.updateItemInfomation(dbItemInfomation);
			}else{
				//Insert new
				itemInfomationDaoService.addItemInfomation(dbItemInfomation);
			}
			
			ajaxResult.setStatus("OK");
			ajaxResult.setRecordId(dbItemInfomation.getId());
			
		}else{
			ajaxResult.setStatus("FAILED");
			ajaxResult.setCause(validateResult.getSecond());
		}
		return ajaxResult;
	}
	
	@RequestMapping(value ="/CustomTemplateUpload",method=RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> uploadTemplate(@RequestBody UserTemplateDto templateUploadDto,
											  HttpServletRequest request){ 
		Tuple<Boolean,String> validateResult = CommonUtils.tryToValidateUserTemplate(templateUploadDto);
		AjaxResponseResult<String> ajaxResult = new AjaxResponseResult<>();
		
		if(validateResult.getFirst()){
			if(templateUploadDto.getTemplateId()!=-1){
				UserTemplate userTemplate = userTemplateDaoService.getUserTemplateById(templateUploadDto.getTemplateId());
				if(userTemplate!=null){
					userTemplate.setTitle(templateUploadDto.getTitle());
					userTemplate.setHtmlCode(templateUploadDto.getHtmlCode());
					userTemplate.setImage(CommonUtils.convertStringByteArray(templateUploadDto.getBase64StringImage()));
					userTemplateDaoService.updateUserTemplate(userTemplate);
					ajaxResult.setStatus("OK");
					ajaxResult.setRecordId(userTemplate.getId());
					
				}else{
					ajaxResult.setStatus("FAILED");
					ajaxResult.setCause("Cannot found the exist user template! Update failed!");
				}
			}else{
				authentication = SecurityContextHolder.getContext().getAuthentication();
				UserDto user = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService);
				int userId = user.getId();
				
				UserTemplate userTemplate = new UserTemplate();
				userTemplate.setHtmlCode(templateUploadDto.getHtmlCode());
				userTemplate.setImage(CommonUtils.convertStringByteArray(templateUploadDto.getBase64StringImage()));
				userTemplate.setTitle(templateUploadDto.getTitle());  
				userTemplate.setUserId(userId);
				userTemplate.setIsDefault(false);
				userTemplateDaoService.saveUserTemplate(userTemplate);
				ajaxResult.setStatus("OK");
				ajaxResult.setRecordId(userTemplate.getId());
				logger.debug("Save user template success!");
			}
		}else{
			ajaxResult.setStatus("FAILED");
			ajaxResult.setCause("Insert new template failed! Cause by : \n" +validateResult.getSecond());
		}
		
		return ajaxResult;
	}
	
	@RequestMapping(value ="/LoadUserTemplate",method=RequestMethod.GET)
	public @ResponseBody List<List<UserTemplateDto>> loadUserTemplates(HttpServletRequest request){ 
		authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDto user = CommonUtils.getUserFromSession((User)authentication.getPrincipal(), userService);
		int userId = user.getId();
		List<UserTemplate> lstUserTemplate = userTemplateDaoService.getListTemplateOfUser(userId);
		List<UserTemplateDto> lstUserTemplateDtos = CommonUtils.convertToUserTemplateDto(lstUserTemplate);  
		return CommonUtils.divToListGroup(lstUserTemplateDtos, 5);
	}
	
	@RequestMapping("/SetEbayLogin") 
	public ModelAndView actionSetEbayLogin(@CookieValue(value = COOKIE_EBAY_SESSION, defaultValue = "") String cachedSessionID, HttpServletResponse response){
		ModelAndView model = new ModelAndView(VIEW_LOGIN_EBAY);
		boolean isProduction = false;
		// Create Url login base
		StringBuilder loginEbayUrl = new StringBuilder(); 
		
		if ("prod".equals(ebayServiceInfo.getEnvironment())) {
			isProduction = true;
			loginEbayUrl.append(ebayServiceInfo.getProdSigninURL());
		} else {
			loginEbayUrl.append(ebayServiceInfo.getSandboxSigninURL());
		}
		
		// Get sessionId from Ebay then add to URL
		GetSessionIDCall call = new GetSessionIDCall(isProduction, ebayServiceInfo);
		try {
			if (!StringUtils.isEmpty(cachedSessionID)) {
				String encodedSessIDString = URLEncoder.encode(cachedSessionID,"UTF-8");
	            // Create URL login with parameter
	            loginEbayUrl.append(ebayServiceInfo.getRuName());
	            loginEbayUrl.append("&SessID=");
	            loginEbayUrl.append(encodedSessIDString);
	            
	         // Assign url to model
	    		model.addObject("urlEbayLogin", loginEbayUrl.toString());
	    		return model;
	        }
			
            call.getSessionIDString(call.sendRequest(ebayServiceInfo.getRuName()));

            String errMsg = call.getLongErrorMessage();
            if (errMsg != null && errMsg.startsWith("RequestError")) {
                throw new Exception("Cannot get Session Id");
            } else {
                String newCachedSessionID = call.getRawSessionID();
                
                // Add session Id to cookie
                Cookie cookie = new Cookie(COOKIE_EBAY_SESSION, newCachedSessionID);
                response.addCookie(cookie);
                
                String encodedSessIDString =URLEncoder.encode(newCachedSessionID,"UTF-8");
                // Create URL login with parameter
                loginEbayUrl.append(ebayServiceInfo.getRuName());
                loginEbayUrl.append("&SessID=");
                loginEbayUrl.append(encodedSessIDString);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
		
		// Assign url to model
		model.addObject("urlEbayLogin", loginEbayUrl.toString());
		
		return model;
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value ="/GetEbayToken",method=RequestMethod.POST)
	public @ResponseBody AjaxResponseResult fetchTokenActionPerformed(
			@CookieValue(value = COOKIE_EBAY_SESSION, defaultValue = "") String cachedSessionID,
			HttpServletResponse response, HttpServletRequest request) {

		String user = request.getUserPrincipal().getName();
		com.vn.hungtq.peace.entity.User userLogin = userService.findBySSO(user);

		AjaxResponseResult ajaxResult = new AjaxResponseResult();
        FetchTokenCall call = null;
        
		boolean isProduction = false;
		
		// Create Url login base
		StringBuilder loginEbayUrl = new StringBuilder();
		if ("prod".equals(ebayServiceInfo.getEnvironment())) {
			isProduction = true;
			loginEbayUrl.append(ebayServiceInfo.getProdSigninURL());
		} else {
			loginEbayUrl.append(ebayServiceInfo.getSandboxSigninURL());
		}
		
		// Call Ebay get Token
        if (StringUtils.isEmpty(cachedSessionID)) {
        	ajaxResult.setStatus("FAILED");
        	ajaxResult.setMsg("You need to connect to eBay first");
        } else {
            call = new FetchTokenCall(isProduction, ebayServiceInfo);
            call.getUserTokenString(call.sendRequest(cachedSessionID));
            String errMsg = call.getLongErrorMessage();
            if (errMsg != null && errMsg.startsWith("RequestError")) {
            	
            	ajaxResult.setStatus("FAILED");
            	ajaxResult.setMsg(errMsg);
            	
            	// Remove ebay session
                Cookie cookie = new Cookie(COOKIE_EBAY_SESSION, null);
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            	
            } else {
            	ajaxResult.setStatus("OK");
            	ajaxResult.setMsg("Success");
            	System.out.println(call.getUsertoken());
            	// Add session Id to cookie
                Cookie cookie = new Cookie(COOKIE_EBAY_TOKEN, call.getUsertoken());

                logger.info("call.getUsertoken(): "+ call.getUsertoken());
                logger.info("call.getTokenExpirationTime(): "+call.getTokenExpirationTime());

                //Save token to database
				EbayToken ebayToken = new EbayToken();
				ebayToken.setUserId(userLogin.getId());
				ebayToken.setCreateDate(new Date());
				ebayToken.setExpiresDate(CommonUtils.getDateFromString(call.getTokenExpirationTime()));
				ebayToken.setToken(call.getUsertoken());
				EbayToken savedEbayToken = commonService.findByUser(userLogin.getId());
				if(isNotNull(savedEbayToken)){
					ebayToken.setTokenId(savedEbayToken.getTokenId());
					commonService.updateEbayToken(ebayToken);
				}
                response.addCookie(cookie);
            }
        }
        return ajaxResult;
    }

	private boolean isNotNull(EbayToken savedEbayToken) {
		return savedEbayToken != null ? true : false;
	}
} 