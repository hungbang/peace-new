package com.vn.hungtq.peace.controller;

/**
 * Created by KAI on 5/4/17.
 */

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Controller
public class APIController {
    private final Logger logger = LoggerFactory.getLogger(APIController.class);
    private static final String URL_SEARCH_CATEGORY = "http://peace-ex.com/php/db_api/SelCategoriesSearch.php";
    private static final String URL_AMAZON_BY_KEYWORD = "http://peace-ex.com/php/common/amazonAut.php?keyword={keyword}";


    @RequestMapping("/searchCategory/{country}/{cateName}")
    @ResponseBody
    public String searchCategory(@PathVariable("country") String country, @PathVariable("cateName") String cateName){
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> mapParam = new LinkedMultiValueMap<String, String>();
        mapParam.add("Country", country);
        mapParam.add("CategoryName", cateName);
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(mapParam, headers);
        ResponseEntity<String> result;
        try{
            result = restTemplate.postForEntity(URL_SEARCH_CATEGORY, request, String.class);
        }catch (RestClientException e){
            logger.info("ERROR: "+ e.getMessage());
            result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
        }

        return result.getBody();
    }

    @RequestMapping("/searchAmazonByKeyword/{keyword}")
    @ResponseBody
    public String searchAmazonByKeyword(@PathVariable("keyword") String keyword){
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.TEXT_HTML);
        ResponseEntity<String> result;
        try{
            result = restTemplate.exchange(URL_AMAZON_BY_KEYWORD, HttpMethod.GET, null,String.class, keyword);
        }catch (RestClientException e){
            logger.info("ERROR: "+ e.getMessage());
            result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
        }

        return result.getBody();
    }


//    public static void main(String[] args) {
//        RestTemplate restTemplate = new RestTemplate();
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.TEXT_HTML);
//        Map<String, String> map = new HashedMap();
//        String keyword = "shoe";
//        map.put("keyword", keyword);
//        ResponseEntity<String> result;
//        try{
//            result = restTemplate.exchange(URL_AMAZON_BY_KEYWORD, HttpMethod.GET, null,String.class, keyword);
//        }catch (RestClientException e){
//            result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
//        }
//        System.out.println("===="+ result);
//    }
}
