/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.controller;

import com.sam.assignment3.entity.Category;
import com.sam.assignment3.entity.Product;
import com.sam.assignment3.repository.CategoryRepository;
import com.sam.assignment3.repository.OrderDetailRepository;
import com.sam.assignment3.repository.ProductRepository;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletContext;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
@RequestMapping(value = "")
public class ProductController {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    ServletContext context;

    @RequestMapping(value = {"/index", "/", ""}, method = RequestMethod.GET)
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
        model.put("categoryId", categoryRepository.getOne(cateId));
        model.addAttribute("product", new Category());
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
            return new ModelAndView("/product/index", "listProduct", listFilterSearchPage);
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
        return new ModelAndView("/product/index", "listProduct", listProduct);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public ModelAndView create(ModelMap model) throws SQLException {
        model.put("listCate", categoryRepository.findAll());
        return new ModelAndView("/product/create", "product", new Product());
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("product") Product product,
            BindingResult result, ModelMap model) throws SQLException, IOException {

        if (result.hasErrors()) {
            model.put("listCate", categoryRepository.findAll());
            return "/product/create";
        }
        if (product.getCategory().getId() < 0) {
            model.put("listCate", categoryRepository.findAll());
            model.put("errorCate", "Please choice");
            return "/product/create";
        }
       
        productRepository.save(product);
        return "redirect:home/index";
    }

    @RequestMapping(value = "/details", method = RequestMethod.GET)
    public ModelAndView details(@RequestParam(value = "id", required = false) int id, ModelMap model) throws SQLException {
        model.put("listCate", categoryRepository.findAll());
        return new ModelAndView("/product/details", "product", productRepository.getOne(id));
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id", required = false) int id, ModelMap model) throws SQLException {
        model.put("listCate", categoryRepository.findAll());
        return new ModelAndView("/product/edit", "product", productRepository.getOne(id));
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String edit(@Valid @ModelAttribute("product") Product product,
            BindingResult result, ModelMap model) throws SQLException, IOException {
        if (result.hasErrors()) {
            model.put("listCate", categoryRepository.findAll());
            return "/product/edit";
        }
        productRepository.save(product);
        return "redirect:home/index";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(@RequestParam(value = "id", required = false) int id, ModelMap model) throws SQLException {
        if (!orderDetailRepository.findProductById(id).isEmpty()) {
            model.put("listCate", categoryRepository.findAll());
            model.put("error", "Sản phẩm đang được sử dụng");
            model.addAttribute("error", "Product in use");
            return "redirect:home/index";
        }
        productRepository.delete(productRepository.getOne(id));
        return "redirect:home/index";
    }
}
