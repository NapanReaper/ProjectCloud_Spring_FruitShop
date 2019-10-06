/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.controller;

import com.sam.assignment3.entity.Category;
import com.sam.assignment3.entity.Product;
import com.sam.assignment3.repository.CategoryRepository;
import com.sam.assignment3.repository.ProductRepository;
import com.sam.assignment3.repository.RoleRepository;
import com.sam.assignment3.repository.UserRepository;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
@RequestMapping(value = "/home")
public class HomeController {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
            
    ServletContext servletContext;
    
    @RequestMapping(value = {"/index","/",""}, method = RequestMethod.GET)
    public ModelAndView index(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "id", required = false) Integer cateId,
            ModelMap model) {
        if (page == null) {
            page = 0;
        }
        if (keyword == null) {
            keyword = "";
        }
        if (cateId == null) {
            cateId = -1;
        }
        Sort sort = new Sort(new Sort.Order(Sort.Direction.ASC, "name"));
        Pageable pageable = new PageRequest(page, 6, sort); //6 items/page
        model.put("page", page);
        model.put("keyword", keyword);
        model.put("id", cateId);
        model.put("pagenumber", pageable.getPageNumber() + 1);
        model.put("listCate", categoryRepository.findAll());
        model.put("categoryId", categoryRepository.findOne(cateId));
        model.addAttribute("product", new Category());
        System.out.println(cateId);
        if (cateId > -1) {
            List<Product> listFilterSearchPage = productRepository.findNameFilter(keyword, cateId, pageable);
            List<Product> listFilterSearch = productRepository.findNameFilter(keyword, cateId);
            int pageSize = 0;
            if (listFilterSearch.size() % 6 == 0) {
                pageSize = listFilterSearch.size() / 6;
            } else {
                pageSize = (listFilterSearch.size() / 6) + 1;
            }
            model.put("pageSize", pageSize);
            return new ModelAndView("/home/index", "listProduct", listFilterSearchPage);
        }
        List<Product> listProduct = productRepository.findName(keyword, pageable);
        List<Product> listSearch = productRepository.findName(keyword);
        int pageSize = 0;
        if (listSearch.size() % 6 == 0) {
            pageSize = listSearch.size() / 6;
        } else {
            pageSize = (listSearch.size() / 6) + 1;
        }
        model.put("pageSize", pageSize);
        return new ModelAndView("/home/index", "listProduct", listProduct);
    }

    @RequestMapping(value = "/details", method = RequestMethod.GET)
    public ModelAndView details(@RequestParam(value = "id", required = false) int id) throws SQLException {
        return new ModelAndView("/home/details", "product", productRepository.findOne(id));
    }
    @RequestMapping(value = "/usermanagement", method = RequestMethod.GET)
    public ModelAndView user(ModelMap model) throws SQLException {
       
        return new ModelAndView("/home/usermanagement","listuser",roleRepository.getAllUserRole());
    }
}
