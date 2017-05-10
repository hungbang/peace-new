package com.vn.hungtq.peace.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.StringUtils;
import org.springframework.web.util.UriUtils;

import com.ebay.sdk.ApiContext;
import com.ebay.sdk.ApiCredential;
import com.ebay.sdk.call.GetCategoriesCall;
import com.ebay.soap.eBLBaseComponents.CategoryType;
import com.ebay.soap.eBLBaseComponents.DetailLevelCodeType;
import com.ebay.soap.eBLBaseComponents.ItemType;
import com.ebay.soap.eBLBaseComponents.SiteCodeType;
import com.vn.hungtq.peace.dto.EbayCategory;
import com.vn.hungtq.peace.dto.EbayProductSearch;
import com.vn.hungtq.peace.dto.ItemInfomationDto;
import com.vn.hungtq.peace.dto.UserDto;
import com.vn.hungtq.peace.dto.UserTemplateDto;
import com.vn.hungtq.peace.entity.Contact;
import com.vn.hungtq.peace.entity.User;
import com.vn.hungtq.peace.entity.UserTemplate;
import com.vn.hungtq.peace.service.UserDaoService;

/**
 * 
 * The CommonUtils class
 * Provide common util function for all module
 * 
 * @author napt2017  
 * 
 * **/
public class CommonUtils {  
	
	private static final Logger logger = LoggerFactory.getLogger(CommonUtils.class);
	private static final PasswordEncoder  bCryptPasswordEncoder= new BCryptPasswordEncoder();
	
	/**
	 * 
	 *  The buildMessgeContent method <br>
	 *  Build the content for contact email 
	 *  follow the contact as paramter
	 *  
	 *  @param  contact
	 *  @throws UnsupportedEncodingException
	 *  @return String 
	 *  @author napt2017 
	 * 
	 * 
	 * **/
	private static String buildMessageContent(Contact contact) throws UnsupportedEncodingException{
		StringBuilder sb = new StringBuilder();
		
		sb.append("<p>Hi Admin,</p>")
		.append("<p>My name is {0}. </p> ")
		.append("<p>Email: {1}. </p> ")
		.append("<p>Tel: {2}. </p> ")
		.append("<p>{3} </p>")
		.append("<p>{4} </p>")
		.append("<p>Thanks,Best Regard.</p>");
		
		return MessageFormat.format(sb.toString(), UriUtils.decode(contact.getName(),"UTF-8"),UriUtils.decode(contact.getEmail(),"UTF-8"),
									contact.getPhone(),UriUtils.decode(contact.getExhibitionCategory(),"UTF-8"),
									UriUtils.decode(contact.getDescribeContent(),"UTF-8"));
	}
	
	public static boolean isSameHash(String rawPassword,String hash){  
		return bCryptPasswordEncoder.matches(rawPassword, hash);
	}


	
	public static String encryptPassword(String rawPassword){
		return bCryptPasswordEncoder.encode(rawPassword);
	}

	public static Tuple<Boolean,String> sendEmail(String subject,String email,String messageContent,
												  final PeaceContactEmail peaceContactEmail,
												  final GmailConfiguration gmailConfiguration ){
		//Configuration properties
		logger.debug(gmailConfiguration.toString());

		Properties props = new Properties();
		props.put("mail.smtp.host",gmailConfiguration.getSmtpHost());
		props.put("mail.smtp.starttls.enable", gmailConfiguration.isStartttlsEnable());
		props.put("mail.smtp.socketFactory.port", gmailConfiguration.getSocketFactoryPort());
		props.put("mail.smtp.socketFactory.class",gmailConfiguration.getSocketFactoryClass());
		props.put("mail.smtp.auth", gmailConfiguration.isSmptAuth());
		props.put("mail.smtp.port",gmailConfiguration.getSmptPort());

		//Session login
		logger.debug("Start authentication....");
		logger.debug("UserName:"+peaceContactEmail.getEmail());
		logger.debug("PassWord:"+peaceContactEmail.getPassword());

		Session session = Session.getInstance(props, new javax.mail.Authenticator(){
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(peaceContactEmail.getEmail(),peaceContactEmail.getPassword());
			}
		});
		logger.debug("End authentication...");

		//Send email
		Message message = new MimeMessage(session);
		try{
			//Set from address
			message.setFrom(new InternetAddress(peaceContactEmail.getEmail()));

			//Set to address
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

			//Set subject
			message.setSubject(subject);
			message.setSentDate(new Date());

			//Multipart message
			Multipart	multiPart		= new MimeMultipart();

			//Set content for message
			message.setContent(multiPart);

			//Body part
			BodyPart 	bodyPart	    = null;

			//Set text content
			bodyPart	= new MimeBodyPart();
			multiPart.addBodyPart(bodyPart);
			message.setContent(messageContent,"text/html");

			Transport.send(message,message.getAllRecipients());
			return Tuple.make(true, "Send email success!!!");
		}
		catch (MessagingException  e){
			logger.debug("Exception when send contact email", e);
			return Tuple.make(false, e.getMessage());
		}
	}
	
	/**
	 * 
	 *  The sendEmailContact method
	 *  Send contact email to user follow the parameter
	 *  
	 *  @param subject
	 *  @param contact
	 *  @param peaceContactEmail
	 *  @param gmailConfiguration
	 *  
	 *  @author napt2017
	 *  @return Tuple<Boolean,String>  
	 * 
	 * **/
	public static Tuple<Boolean,String> sendEmailContact(String subject,Contact contact,
														final PeaceContactEmail peaceContactEmail,
														final GmailConfiguration gmailConfiguration ){
		try {
			String messageContent = CommonUtils.buildMessageContent(contact);
			String email = contact.getEmail();
			return  sendEmail(subject,email,messageContent,peaceContactEmail,gmailConfiguration);
		} catch (UnsupportedEncodingException e) {
			logger.debug("Exception when send contact email", e);
			return Tuple.make(false, e.getMessage());
		}
	} 
	
	public static UserDto getUserFromSession(org.springframework.security.core.userdetails.User userSSO, UserDaoService userService){
		UserDto userDto = new UserDto();
		
		// Get user from db
		User user = userService.findBySSO(userSSO.getUsername());
		
		if (user != null) {
			
			BeanUtils.copyProperties(user, userDto);
		}
		return userDto;
	}
	
	public static Tuple<Boolean,String> tryToValidateItemInfomation(ItemInfomationDto itemInfomation){
		//Implement later
		return Tuple.make(true, "OK");
	}
	
	public static Tuple<Boolean,String> tryToValidateUserTemplate(UserTemplateDto userTemplate){
		//Implement later
		return Tuple.make(true, "Vaild!!!");
	}
	
	public static byte[] convertStringByteArray(String rawString){
		if(rawString!=null){
			return rawString.getBytes();
		}
		return new byte[0];
	}
	
	public static ApiContext getApiContext(String authToken,EbayServiceInfo ebayServiceInfo){
		String soapUrl;
		if("prod".equals(ebayServiceInfo.getEnvironment())){
			soapUrl = ebayServiceInfo.getProdApiUrl();
		}else{
			soapUrl = ebayServiceInfo.getSandboxApiUrl();
		}
		
		ApiContext apiContext = new ApiContext();
		ApiCredential apiCred = apiContext.getApiCredential();
		apiCred.seteBayToken(authToken);
		apiContext.setApiServerUrl(soapUrl);
		apiContext.setSite(SiteCodeType.US);
		apiContext.setApiCredential(apiCred);
		return apiContext;		
	}
	
	public static List<UserTemplateDto> convertToUserTemplateDto(List<UserTemplate> lstOfUserTemplate){
		List<UserTemplateDto> lstUserTemplateDto = new ArrayList<UserTemplateDto>(lstOfUserTemplate.size());
		int index = 0;
		for(UserTemplate userTemplate:lstOfUserTemplate){
			UserTemplateDto userTemplateDto = new UserTemplateDto();
			userTemplateDto.setTitle(userTemplate.getTitle());
			userTemplateDto.setHtmlCode(userTemplate.getHtmlCode());
			userTemplateDto.setBase64StringImage(new String(userTemplate.getImage()));
			userTemplateDto.setIndex(index++);
			userTemplateDto.setTemplateId(userTemplate.getId());
			userTemplateDto.setDefault(userTemplate.getIsDefault()!=null?userTemplate.getIsDefault():false);
			
			lstUserTemplateDto.add(userTemplateDto);
		}
		
		return lstUserTemplateDto;
	}
	
	public static boolean getBooleanValue(Boolean bVal){
		return bVal!=null?bVal.booleanValue():false;
	}
	
	public static String buildQuestionMark(int length){
		if(length<=0){
			throw new IllegalArgumentException("Length must be greater than zero! Expected value :"+length);
		}
		
		StringBuilder sb = new StringBuilder("(");
		int stop = length-1;
		for(int loop = 0;loop<length;loop++){
			sb.append("?").append(loop==stop?"":",");
		}
		sb.append(")");
		return sb.toString();
	}
	
	/**
	 * 
	 *  The getHTMLContent method 
	 *  Send HttpRequest to webserver then get response 
	 *  as text plain which contain html ,css,javascript code of webpage
	 *  @param 	url
	 *  @author napt2017
	 *  @return String 
	 * 
	 * **/
	@SafeVarargs
	public static String getHTMLContent(String url,Tuple<String,String> ... requestProperties) {
		if (!"".equals(url) && url != null) {
			try {
				URL _url = new URL(url);
				URLConnection cnn = _url.openConnection();
				HttpURLConnection httpUrlConnection = (HttpURLConnection) cnn;
				if(requestProperties==null){
					cnn.addRequestProperty(
					"User-Agent",
					"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36"); 
				} 
				
				httpUrlConnection.setRequestMethod("GET");
				httpUrlConnection.setDoInput(true);
				httpUrlConnection.setDoOutput(true);

				try (final InputStream in = cnn.getInputStream();
					 final InputStreamReader inRead = new InputStreamReader(in,"UTF-8");
					 final BufferedReader bRead = new BufferedReader(inRead)) {
					StringBuilder sb = new StringBuilder();
					String line;
					while ((line = bRead.readLine()) != null) {
						sb.append(line);
					}
					return sb.toString();
				}
			} catch (MalformedURLException ex) {
				logger.debug("Get html content error with cause :"+ex.getMessage());
			} catch (IOException ex) {
				logger.debug("Get html content error with cause :"+ex.getMessage());
			}  
		}

		return "";
	}
	
	public static synchronized List<EbayProductSearch> convertToEbayProductSearch(ItemType [] itemTypes){
		if(itemTypes!=null && itemTypes.length>0){
			List<EbayProductSearch> lstEbayProductSearch = new ArrayList<EbayProductSearch>(itemTypes.length);
			for(ItemType it: itemTypes){
				String title = it.getTitle();
				String currency = it.getCurrency()!=null?it.getCurrency().name():"";
				String endTime = it.getListingDetails()!=null?CommonUtils.getDateStringFromCalendar(it.getListingDetails().getEndTime()):"";
				String listPrice = it.getSellingStatus()!=null?it.getSellingStatus().getCurrentPrice().getValue()+"":"";
				String purchaser = it.getPartnerName();
				String edit= it.getEBayNotes();
				String end = "__Unmapped__";
				String reListing = "__Unmapped";
				String error = it.getDescription();
				
				EbayProductSearch ebayProductSearch = new EbayProductSearch(title, endTime, listPrice, currency, purchaser, edit, end, reListing, error);
				lstEbayProductSearch.add(ebayProductSearch);
			}
			return lstEbayProductSearch;
		}
		return Collections.emptyList();
	}
	
	public static String getDateStringFromCalendar(Calendar cld){
		if(cld!=null){
			Date date = cld.getTime();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return sdf.format(date);
		}
		return "";
	}
	
	
	public static Tuple<Boolean,String> tryToValidateContactModel(Contact contact){
		return Tuple.make(true, "Ok");
	}
	
	public static String buildEbayServiceUrl(String keyword,EbayServiceInfo ebayServiceInfomation){
		return MessageFormat.format(ebayServiceInfomation.getServiceUrl(), ebayServiceInfomation.getAppid(),keyword);
	}
	
	public static String buildYahooServiceUrl(String keyword,YahooServiceInfo yahooServiceInfomation){
		return MessageFormat.format(yahooServiceInfomation.getServiceUrl(), yahooServiceInfomation.getAppid(),keyword);
	}

	public static String buildYahooAuctionServiceUrl(String keyword,YahooServiceInfo yahooServiceInfomation){
		return MessageFormat.format(yahooServiceInfomation.getServiceAuctionUrl(), yahooServiceInfomation.getAppid(),keyword);
	}
	
	/**
	 * 
	 *  The buildAmazonServiceUrl method
	 *  Create the amazon webservice call url via keyword
	 *  
	 *  @param keyWord
	 *  @author napt2017
	 *  @return String 
	 * 
	 * **/
	public static String buildAmazonServiceUrl(String keyWord,AmazonServiceInfo amazonServiceInfo) { 
	     
		 /*
         * Set up the signed requests helper 
         */
        SignedRequestsHelper helper;
        try {
            helper = SignedRequestsHelper.getInstance(amazonServiceInfo.getEndPoint(), 
								            		  amazonServiceInfo.getAwsAccessKeyId(), 
								            		  amazonServiceInfo.getAwsSecretKey());
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
        
        String requestUrl = null; 

        Map<String, String> params = new HashMap<String, String>();

        params.put("Service", "AWSECommerceService");
        params.put("Operation", "ItemSearch");
        params.put("AWSAccessKeyId", amazonServiceInfo.getAwsSecretKey());
        params.put("AssociateTag", "guen-22");
        params.put("SearchIndex", "All");
        params.put("Keywords", keyWord);

        requestUrl = helper.sign(params);
        
        return requestUrl;
	}
	
	/**
	 * Get List category from Ebay
	 * @param apiContext
	 * @param levelLimit default 0 is load all
	 * @return
	 */
	public static Tuple<Boolean,List<EbayCategory>> getListCategories(ApiContext apiContext, int levelLimit, String categoryId){
		GetCategoriesCall gCategoriesCall = new GetCategoriesCall(apiContext);
		gCategoriesCall.setDetailLevel(new DetailLevelCodeType []{
				DetailLevelCodeType.RETURN_ALL
		});
		gCategoriesCall.setViewAllNodes(true);
		
		if (levelLimit != 0) {
			gCategoriesCall.setLevelLimit(levelLimit);
		}
		
		if (!StringUtils.isEmpty(categoryId) && !"0".equals(categoryId)) {
			gCategoriesCall.setParentCategories(new String[]{categoryId});
		}
		
		
		try {
			CategoryType [] categories = gCategoriesCall.getCategories();
			List<EbayCategory> lstEbayCategories = new ArrayList<EbayCategory>();
			for(CategoryType ct : categories){
				
				// Loai phan tu dau tien
				if (ct.getCategoryLevel()+1 == levelLimit) {
					continue;
				}
				
				int id 						= Integer.valueOf(ct.getCategoryID());
				String name 				= ct.getCategoryName();
				int parentId 				= Integer.valueOf(ct.getCategoryParentID(0));
				int categoryLevel 			= ct.getCategoryLevel();
				Boolean isBestOfferEnable 	= (ct.isBestOfferEnabled() == null ) ? Boolean.FALSE : ct.isBestOfferEnabled();
				Boolean isAutoPayEnable 	= (ct.isAutoPayEnabled() == null ) ? Boolean.FALSE : ct.isAutoPayEnabled();
				Boolean leafCategory 	= (ct.isLeafCategory() == null ) ? Boolean.FALSE : ct.isLeafCategory();
				
				EbayCategory ebayCategory = new EbayCategory(id, parentId, name, categoryLevel, isBestOfferEnable, isAutoPayEnable, leafCategory);
				lstEbayCategories.add(ebayCategory); 
			}
			return Tuple.make(true, lstEbayCategories);
		} catch (Exception e) {
			e.printStackTrace();
			return Tuple.make(false, null);
		}
	}
	
	public static Tuple<Boolean,List<String>> getAccountInfomation(ApiContext apiContext){
		return null;
	}
	
	/**
	 * 
	 *  The divToListGroup method
	 *  Div the list of item to list of group item
	 *  follow the parameter 
	 *  
	 *  @param groupCount
	 *  			The size of sub group
	 *  @return List<List<T>> 
	 *  			The list of list sub
	 * 
	 * 
	 * **/
	public static <T>List<List<T>> divToListGroup(List<T> listOfType,int groupCount){
		int sizeOfList = listOfType.size();
		if(sizeOfList>groupCount){
			List<List<T>> retList = new ArrayList<List<T>>();
			List<T> tempList = new ArrayList<T>(groupCount);
			int count = 0;
			int processed =0;
			for(T item :listOfType){
				tempList.add(item);
				count++;
				if(count==groupCount){
					retList.add(tempList);
					tempList = new ArrayList<T>(groupCount);
					processed+=count;
					count=0;
				}
			}
			
			if(processed<sizeOfList){
				tempList = new ArrayList<>(sizeOfList-processed);
				for(int lostIndex=processed;lostIndex<sizeOfList;lostIndex++){
					tempList.add(listOfType.get(lostIndex));
				}
				
				retList.add(tempList);
			}
			
			return retList;
		}
		
		return Arrays.asList(listOfType);
	} 
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
		//Must have this to resolve ${}
		return new PropertySourcesPlaceholderConfigurer();
	}

    public static Date getDateFromString(String tokenExpirationTime) {
		Instant instant = Instant.parse(tokenExpirationTime);
//		LocalDateTime result = LocalDateTime.ofInstant(instant, ZoneId.of(ZoneOffset.UTC.getId()));
		Date output = Date.from(instant);
		return output;
    }
}
