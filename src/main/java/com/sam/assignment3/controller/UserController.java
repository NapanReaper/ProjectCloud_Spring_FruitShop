/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.controller;

import com.sam.assignment3.entity.MessageJson;
import com.sam.assignment3.entity.Role;
import com.sam.assignment3.entity.User;
import com.sam.assignment3.repository.RoleRepository;
import com.sam.assignment3.repository.UserRepository;
import java.sql.SQLException;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Asus
 */
@Controller
public class UserController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;

    @RequestMapping(value = "/removeUser", method = RequestMethod.POST)
    public @ResponseBody
    MessageJson removeUser(@RequestParam("user_id") Integer id) {
        MessageJson m = new MessageJson("Ban failed", false);
        User user = userRepository.findOne(id);
        try {
            user.setEnabled(0);
            userRepository.save(user);
            m.setMessage("Ban success");
            m.setStatus(Boolean.TRUE);

        } catch (Exception e) {
        }
        return m;
    }

    @RequestMapping(value = "/unbanUser", method = RequestMethod.POST)
    public @ResponseBody
    MessageJson unbanUser(@RequestParam("user_id") Integer id) {
        MessageJson m = new MessageJson("Unban failed", false);
        User user = userRepository.findOne(id);
        try {
            user.setEnabled(1);
            userRepository.save(user);
            m.setMessage("Unban success");
            m.setStatus(Boolean.TRUE);

        } catch (Exception e) {
        }
        return m;
    }

    @RequestMapping(value = "/usermanagement", method = RequestMethod.GET)
    public ModelAndView user(ModelMap model) throws SQLException {

        return new ModelAndView("/home/usermanagement", "listuser", roleRepository.getAllUserRole());
    }

    @RequestMapping(value = "/add-user", method = RequestMethod.GET)
    public ModelAndView create() throws SQLException {
        return new ModelAndView("/home/add-user", "user", new User());
    }

    @RequestMapping(value = "/edit-user", method = RequestMethod.GET)
    public ModelAndView editUser(@RequestParam(value = "user_id") Integer id) throws SQLException {
        return new ModelAndView("/home/edit-user", "user", userRepository.findOne(id));
    }

    @RequestMapping(value = "/edit-user", method = RequestMethod.POST)
    public String edit(@Valid @ModelAttribute("user") User user,
            BindingResult result, ModelMap mm) throws SQLException {
        if (result.hasErrors()) {
            return "/home/edit-user";
        }
        userRepository.save(user);
        return "redirect:usermanagement";
    }

    @RequestMapping(value = "/add-user", method = RequestMethod.POST)
    public String addUser(@Valid @ModelAttribute("user") User user,
            BindingResult result, ModelMap model) {
        try {
            user.setEnabled(1);
            Date date = new Date(System.currentTimeMillis());
            user.setBirthdate(date);
            List<User> listUser = userRepository.findAll();
            for (User user1 : listUser) {
                if (user.getUsername().equalsIgnoreCase(user1.getUsername())) {
                    model.put("error", "User is exist !");
                    return "/home/add-user";
                }
            }
            userRepository.save(user);
            roleRepository.save(new Role("ROLE_USER", user));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:usermanagement";
    }

}
