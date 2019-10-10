/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.controller;

import com.sam.assignment3.entity.Role;
import com.sam.assignment3.entity.User;
import com.sam.assignment3.repository.RoleRepository;
import com.sam.assignment3.repository.UserRepository;
import java.util.List;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Asus
 */
@Controller
@RequestMapping(value = "/auth")
public class AuthenticationController {
    @Autowired
    private UserRepository userRepository ;
    @Autowired
    private RoleRepository roleRepository ;
    @RequestMapping(value = {"/login","","/"})
    public ModelAndView getLoginForm(
        @RequestParam(required = false)String authfailed,String logout,String denied){
        String message="";
        System.out.println("authfailed " + authfailed);
        if(authfailed != null){
            message = "Invalid username or password, try again!";
        }else if(logout != null){
            message = "Logged Out seccessfully!";
        }else if(denied != null){
            message = "Access denied for this user!";
        }
        return new ModelAndView("/auth/login","message",message);
    }
    @RequestMapping(value = {"/register","","/"}, method = RequestMethod.GET)
    public ModelAndView getRegisterForm(ModelMap model){
        return new ModelAndView("/auth/register","user",new User());
    }
    @RequestMapping(value = {"/register","","/"}, method = RequestMethod.POST)
    public String getRegisterForm(@Valid @ModelAttribute("user") User user,
            BindingResult result, ModelMap model){
        user.setEnabled(1);
        List<User> listUser = userRepository.findAll();
        for (User user1 : listUser) {
            if(user.getUsername().equalsIgnoreCase(user1.getUsername())){
                model.put("error", "User is exist !");
                return "/auth/register";
            }
        }
        userRepository.save(user);
        roleRepository.save(new Role("ROLE_USER", user));
        return "redirect:login";
    }
    
    @RequestMapping("/403page")
    public String get403denied(){
        return "redired:/auth/login?denied";
    }
}
