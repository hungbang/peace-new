package com.vn.hungtq.peace.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.vn.hungtq.peace.common.*;
import com.vn.hungtq.peace.dto.*;
import com.vn.hungtq.peace.entity.AccountSetting;
import com.vn.hungtq.peace.entity.StockRegistorEntity;
import com.vn.hungtq.peace.entity.User;
import com.vn.hungtq.peace.service.AccountSettingDaoService;
import com.vn.hungtq.peace.service.StockRegistorDaoService;
import com.vn.hungtq.peace.service.UserDaoService;
import org.apache.commons.collections.map.HashedMap;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriUtils;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.MessageFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class MainController {
	private final Logger logger = LoggerFactory.getLogger(MainController.class);

	private static final String VIEW_INDEX = "/pages/index";
	private static final String VIEW_HOME = "/pages/G_Home";
	private static final String VIEW_ACCESS_DENIED= "/pages/accessDenied";
	
	@Autowired
	AmazonServiceInfo amazonServiceInfo;

	@Autowired
	private UserDaoService userService;
	
	@Autowired
	private RakutenServiceInfo rakutenServiceInfomation;
	
	@Autowired
	private YahooServiceInfo yahooServiceInfo;
	
	@Autowired
	private EbayServiceInfo ebayServiceInfomation;

	@Autowired
	ServletContext context;
	
	@Autowired
	MessageSource messageSource;
	
	@Autowired
	AccountSettingDaoService accountSettingDaoService;
	
	@Autowired
	StockRegistorDaoService stockRegistorDaoService;
	
	@RequestMapping(value ="/", method = RequestMethod.GET)
	public String welcome(Locale locale, ModelMap model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		// Get user sso
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication.getPrincipal() instanceof String) {
			return "redirect:/login";
		}
		org.springframework.security.core.userdetails.User userSSO = (org.springframework.security.core.userdetails.User) authentication.getPrincipal();
		
		// Get user from db
		User user = userService.findBySSO(userSSO.getUsername());
		
		// Assign to Dto
		UserDto userDto = new UserDto();
		userDto.setId(user.getId());
		userDto.setUsername(user.getUsername());
		model.addAttribute("formLogin", userDto);
		
		// Spring uses InternalResourceViewResolver and return back index.jsp
		return VIEW_HOME;

	}

	@RequestMapping(value="/Manual", method = RequestMethod.GET)
	public void actionViewManual(HttpServletResponse response){
		try {
			byte [] documentInBytes = getManualDocument();
			streamReport(response, documentInBytes, "manual.pdf");
		} catch (IOException e) {
			logger.error("ERROR: "+ e.getMessage());
		}
	}

	protected void streamReport(HttpServletResponse response, byte[] data, String name)
			throws IOException {

		response.setContentType("application/pdf");
//		response.setHeader("Content-disposition", "attachment; filename=" + name);
		response.setContentLength(data.length);

		response.getOutputStream().write(data);
		response.getOutputStream().flush();
	}

	private byte [] getManualDocument() throws IOException {
		ClassLoader classLoader = getClass().getClassLoader();
		File file = new File(classLoader.getResource("manual.pdf").getFile());
//		String manualPdfFile = context.getRealPath("../resources/manual.pdf");
		return  Files.readAllBytes(file.toPath());
	}

	
	@RequestMapping("/StockRegistor")
	public ModelAndView actionGoToStockRegister(){
		return new ModelAndView("pages/G_StockRegistor");
	}
	
	@RequestMapping("/StockRegistor/{id}")
	public ModelAndView actionGoToStockRegister(@PathVariable("id") int id){
		ModelAndView mdv = new ModelAndView("pages/G_StockRegistor");
		mdv.addObject("stockId", id);
		return mdv;
	}
	
	@RequestMapping(value="/GetStockRegistor/{id}",method=RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<StockRegistorItem> actionGetStockRegistor(@PathVariable("id") int id){
		AjaxResponseResult<StockRegistorItem> ajaxResponse = new AjaxResponseResult<StockRegistorItem>();
		Optional<StockRegistorEntity> optStockEntity = stockRegistorDaoService.getStockRegistorById(id);
		optStockEntity.ifPresent(dbStockRegistor ->{
			StockRegistorItem stockRegistorItem = new StockRegistorItem(dbStockRegistor.getId(),
					 dbStockRegistor.getStoreName(),
					 dbStockRegistor.getProductName(),
					 dbStockRegistor.getVendorUrl(),
					 dbStockRegistor.getBuyPrice(),
					 dbStockRegistor.getLogicCheck(),
					 dbStockRegistor.getStock(),
					 dbStockRegistor.getNote(),dbStockRegistor.getStockWord());
			ajaxResponse.setExtraData(stockRegistorItem);
		});
		ajaxResponse.setMsg("OK");
		return ajaxResponse;
	}
	
	@RequestMapping(value ="/UpdateStockRegistor",method=RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> actionUpdateStockRegistor(@RequestBody StockRegistorItem stockRegistorItem){
		AjaxResponseResult<String> ajaxResponse = new AjaxResponseResult<String>();
		
		//Convert
		StockRegistorEntity stockRegistorEntity = new StockRegistorEntity();
		stockRegistorEntity.setStoreName(stockRegistorItem.getStoreName());
		stockRegistorEntity.setProductName(stockRegistorItem.getProductName());
		stockRegistorEntity.setVendorUrl(stockRegistorItem.getVendorURL());
		stockRegistorEntity.setBuyPrice(stockRegistorItem.getBuyPrice());
		stockRegistorEntity.setLogicCheck(stockRegistorItem.getLogicCheck());
		stockRegistorEntity.setStock(stockRegistorItem.getStock());
		stockRegistorEntity.setNote(stockRegistorItem.getNote());
		stockRegistorEntity.setStockWord(stockRegistorItem.getStockWord());
		stockRegistorEntity.setId(stockRegistorItem.getId());
		
		//Update
		stockRegistorDaoService.updateStockRegistor(stockRegistorEntity);
		ajaxResponse.setStatus("OK");
		
		return ajaxResponse;
	}
	
	@RequestMapping("/StockList")
	public ModelAndView actionGoToStockList(){
		return new ModelAndView("pages/G_StockList");
	}
	
	@RequestMapping(value ="/LoadStockList",method=RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<List<StockRegistorItem>> actionLoadStockList(){
		AjaxResponseResult<List<StockRegistorItem>> ajaxResponse = new AjaxResponseResult<>();
		List<StockRegistorEntity> lstStockRegister =stockRegistorDaoService.getAllStockRegistor();
		List<StockRegistorItem> lstStockRegistorItem = lstStockRegister.stream().map(dbStockRegistor->{
			return new StockRegistorItem(dbStockRegistor.getId(),
										 dbStockRegistor.getStoreName(),
										 dbStockRegistor.getProductName(),
										 dbStockRegistor.getVendorUrl(),
										 dbStockRegistor.getBuyPrice(),
										 dbStockRegistor.getLogicCheck(),
										 dbStockRegistor.getStock(),
										 dbStockRegistor.getNote(),dbStockRegistor.getStockWord());
		}).collect(Collectors.toList()); 
		
		ajaxResponse.setExtraData(lstStockRegistorItem);
		return ajaxResponse;
	}
	
	@RequestMapping(value="/DeleteStocks")
	public @ResponseBody AjaxResponseResult<String> actionDeleteStocks(@RequestBody List<Integer> lstStockIds){
		AjaxResponseResult<String> ajaxResponse = new AjaxResponseResult<String>();
		stockRegistorDaoService.deleteStockRegistors(lstStockIds);
		ajaxResponse.setStatus("OK");
		return ajaxResponse;
	}
	
	@RequestMapping(value ="/AddStockRegistor",method=RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> actionAddStockRegistor(@RequestBody StockRegistorItem stockRegistorItem){
		AjaxResponseResult<String> ajaxResponse = new AjaxResponseResult<>();
		// Get user sso
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		org.springframework.security.core.userdetails.User userSSO = (org.springframework.security.core.userdetails.User) authentication.getPrincipal();

		// Get user from db
		User user = userService.findBySSO(userSSO.getUsername());

		//Convert
		StockRegistorEntity stockRegistorEntity = new StockRegistorEntity();
		stockRegistorEntity.setStoreName(stockRegistorItem.getStoreName());
		stockRegistorEntity.setProductName(stockRegistorItem.getProductName());
		stockRegistorEntity.setVendorUrl(stockRegistorItem.getVendorURL());
		stockRegistorEntity.setBuyPrice(stockRegistorItem.getBuyPrice());
		stockRegistorEntity.setLogicCheck(stockRegistorItem.getLogicCheck());
		stockRegistorEntity.setStock(stockRegistorItem.getStock());
		stockRegistorEntity.setNote(stockRegistorItem.getNote());
		stockRegistorEntity.setStockWord(stockRegistorItem.getStockWord());
		stockRegistorEntity.setUserId(user.getId());
		
		//Save
		stockRegistorDaoService.saveStockRegistor(stockRegistorEntity);
		ajaxResponse.setStatus("OK");
		
		return ajaxResponse;
	}
	
	
	/**
	 * This method handles login GET requests.
	 * If users is already logged-in and tries to goto login page again, will be redirected to list page.
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginPage(Locale locale, ModelMap model) {
		if (isCurrentAuthenticationAnonymous()) {
			UserDto userDto = new UserDto();
			model.addAttribute("formLogin", userDto);
			return VIEW_INDEX;
	    } else {
	    	return "redirect:/";  
	    }
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("formLogin") UserDto userDto,
			HttpServletRequest request,
			final RedirectAttributes redirectAttributes) {

		logger.debug("begin login: ", userDto.getUsername());

		User user = userService.findBySSO(userDto.getUsername());

		if (user != null) {
			userDto.setId(user.getId());
			request.getSession().setAttribute("user", userDto);
			return "redirect:/index";
		} else {
			redirectAttributes.addFlashAttribute("msg",
					"Username or password invalid!");
			redirectAttributes.addFlashAttribute("username",
					userDto.getUsername());
			return "redirect:/";
		}
	}
	
	@RequestMapping(value = { "/index" }, method = RequestMethod.GET)
	public String index(ModelMap model, HttpServletRequest request) {
		UserDto userDto = (UserDto) request.getSession().getAttribute("user");
		if (userDto == null) {
			return "redirect:/";
		}
		model.addAttribute("formLogin", userDto);
		// Spring uses InternalResourceViewResolver and return back index.jsp
		return VIEW_HOME;

	} 
	
	@RequestMapping("ContactUs")
	public ModelAndView contactUs(){
		return  new ModelAndView("/pages/G_Contract");
	}
	
	@RequestMapping("SetAccount")
	public ModelAndView setAccount(){
		return  new ModelAndView("/pages/G_SetAccount");
	}
	
	@RequestMapping(value ="/GetAccountSetting",method=RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<AccountSettingDto> getAccountSetting(){
		AjaxResponseResult<AccountSettingDto> responseResult = new AjaxResponseResult<AccountSettingDto>();
		responseResult.setStatus("Ok");
		
		//Default set record id 
		responseResult.setRecordId(-1);
		
		//Get user id
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDto user = CommonUtils.getUserFromSession((org.springframework.security.core.userdetails.User)authentication.getPrincipal(), userService);
		int userId = user.getId();
		
		Optional<AccountSetting> optionalOfAccountSetting = accountSettingDaoService.loadAccountSettingByUser(userId);
		optionalOfAccountSetting.ifPresent(ac->{
			AccountSettingDto asDto = new AccountSettingDto();
			asDto.setAmazonAccessKey(ac.getAmazonAccessKey());
			asDto.setAmazoneId(ac.getAmazoneId());
			asDto.setAmazonSecretKey(ac.getAmazonSecretKey());
			asDto.setIsDeliver(ac.getIsDeliver());
			asDto.setIsImmediateStettlement(ac.getIsImmediateStettlement());
			asDto.setPaypalEmail(ac.getPaypalEmail());
			asDto.setEmail(user.getEmail());
			asDto.setId(ac.getId());
			
			responseResult.setRecordId(ac.getId());
			responseResult.setExtraData(asDto);  
		}); 
		
		return responseResult;
	}
	
	@RequestMapping(value="ChangeUserPasswordEmail",method = RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> changeUserPasswordEmail(@RequestBody UserDto userDto){
		AjaxResponseResult<String> responseResult = new AjaxResponseResult<String>();
		responseResult.setStatus("OK");
		
		//Get current user from session
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDto user = CommonUtils.getUserFromSession((org.springframework.security.core.userdetails.User)authentication.getPrincipal(), userService);
		int userId = user.getId();
		
		//Encrypt password
		String encryptPassword = CommonUtils.encryptPassword(userDto.getPassword());
		
		//Load user from db
		User dbUser = userService.getUserById(userId);
		dbUser.setEmail(userDto.getEmail());
		dbUser.setPassword(encryptPassword);
		
		//Update
		userService.updateUser(dbUser);
		
		return responseResult;
	}
	
	@RequestMapping(value="SaveAccountSetting",method = RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> saveAccountSetting(@RequestBody AccountSettingDto accountSettingDto){
		AjaxResponseResult<String> responseResult = new AjaxResponseResult<String>();
		responseResult.setStatus("OK");
		AccountSetting acSetting ;
		//Get user id
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDto user = CommonUtils.getUserFromSession((org.springframework.security.core.userdetails.User)authentication.getPrincipal(), userService);
		int userId = user.getId();
				
		Optional<AccountSetting> optionalOfAccoutSetting = accountSettingDaoService.loadAccountSettingByUser(userId);
		if(optionalOfAccoutSetting.isPresent()){
			acSetting = optionalOfAccoutSetting.get();
			acSetting.setIsDeliver(accountSettingDto.getIsDeliver());
			
			//Update to db
			accountSettingDaoService.updateAccountSetting(acSetting);
		}else{
			//Convert data
			acSetting = new AccountSetting();
			acSetting.setIsDeliver(accountSettingDto.getIsDeliver());
			acSetting.setUserId(userId);
			
			//Save to db
			accountSettingDaoService.saveAccountSetting(acSetting);
		} 
		
		return responseResult;
	}

	@RequestMapping(value="saveAmazonSetting",method = RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> saveAmazonSetting(@RequestBody AccountSettingDto accountSettingDto){
		AjaxResponseResult<String> responseResult = new AjaxResponseResult<String>();
		responseResult.setStatus("OK");
		AccountSetting acSetting ;
		//Get user id
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDto user = CommonUtils.getUserFromSession((org.springframework.security.core.userdetails.User)authentication.getPrincipal(), userService);
		int userId = user.getId();

		Optional<AccountSetting> optionalOfAccoutSetting = accountSettingDaoService.loadAccountSettingByUser(userId);
		if(optionalOfAccoutSetting.isPresent()){
			acSetting = optionalOfAccoutSetting.get();
			acSetting.setAmazonAccessKey(accountSettingDto.getAmazonAccessKey());
			acSetting.setAmazoneId(accountSettingDto.getAmazoneId());
			acSetting.setAmazonSecretKey(accountSettingDto.getAmazonSecretKey());

			//Update to db
			accountSettingDaoService.updateAccountSetting(acSetting);
		}else{
			//Convert data
			acSetting = new AccountSetting();
			acSetting.setAmazonAccessKey(accountSettingDto.getAmazonAccessKey());
			acSetting.setAmazoneId(accountSettingDto.getAmazoneId());
			acSetting.setAmazonSecretKey(accountSettingDto.getAmazonSecretKey());
			acSetting.setUserId(userId);

			//Save to db
			accountSettingDaoService.saveAccountSetting(acSetting);
		}

		return responseResult;
	}

	@RequestMapping(value="savePaypalSetting",method = RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<String> savePaypalSetting(@RequestBody AccountSettingDto accountSettingDto){
		AjaxResponseResult<String> responseResult = new AjaxResponseResult<String>();
		responseResult.setStatus("OK");
		AccountSetting acSetting ;
		//Get user id
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDto user = CommonUtils.getUserFromSession((org.springframework.security.core.userdetails.User)authentication.getPrincipal(), userService);
		int userId = user.getId();

		Optional<AccountSetting> optionalOfAccoutSetting = accountSettingDaoService.loadAccountSettingByUser(userId);
		if(optionalOfAccoutSetting.isPresent()){
			acSetting = optionalOfAccoutSetting.get();
			acSetting.setIsImmediateStettlement(accountSettingDto.getIsImmediateStettlement());
			acSetting.setPaypalEmail(accountSettingDto.getPaypalEmail());

			//Update to db
			accountSettingDaoService.updateAccountSetting(acSetting);
		}else{
			//Convert data
			acSetting = new AccountSetting();
			acSetting.setIsImmediateStettlement(accountSettingDto.getIsImmediateStettlement());
			acSetting.setPaypalEmail(accountSettingDto.getPaypalEmail());
			acSetting.setUserId(userId);
			//Save to db
			accountSettingDaoService.saveAccountSetting(acSetting);
		}
		return responseResult;
	}
	
	@RequestMapping("AmazonSearch")
	public ModelAndView amazonSearchProduct(){
		return new ModelAndView("pages/G_AmazonSearch");
	}
	
	@RequestMapping(value ="SearchAmazonProductXml",method = RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<AmazonSearchResult> searchAmazonProductXml(@RequestBody ClientAmazonSearchDto clientAmazonSearchModel){
		AjaxResponseResult<AmazonSearchResult> result = new AjaxResponseResult<AmazonSearchResult>();
		String amazonSearchURL =  CommonUtils.buildAmazonServiceUrl(clientAmazonSearchModel.getSearchData(),amazonServiceInfo);
		AmazonSearchResult amzSearchResult = processAmazonSearchResult(amazonSearchURL);
		result.setStatus("OK");
		result.setExtraData(amzSearchResult);
		return result;
	}
	
	
	@RequestMapping(value ="SearchAmazonProduct",method = RequestMethod.POST)
	public @ResponseBody AjaxResponseResult<AmazonSearchResult> searchAmazonProduct(@RequestBody ClientAmazonSearchDto clientAmazonSearchModel){
		AjaxResponseResult<AmazonSearchResult> result = new AjaxResponseResult<AmazonSearchResult>();
		
		AmazonSearchEngine asEngine = new AmazonSearchEngine("page");
		Optional<AmazonSearchResult> optionSearchResult;
		if(clientAmazonSearchModel.isAsinSearch()){
			optionSearchResult = asEngine.searchByASIN(clientAmazonSearchModel.getSearchData());
		}else{
			if(clientAmazonSearchModel.getPage()!=1){
				asEngine.setKeyWord(clientAmazonSearchModel.getSearchData());
				asEngine.setTotalPage(clientAmazonSearchModel.getTotalPage());
				optionSearchResult = asEngine.goToPage(clientAmazonSearchModel.getPage());
			}else{
				System.out.println(clientAmazonSearchModel.getSearchData());
				optionSearchResult = asEngine.searchByKeyWord(clientAmazonSearchModel.getSearchData());
			}
		}
		
		if(optionSearchResult.isPresent()){
			AmazonSearchResult amzSearchResult = optionSearchResult.get();
			amzSearchResult.setCurrentPage(clientAmazonSearchModel.getPage()); 
			result.setExtraData(amzSearchResult);
			result.setStatus("OK");
		}else{
			result.setStatus("FAILED");
		}
		return result;
	}
	
	@RequestMapping(value ="/AmazoneGetServiceUrl/{keyword}",method=RequestMethod.GET)
	public @ResponseBody String amazoneGetServiceUrl(@PathVariable(value = "keyword") String keyword){
		String amazonSearchURL =  CommonUtils.buildAmazonServiceUrl(keyword,amazonServiceInfo); 
		return amazonSearchURL;
	} 
	
	@RequestMapping(value ="/EbayProductSearch/{keyword}",method=RequestMethod.GET)
	public @ResponseBody String ebaySearchProductByKeyword(@PathVariable(value = "keyword") String keyword){
		return getEbaySearchProductResult(keyword);
	}
	
	@RequestMapping(value ="/YahooProductSearch/{keyword}",method=RequestMethod.GET)
	public @ResponseBody String yahooSearchProductByKeyword(@PathVariable(value = "keyword") String keyword){
		String productSearchUrl = CommonUtils.buildYahooServiceUrl(keyword, yahooServiceInfo);
		logger.debug("yahoo appid:"+yahooServiceInfo.getAppid());
		logger.debug("The yahoo service search url :" +productSearchUrl);
		return CommonUtils.getHTMLContent(productSearchUrl);
	}

	@RequestMapping(value ="/YahooProductSearchV2/{keyword}",method=RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<List<YahooProductSearch>> yahooSearchProductByKeywordV2(@PathVariable(value = "keyword") String keyword){
		AjaxResponseResult<List<YahooProductSearch>> ajaxResponseResult = processYahooSearchV2(keyword);
		return  ajaxResponseResult;
	}

	@RequestMapping(value ="/YahooProductAuctionSearch/{keyword}",method=RequestMethod.GET)
	public @ResponseBody AjaxResponseResult<List<YahooProductAuctionSearch>> yahooSearchAuctionProductByKeyword(@PathVariable(value = "keyword") String keyword){
		AjaxResponseResult<List<YahooProductAuctionSearch>> ajaxResponseResult = processYahooAuctionSearch(keyword);
		return  ajaxResponseResult;
	}

	private AjaxResponseResult<List<YahooProductSearch>> processYahooSearchV2(String keyword) {
		AjaxResponseResult<List<YahooProductSearch>> ajaxResponseResult = new AjaxResponseResult<List<YahooProductSearch>>();
		String productSearchUrl = CommonUtils.buildYahooServiceUrl(keyword, yahooServiceInfo);
		logger.debug("yahoo appid:"+yahooServiceInfo.getAppid());
		logger.debug("The yahoo service search url :" +productSearchUrl);
		String xmlResponseContent =  CommonUtils.getHTMLContent(productSearchUrl);
		List<YahooProductSearch> yahooProductSearchList = convertToListYahooProductSearch(xmlResponseContent);
		ajaxResponseResult.setExtraData(yahooProductSearchList);
		return ajaxResponseResult;
	}

	private AjaxResponseResult<List<YahooProductAuctionSearch>> processYahooAuctionSearch(String keyword) {
		AjaxResponseResult<List<YahooProductAuctionSearch>> ajaxResponseResult = new AjaxResponseResult<List<YahooProductAuctionSearch>>();
		String productSearchUrl = CommonUtils.buildYahooAuctionServiceUrl(keyword, yahooServiceInfo);
		logger.debug("yahoo appid:"+yahooServiceInfo.getAppid());
		logger.debug("The yahoo service search url :" +productSearchUrl);
		String xmlResponseContent =  CommonUtils.getHTMLContent(productSearchUrl);
		List<YahooProductAuctionSearch> yahooProductAuctionSearchList = convertToListYahooAuctionProductSearch(xmlResponseContent);
		ajaxResponseResult.setExtraData(yahooProductAuctionSearchList);
		return ajaxResponseResult;
	}

	private List<YahooProductSearch> convertToListYahooProductSearch(String xmlContent){
		List<YahooProductSearch> yahooProductSearchList = new ArrayList<>();
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder db = dbf.newDocumentBuilder();
			try(InputStream inputStream = new ByteArrayInputStream(xmlContent.getBytes())){
				org.w3c.dom.Document doc = db.parse(inputStream);
				doc.getDocumentElement().normalize();
				System.out.println("Root element:"+doc.getDocumentElement().getNodeName());
				org.w3c.dom.NodeList hitTags = doc.getElementsByTagName("Hit");
				int length = hitTags.getLength();
				for (int i = 0; i < length; i++) {
					org.w3c.dom.Node hitTag = hitTags.item(i);
					if(hitTag.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE){
						YahooProductSearch yahooProductSearch = convertToYahooProductSearch(hitTag);
						yahooProductSearchList.add(yahooProductSearch);
					}
				}
			}
		} catch (ParserConfigurationException ex) {
			logger.debug(ex.getMessage());
		} catch (IOException ex) {
			logger.debug(ex.getMessage());
		} catch (org.xml.sax.SAXException ex) {
			logger.debug(ex.getMessage());
		}

		return  yahooProductSearchList;
	}

	private List<YahooProductAuctionSearch> convertToListYahooAuctionProductSearch(String xmlContent){
		List<YahooProductAuctionSearch> yahooProductAuctionSearchList = new ArrayList<>();
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder db = dbf.newDocumentBuilder();
			try(InputStream inputStream = new ByteArrayInputStream(xmlContent.getBytes())){
				org.w3c.dom.Document doc = db.parse(inputStream);
				doc.getDocumentElement().normalize();
				System.out.println("Root element:"+doc.getDocumentElement().getNodeName());
				org.w3c.dom.NodeList itemTags = doc.getElementsByTagName("Item");
				int length = itemTags.getLength();
				for (int i = 0; i < length; i++) {
					org.w3c.dom.Node itemTag = itemTags.item(i);
					if(itemTag.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE){
						YahooProductAuctionSearch yahooProductAuctionSearch = convertToYahooProductAuctionSearch(itemTag);
						yahooProductAuctionSearchList.add(yahooProductAuctionSearch);
					}
				}
			}
		} catch (ParserConfigurationException ex) {
			logger.debug(ex.getMessage());
		} catch (IOException ex) {
			logger.debug(ex.getMessage());
		} catch (org.xml.sax.SAXException ex) {
			logger.debug(ex.getMessage());
		}

		return  yahooProductAuctionSearchList;
	}



	private  YahooProductSearch convertToYahooProductSearch(org.w3c.dom.Node hitTag){
		YahooProductSearch yahooProductSearch = new YahooProductSearch();
		yahooProductSearch.setSearchSite("yahoo");

		org.w3c.dom.Element element = (org.w3c.dom.Element)hitTag;
		yahooProductSearch.setItemId(element.getAttribute("index"));
		yahooProductSearch.setProductName(element.getElementsByTagName("Name").item(0).getTextContent());
		yahooProductSearch.setDescription(element.getElementsByTagName("Description").item(0).getTextContent());
		yahooProductSearch.setExhibition(element.getElementsByTagName("Url").item(0).getTextContent());

		org.w3c.dom.Element imageElement = (org.w3c.dom.Element)element.getElementsByTagName("Image").item(0);
		if(imageElement.getElementsByTagName("Small").getLength() >0){
			yahooProductSearch.setImage(imageElement.getElementsByTagName("Small").item(0).getTextContent());
		}else{
			if(imageElement.getElementsByTagName("Medium").getLength() >0){
				yahooProductSearch.setImage(imageElement.getElementsByTagName("Medium").item(0).getTextContent());
			}
		}

		org.w3c.dom.Element priceElement = (org.w3c.dom.Element)element.getElementsByTagName("PriceLabel").item(0);
		yahooProductSearch.setPrice(priceElement.getElementsByTagName("DefaultPrice").item(0).getTextContent());
		return  yahooProductSearch;
	}

	private  YahooProductAuctionSearch convertToYahooProductAuctionSearch(org.w3c.dom.Node itemTag){
		YahooProductAuctionSearch yahooProductAuctionSearch = new YahooProductAuctionSearch();

		org.w3c.dom.Element element = (org.w3c.dom.Element)itemTag;
		yahooProductAuctionSearch.setAuctionID(element.getElementsByTagName("AuctionID").item(0).getTextContent());
		yahooProductAuctionSearch.setTitle(element.getElementsByTagName("Title").item(0).getTextContent());
		yahooProductAuctionSearch.setCurrentPrice(element.getElementsByTagName("CurrentPrice").item(0).getTextContent());
		yahooProductAuctionSearch.setImage(element.getElementsByTagName("Image").item(0).getTextContent());
		yahooProductAuctionSearch.setItemUrl(element.getElementsByTagName("ItemUrl").item(0).getTextContent());
		yahooProductAuctionSearch.setAuctionItemUrl(element.getElementsByTagName("AuctionItemUrl").item(0).getTextContent());
		yahooProductAuctionSearch.setBidOrBuy(element.getElementsByTagName("BidOrBuy").item(0).getTextContent());

		return  yahooProductAuctionSearch;
	}

	@RequestMapping("SendToSell/{searchSite}/{itemIndex}/{keyWord}")
	public ModelAndView sendToSell(@PathVariable("searchSite") String searchSite,@PathVariable("itemIndex") String itemId,@PathVariable("keyWord")String keyWord,ModelMap model){
		switch (searchSite){
			case "yahoo": {
				AjaxResponseResult<List<YahooProductSearch>> responseResult = yahooSearchProductByKeywordV2(keyWord);
				List<YahooProductSearch> lstYahooSearch = responseResult.getExtraData();
				Optional<YahooProductSearch> optYahooSearch = lstYahooSearch.stream().filter(s->s.getItemId().equals(itemId)).findFirst();
				EbayProductToAdd ebayProductToAdd = null;
				if(optYahooSearch.isPresent()){
					YahooProductSearch yahooProductSearch = optYahooSearch.get();
					ebayProductToAdd = new EbayProductToAdd();
					ebayProductToAdd.setTitle(yahooProductSearch.getProductName());
					ebayProductToAdd.setViewItemUrl(yahooProductSearch.getExhibition());
					ebayProductToAdd.setCurrentPrice(yahooProductSearch.getPrice());
					ebayProductToAdd.setImageUrl(yahooProductSearch.getImage());
				}
				model.addAttribute("ebayProductAdd", ebayProductToAdd);
			}
				break;
			case "ebay": {
				String data = getEbaySearchProductResult(keyWord);
				EbayProductToAdd ebayProductAdd = processEbaySearchItem(data, itemId);
				model.addAttribute("ebayProductAdd", ebayProductAdd);
			}
				break;
			case "rakuten":{
				List<ProductSearch> lstRakutenSearch = rakutenSearchProductByKeyword(keyWord);
				ProductSearch productSearch = lstRakutenSearch.get(Integer.valueOf(itemId));
				EbayProductToAdd ebayProductToAdd = null;
				if(productSearch!=null){
					ebayProductToAdd = new EbayProductToAdd();
					ebayProductToAdd.setTitle(productSearch.getProductName());
					ebayProductToAdd.setImageUrl(productSearch.getImage());
					ebayProductToAdd.setViewItemUrl(productSearch.getExhibition());
					ebayProductToAdd.setCurrentPrice(productSearch.getPrice());
				}
				model.addAttribute("ebayProductAdd", ebayProductToAdd);
			}
				break;
			case "amazon":{
				String amazonSearchURL =  CommonUtils.buildAmazonServiceUrl(keyWord,amazonServiceInfo);
				AmazonSearchResult amzSearchResult = processAmazonSearchResult(amazonSearchURL);
				List<AmazonProductSearch> lstProductSearch = amzSearchResult.getLstProductSearch();
				AmazonProductSearch amazonProductSearch = lstProductSearch.get(Integer.valueOf(itemId));
				if(amazonProductSearch!=null){
					EbayProductToAdd ebayProductToAdd = new EbayProductToAdd();
					ebayProductToAdd.setTitle(amazonProductSearch.getName());
					ebayProductToAdd.setImageUrl(amazonProductSearch.getImageUrl());
					ebayProductToAdd.setViewItemUrl(amazonProductSearch.getLink());
					ebayProductToAdd.setCurrentPrice(amazonProductSearch.getPrice());
					model.addAttribute("ebayProductAdd", ebayProductToAdd);
				}
			}
				break;
		}
		return new ModelAndView("forward:/Sell", model);
	}
	
	@Cacheable(value="ebayProductSearchCached",key="#keyword")
	private String getEbaySearchProductResult(String keyword){
		String productSearchUrl = CommonUtils.buildEbayServiceUrl(keyword, ebayServiceInfomation);
		return CommonUtils.getHTMLContent(productSearchUrl);
	}
	
	@RequestMapping(value ="/RakutenProductSearch/{keyword}",method=RequestMethod.GET)
	public @ResponseBody List<ProductSearch> rakutenSearchProductByKeyword(@PathVariable(value = "keyword") String keyword){
		String finalUrl = MessageFormat.format(rakutenServiceInfomation.getServiceUrl(),rakutenServiceInfomation.getAppid(),keyword); 
		String responseContent = CommonUtils.getHTMLContent(finalUrl);
		
		if(!"".equals(responseContent)){
			JsonParser jsonParser = new JsonParser();
			JsonObject responseJsonObject = jsonParser.parse(responseContent).getAsJsonObject();
			JsonArray itemJsonArrayObject = responseJsonObject.getAsJsonArray("Items");
			
			int totalItem = itemJsonArrayObject.size();
			List<ProductSearch> lstProductSearch = new ArrayList<ProductSearch>(totalItem);
			
			for (int itemIndex = 0; itemIndex < totalItem; itemIndex++) {
				JsonObject itemJsonObject = (JsonObject)itemJsonArrayObject.get(itemIndex);
				itemJsonObject = itemJsonObject.getAsJsonObject("Item");
	
				String productName = itemJsonObject.get("itemName").getAsString();
				String price = itemJsonObject.get("itemPrice").getAsString();
				String exhibition = itemJsonObject.get("itemUrl").getAsString();
				String stock ="";
				
				JsonArray imageUrls = itemJsonObject.get("mediumImageUrls").getAsJsonArray();
				if(imageUrls.size()==0){
					imageUrls = itemJsonObject.get("smallImageUrls").getAsJsonArray(); 
				}
				//May be set default image here when product has not image -fix later
				String image = imageUrls.size()==0?"":imageUrls.get(0).getAsJsonObject().get("imageUrl").getAsString(); 
				lstProductSearch.add(new ProductSearch(image, productName, price, stock, exhibition,"rakuten",(itemIndex+"")));
			}
			
			return lstProductSearch;
		}else{
			System.out.println("Empty response content!!!");
		}
		
		return Collections.emptyList();
	} 
	
	 @RequestMapping(value="/CheckPassword/{rawPassword}", method = RequestMethod.GET)
	 public @ResponseBody AjaxResponseResult<Boolean> checkPassword(@PathVariable("rawPassword") String rawPassword){
		AjaxResponseResult<Boolean> responseResult = new AjaxResponseResult<Boolean>();
		responseResult.setStatus("OK");
		
		//Get user id
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserDto user = CommonUtils.getUserFromSession((org.springframework.security.core.userdetails.User)authentication.getPrincipal(), userService);
		int userId = user.getId();
		
		//Decode password 
		try {
			rawPassword = UriUtils.decode(rawPassword, "UTF-8");
		} catch (UnsupportedEncodingException e) { 
			e.printStackTrace();
		}
		
		//Check
		boolean isCorrect = userService.isPasswordCorrect(userId, rawPassword);
		responseResult.setExtraData(isCorrect);
		
		return responseResult;		 
	 }
	 
	 private AmazonSearchResult processAmazonSearchResult(String amazonSearchURL){
		 String response = CommonUtils.getHTMLContent(amazonSearchURL,Tuple.make("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"),
				 Tuple.make("Accept-Encoding","gzip, deflate, sdch"),
				 Tuple.make("Accept-Language","vi-VN,vi;q=0.8,fr-FR;q=0.6,fr;q=0.4,en-US;q=0.2,en;q=0.2,ro;q=0.2,und;q=0.2"),
				 Tuple.make("Accept-Charset", "UTF-8"),
				 Tuple.make("Cookie","ubid-acbjp=352-2065366-8993931; session-token=\"fZXdjEjgK8uR6fth39+5xc65xw00eK1S/VV1L0uwCVjJGSdDS17l+BV6codbMvHFs8mCC8yVKJ5LmIcIXi54AbFNeVm/J8i+ky/BfjqDmWSYVcYb5PjuJNAtpZZiqnhkuSkldVUyECMclcveQ6J/0XClOFlkAYu0RldNopA/HVG0+InHQYFgfayFjOGTDXPdYm75xpRZBxk7vbjdgU0dhqV3uYWkCXDRRukKp+4Yl+8=\"; x-acbjp=\"N82igyz2nuVH@XNt@cQkpObsv3dZQOa@9ss7pdR5xKsnhx?8WRGYSU5BYbznHlY@\"; session-id=353-9960805-6338904; session-id-time=2082758400; ubid-tacbjp=353-1361336-5340853"),
				 Tuple.make("Cache-Control","max-age=0"));
		 AmazonSearchResult amzSearchResult = new AmazonSearchResult();
		 List<AmazonProductSearch> lstAmazSearch = new ArrayList<>();
		 Document htmlDocument = Jsoup.parse(response, "", Parser.xmlParser());
		 Elements itemsElement = htmlDocument.select("ItemSearchResponse>Items>Item");
		 Iterator<Element> itemsIterator = itemsElement.iterator();
		 int index = 0;
		 while(itemsIterator.hasNext()){
			 Element item = itemsIterator.next();
			 String asinCode = item.select("ASIN").first().text();
			 Elements itemUrlElement = item.select("ItemLinks>ItemLink>URL");
			 Element urlElement = null;
			 Iterator<Element> itUrlIterator = itemUrlElement.iterator();
			 if(itUrlIterator.hasNext()){
				 urlElement = itUrlIterator.next();
				 if(itUrlIterator.hasNext()){
					 urlElement = itUrlIterator.next();
				 }
			 }
			 Element itemAttribute = item.select("ItemAttributes").first();
			 String title = itemAttribute.select("Title").first().text();
			 lstAmazSearch.add(new AmazonProductSearch(title, "0f", urlElement.text(), "", asinCode,index));
			 index++;
		 }
		 amzSearchResult.setLstProductSearch(lstAmazSearch);
		 return amzSearchResult;
	 }
	 
	 private EbayProductToAdd processEbaySearchItem(String jsonString,String itemId){
		 JsonParser jsonParser = new JsonParser();
		 JsonObject jsonObject = jsonParser.parse(jsonString).getAsJsonObject();
		 JsonArray jsonArray = jsonObject.getAsJsonArray("findItemsByKeywordsResponse");
		 
		 jsonObject = (JsonObject)jsonArray.get(0);
		 jsonArray  = jsonObject.getAsJsonArray("searchResult");
		 jsonObject = (JsonObject)jsonArray.get(0);
		 jsonArray  = jsonObject.getAsJsonArray("item");
		 
		 int length = jsonArray.size();
		 for(int index = 0;index<length;index++){
			 jsonObject = (JsonObject)jsonArray.get(index);
			 String tmpItemId = jsonObject.getAsJsonArray("itemId").get(0).getAsString();
			 if(tmpItemId.equals(itemId)){
				 break;
			 }
		 }
		 
		 return convertJsonObjectToEbayProduct(jsonObject);
	 }
	 
	 private EbayProductToAdd convertJsonObjectToEbayProduct(JsonObject jsonObject){
		 EbayProductToAdd ebayProductAdd = new EbayProductToAdd();

		 String itemId = jsonObject.getAsJsonArray("itemId").get(0).getAsString();

		 ebayProductAdd.setItemId(itemId);
		 
		 String title = jsonObject.getAsJsonArray("title").get(0).getAsString();
		 ebayProductAdd.setTitle(title);
		 
		 String globalId = jsonObject.getAsJsonArray("globalId").get(0).getAsString();
		 ebayProductAdd.setGlobalId(globalId); 
		 JsonObject primaryCategory = jsonObject.getAsJsonArray("primaryCategory").get(0).getAsJsonObject();
		 String categoryId = primaryCategory.getAsJsonArray("categoryId").get(0).getAsString();
		 String categoryName= primaryCategory.getAsJsonArray("categoryName").get(0).getAsString();
		 ebayProductAdd.setCategoryId(categoryId);
		 ebayProductAdd.setCategoryName(categoryName);
		 
		 String imageUrl = jsonObject.getAsJsonArray("galleryURL").get(0).getAsString();
		 ebayProductAdd.setImageUrl(imageUrl);
		 
		 String viewItemUrl = jsonObject.getAsJsonArray("viewItemURL").get(0).getAsString();
		 ebayProductAdd.setViewItemUrl(viewItemUrl);
		 
		 String paymentMethod = jsonObject.getAsJsonArray("paymentMethod").get(0).getAsString();
		 ebayProductAdd.setPaymentMethod(paymentMethod);
		 
		 Boolean isAutoPay = jsonObject.getAsJsonArray("autoPay").get(0).getAsBoolean();
		 ebayProductAdd.setAutoPay(isAutoPay);

		 if(jsonObject.getAsJsonArray("postalCode") != null){
			 String postalCode = jsonObject.getAsJsonArray("postalCode").get(0).getAsString();
			 ebayProductAdd.setPortalCode(postalCode);
		 }
		 String location = jsonObject.getAsJsonArray("location").get(0).getAsString();
		 ebayProductAdd.setLocation(location);
		 
		 String country = jsonObject.getAsJsonArray("country").get(0).getAsString();
		 ebayProductAdd.setCountry(country);
		 
		 JsonObject shippingInfo = jsonObject.getAsJsonArray("shippingInfo").get(0).getAsJsonObject();
		 JsonObject shippingServiceCost = shippingInfo.getAsJsonArray("shippingServiceCost").get(0).getAsJsonObject();
		 
		 String currencyId =shippingServiceCost.get("@currencyId").getAsString();
		 ebayProductAdd.setCurrencyId(currencyId);
		 
		 String shippingCost = shippingServiceCost.get("__value__").getAsString();
		 ebayProductAdd.setShippingCost(shippingCost);
		 
		 String shippingType = shippingInfo.getAsJsonArray("shippingType").get(0).getAsString();
		 ebayProductAdd.setShippingType(shippingType);
		 
		 String shipToLocation = shippingInfo.getAsJsonArray("shipToLocations").get(0).getAsString();
		 ebayProductAdd.setShippingToLocation(shipToLocation);
		 
		 String expeditedShipping = shippingInfo.getAsJsonArray("expeditedShipping").get(0).getAsString();
		 ebayProductAdd.setExpeditedShipping(expeditedShipping);
		 
		 Boolean oneDayShippingAvaiable =shippingInfo.getAsJsonArray("expeditedShipping").get(0).getAsBoolean();
		 ebayProductAdd.setOneDayShippingAvailable(oneDayShippingAvaiable);
		 
		 String handlingTime = shippingInfo.getAsJsonArray("handlingTime").get(0).getAsString();
		 ebayProductAdd.setHandingTime(handlingTime);		 
		 
		 JsonObject sellingStatus = jsonObject.getAsJsonArray("sellingStatus").get(0).getAsJsonObject();
		 String currentPrice = sellingStatus.getAsJsonArray("currentPrice").get(0).getAsJsonObject().get("__value__").getAsString();
		 ebayProductAdd.setCurrentPrice(currentPrice);
		 
		 return ebayProductAdd;
	 }
	
	
	/**
     * This method handles logout requests.
     * Toggle the handlers if you are RememberMe functionality is useless in your app.
     */
    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logoutPage (HttpServletRequest request, HttpServletResponse response){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){    
            new SecurityContextLogoutHandler().logout(request, response, auth);
//            persistentTokenBasedRememberMeServices.logout(request, response, auth);
            SecurityContextHolder.getContext().setAuthentication(null);
        }
        return "redirect:/login?logout";
    }
    
	/**
	 * This method handles Access-Denied redirect.
	 */
	@RequestMapping(value = "/Access_Denied", method = RequestMethod.GET)
	public String accessDeniedPage(ModelMap model) {
		model.addAttribute("loggedinuser", getPrincipal());
		return VIEW_ACCESS_DENIED;
	}
	
	/**
	 * This method returns the principal[user-name] of logged-in user.
	 */
	private String getPrincipal(){
		String userName = null;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails) {
			userName = ((UserDetails)principal).getUsername();
		} else {
			userName = principal.toString();
		}
		return userName;
	}
	
	/**
	 * This method returns true if users is already authenticated [logged-in], else false.
	 */
	private boolean isCurrentAuthenticationAnonymous() {
	    final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    AuthenticationTrustResolverImpl authenticationTrustResolver = new AuthenticationTrustResolverImpl();
	    
	    return authenticationTrustResolver.isAnonymous(authentication);
	}

	@RequestMapping(value="/searchAll/{keyword}", method= RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> seachAll(@PathVariable("keyword") String keyword){
		logger.info("====value key word: "+ keyword);
		String amazonSearchURL = CommonUtils.buildAmazonServiceUrl(keyword, amazonServiceInfo);
		AmazonSearchResult amzSearchResult = processAmazonSearchResult(amazonSearchURL);
		String ebayResult = getEbaySearchProductResult(keyword);
		AjaxResponseResult<List<YahooProductSearch>> ajaxResponseResult = processYahooSearchV2(keyword);
		AjaxResponseResult<List<YahooProductAuctionSearch>> yahooAuctionResult = processYahooAuctionSearch(keyword);
		List<ProductSearch> rakutenResult = processRakutenSearch(keyword);
		Map<String, Object> objectMap = new HashedMap();
		objectMap.put("amazon", amzSearchResult);
		objectMap.put("ebay", ebayResult);
		objectMap.put("yahoo", ajaxResponseResult);
		objectMap.put("yahooAuction", yahooAuctionResult);
		objectMap.put("rakuten", rakutenResult);

		return new ResponseEntity(objectMap,HttpStatus.OK);
	}


	private List<ProductSearch> processRakutenSearch(String keyword){
		String finalUrl = MessageFormat.format(rakutenServiceInfomation.getServiceUrl(),rakutenServiceInfomation.getAppid(),keyword);
		String responseContent = CommonUtils.getHTMLContent(finalUrl);

		List<ProductSearch> lstProductSearch;

		if(!"".equals(responseContent)){
			JsonParser jsonParser = new JsonParser();
			JsonObject responseJsonObject = jsonParser.parse(responseContent).getAsJsonObject();
			JsonArray itemJsonArrayObject = responseJsonObject.getAsJsonArray("Items");

			int totalItem = itemJsonArrayObject.size();
			lstProductSearch = new ArrayList<ProductSearch>(totalItem);

			for (int itemIndex = 0; itemIndex < totalItem; itemIndex++) {
				JsonObject itemJsonObject = (JsonObject)itemJsonArrayObject.get(itemIndex);
				itemJsonObject = itemJsonObject.getAsJsonObject("Item");

				String productName = itemJsonObject.get("itemName").getAsString();
				String price = itemJsonObject.get("itemPrice").getAsString();
				String exhibition = itemJsonObject.get("itemUrl").getAsString();
				String stock ="";

				JsonArray imageUrls = itemJsonObject.get("mediumImageUrls").getAsJsonArray();
				if(imageUrls.size()==0){
					imageUrls = itemJsonObject.get("smallImageUrls").getAsJsonArray();
				}
				//May be set default image here when product has not image -fix later
				String image = imageUrls.size()==0?"":imageUrls.get(0).getAsJsonObject().get("imageUrl").getAsString();
				lstProductSearch.add(new ProductSearch(image, productName, price, stock, exhibition,"rakuten",(itemIndex+"")));
			}

			return lstProductSearch;
		}else{
			logger.info("Empty response content!!!");
		}

		return Collections.emptyList();
	}
	
}
