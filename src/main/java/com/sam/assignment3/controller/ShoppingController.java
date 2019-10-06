/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.controller;

import com.sam.assignment3.entity.Cart;
import com.sam.assignment3.entity.Order;
import com.sam.assignment3.entity.OrderDetail;
import com.sam.assignment3.repository.OrderDetailRepository;
import com.sam.assignment3.repository.OrderRepository;
import com.sam.assignment3.repository.ProductRepository;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
    private OrderRepository orderRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;

    private int isExistItem(int id, List<Cart> myCart) {
        for (int i = 0; i < myCart.size(); i++) {
            if (myCart.get(i).getProduct().getId() == id) {
                return i;
            }
        }
        return -1;
    }

    @RequestMapping(value = "/order", method = RequestMethod.GET)
    public String order(@RequestParam int id,
            @RequestParam int quantity,
            HttpSession session) {
        List<Cart> myCart = (List<Cart>) session.getAttribute("cart");
        if (myCart == null) {
            myCart = new ArrayList<>();
            myCart.add(new Cart(productRepository.getOne(id), quantity));
        } else {
            int index = isExistItem(id, myCart);
            if (index == -1) {
                myCart.add(new Cart(productRepository.getOne(id), quantity));
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
        List<Cart> myCart = (List<Cart>) session.getAttribute("cart");
        double total = calTotal(myCart);
        model.put("total", total);
        return new ModelAndView("/shop/index", "myCart", myCart);
    }
    @RequestMapping(value = "/payment", method = RequestMethod.GET)
    public ModelAndView payment( 
            @RequestParam(value = "user", required = false) String username,
            HttpSession session) {
        List<Cart> myCart = (List<Cart>) session.getAttribute("cart");
        double total = calTotal(myCart);
        orderRepository.save(new Order(username, Date.from(Instant.now()),total));
        List<Order> listoder = orderRepository.findAll();
        for (Cart cart : myCart) {
            orderDetailRepository.save(new OrderDetail(cart.getProduct(), listoder.get(listoder.size()-1), cart.getQuantity()));
                    
        }
        return new ModelAndView("/shop/payment");
    }
    @RequestMapping(value = "/history", method = RequestMethod.GET)
    public ModelAndView history( 
            @RequestParam(value = "user", required = false) String username,
            HttpSession session) {
        List<OrderDetail> listInDetails = new ArrayList<>();
        List<OrderDetail> listDetails = new ArrayList<>();
        List<Order> listOrder =  orderRepository.findByName(username);
        for (Order order : listOrder) {
        listInDetails = orderDetailRepository.findByName(order.getId());    
            for (OrderDetail listInDetail : listInDetails) {
                listDetails.add(listInDetail);
            }
        }
        return new ModelAndView("/shop/history","history",listDetails);
    }

    private double calTotal(List<Cart> myCart) {
        double result = 0.0;
        if (myCart != null) {
            for (Cart cart : myCart) {
                result = result + cart.getQuantity() * cart.getProduct().getPrice();
            }
        }
        return result;
    }

    @RequestMapping(value = "/remove", method = RequestMethod.GET)
    public String remove(@RequestParam int id,
            HttpSession session) {
        List<Cart> myCart = (List<Cart>) session.getAttribute("cart");
        int index = isExistItem(id, myCart);
        myCart.remove(index);
        session.setAttribute("cart", myCart);
        return "redirect:index";
    }
}
