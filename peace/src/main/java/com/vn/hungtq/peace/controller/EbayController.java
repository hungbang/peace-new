package com.vn.hungtq.peace.controller;

import com.vn.hungtq.peace.entity.User;
import com.vn.hungtq.peace.service.UserDaoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


@Controller
public class EbayController {

    private final Logger logger = LoggerFactory.getLogger(MainController.class);

    @Autowired
    UserDaoService userDaoService;

    @RequestMapping("/SetEbayLocation")
    public ModelAndView goToLocation(HttpServletRequest request) {
        ModelAndView model = new ModelAndView("/pages/G_SetEbayLocation");
        String username = request.getUserPrincipal().getName();
        User userSaved = userDaoService.findBySSO(username);
        if(userSaved != null)
            model.addObject("location", userSaved.getLocation());
        return model;
    }

    @RequestMapping(value = "/saveEbayLocation", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity saveEbayLocation(@RequestParam("location") String location, HttpServletRequest request) {
        String username = request.getUserPrincipal().getName();
        logger.info("user name is : "+ username + "----location: "+ location);
        try {
            User userSaved = userDaoService.findBySSO(username);
            if (userSaved != null){
                userSaved.setLocation(location);
                userDaoService.updateLocation(userSaved);
            }
        } catch (Exception e) {
            logger.error("Can not update location." + e.getMessage());
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }

        return ResponseEntity.ok(location);
    }
}