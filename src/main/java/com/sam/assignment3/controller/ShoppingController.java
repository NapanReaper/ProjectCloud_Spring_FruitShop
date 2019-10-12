/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.controller;

import com.sam.assignment3.entity.Cart2;
import com.sam.assignment3.entity.Order;
import com.sam.assignment3.entity.OrderDetail;
import com.sam.assignment3.repository.OrderDetailRepository;
import com.sam.assignment3.repository.OrderRepository;
import com.sam.assignment3.repository.ProductRepository;
import com.sam.assignment3.repository.UserRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Asus
 */
@Controller
@RequestMapping("/shop")
public class ShoppingController {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private OrderRepository masterRepository;
    @Autowired
    private OrderDetailRepository detailRepository;
    @Autowired
    private UserRepository userRepository;

    private int isExistItem(Long id, List<Cart2> myCart) {
        for (int i = 0; i < myCart.size(); i++) {
            if (Objects.equals(myCart.get(i).getProduct().getId(), id)) {
                return i;
            }
        }
        return -1;
    }

    @RequestMapping(value = "/order", method = RequestMethod.GET)
    public String order(@RequestParam Long productId,
            @RequestParam int quantity,
            HttpSession session) {
        List<Cart2> myCart = (List<Cart2>) session.getAttribute("cart");
        if (myCart == null) {
            myCart = new ArrayList<>();
            myCart.add(new Cart2(productRepository.findOne(productId), quantity));
        } else {
            int index = isExistItem(productId, myCart);
            if (index == -1) {
                myCart.add(new Cart2(productRepository.findOne(productId), quantity));
            } else {
                int amount = myCart.get(index).getQuantity();
                myCart.get(index).setQuantity(quantity + amount);
                if (amount == 1 && quantity == -1) {
                    myCart.remove(index);
                }
            }
        }
        session.setAttribute("cart", myCart);
        return "redirect:index";
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView index(HttpSession session, ModelMap model) {
        List<Cart2> myCart = (List<Cart2>) session.getAttribute("cart");
        double total = calTotal(myCart);
        model.put("total", total);
        return new ModelAndView("/shop/index", "myCart", myCart);
    }

    @RequestMapping(value = "/payment", method = RequestMethod.GET)
    public ModelAndView payment(
            @RequestParam(value = "user", required = false) String username,
            HttpSession session) {
        List<Cart2> myCart = (List<Cart2>) session.getAttribute("cart");
        Order om = new Order();
        om.setDateCreate(new Date());
        om.setUser(userRepository.getUserFromUsername(username));
        masterRepository.save(om);
        for (Cart2 cart : myCart) {
            OrderDetail od = new OrderDetail();
            od.setOrderMaster(om);
            od.setPrice(cart.getProduct().getPrice());
            od.setQuantity(cart.getQuantity());
            od.setProduct(cart.getProduct());
            detailRepository.save(od);
        }
        session.removeAttribute("cart");
        return new ModelAndView("/shop/payment");
    }

    @RequestMapping(value = "/history", method = RequestMethod.GET)
    public ModelAndView history(
            @RequestParam(value = "user", required = false) String username,
            HttpSession session) {
        List<Order> orderMaster = masterRepository.getOrderMasterByUserId(userRepository.getUserFromUsername(username));
        return new ModelAndView("/shop/history", "history", orderMaster);
    }

    @RequestMapping(value = "/historyAdmin", method = RequestMethod.GET)
    public ModelAndView history(
            HttpSession session) {
        List<Order> orderMaster = masterRepository.findAll();
        return new ModelAndView("/shop/history", "history", orderMaster);
    }

    private double calTotal(List<Cart2> myCart) {
        double result = 0.0;
        if (myCart != null) {
            for (Cart2 cart : myCart) {
                result = result + cart.getQuantity() * cart.getProduct().getPrice();
            }
        }
        return result;
    }

    @RequestMapping(value = "/remove", method = RequestMethod.GET)
    public String remove(@RequestParam Long productId,
            HttpSession session) {
        List<Cart2> myCart = (List<Cart2>) session.getAttribute("cart");
        int index = isExistItem(productId, myCart);
        myCart.remove(index);
        if (myCart.isEmpty() || myCart == null) {
            session.removeAttribute("cart");
        } else {
            session.setAttribute("cart", myCart);
        }
        return "redirect:index";
    }
}
