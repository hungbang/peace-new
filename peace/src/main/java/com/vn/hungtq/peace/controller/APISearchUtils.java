package com.vn.hungtq.peace.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.*;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

/**
 * Created by KAI on 5/8/17.
 */
public class APISearchUtils {

    private final Logger logger = LoggerFactory.getLogger(APISearchUtils.class);

    private static final String URL_AMAZON_BY_KEYWORD = "http://peace-ex.com/php/common/amazonAut.php?keyword={keyword}";

    public static String amazonSearchKeyWord(String keyword){
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.TEXT_HTML);
        ResponseEntity<String> result;
        try{
            result = restTemplate.exchange(URL_AMAZON_BY_KEYWORD, HttpMethod.GET, null,String.class, keyword);
        }catch (RestClientException e){
            result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
        }

        return result.getBody();
    }
}
