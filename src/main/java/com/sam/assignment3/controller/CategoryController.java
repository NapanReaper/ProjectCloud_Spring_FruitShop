/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.controller;

import com.sam.assignment3.entity.Category;
import com.sam.assignment3.repository.CategoryRepository;
import com.sam.assignment3.repository.ProductRepository;
import java.sql.SQLException;
import java.util.List;
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
@RequestMapping(value = "/cate")
public class CategoryController {

    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private ProductRepository productRepository;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView index(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "keyword", required = false) String keyword,
            ModelMap model) {
        if (page == null) {
            page = 0;
        }
        if (page < 0) {
            page = 0;
        }
        if (keyword == null) {
            keyword = "";
        }
        Sort sort = new Sort(new Sort.Order(Sort.Direction.ASC, "id"));
        Pageable pageable = new PageRequest(page, 2, sort);
        if (page >= pageable.getPageSize()) {
            page = pageable.getPageSize();
        }
        model.put("page", page);
        model.put("keyword", keyword);
        List<Category> listCate = categoryRepository.findAndPaging(keyword, pageable);
        return new ModelAndView("/cate/index", "listCate", listCate);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public ModelAndView create() throws SQLException {
        return new ModelAndView("/cate/create", "product", new Category());
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("product") Category category,
            BindingResult result, ModelMap model) throws SQLException {
        if (result.hasErrors()) {
            return "/cate/create";
        }
        categoryRepository.save(category);
        return "redirect:../home/index";
    }

    @RequestMapping(value = "/details", method = RequestMethod.GET)
    public ModelAndView details(@RequestParam(value = "id", required = false) int id) throws SQLException {
        return new ModelAndView("/cate/details", "product", categoryRepository.findOne(id));
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id", required = false) int id) throws SQLException {
        return new ModelAndView("/cate/edit", "product", categoryRepository.findOne(id));
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String edit(@Valid @ModelAttribute("product") Category category,
            BindingResult result, ModelMap mm) throws SQLException {
        if (result.hasErrors()) {
            return "/cate/edit";
        }
        categoryRepository.save(category);
        return "redirect:../home/index";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(@RequestParam(value = "id", required = false) int id, ModelMap model) throws SQLException {
        if (!productRepository.findByCateId(id).isEmpty()) {
            model.put("listCate", categoryRepository.findAll());
            model.put("error", "Sản phẩm đang được sử dụng");
            model.addAttribute("error", "Product in use");
            return "redirect:../home/index";
        }
        categoryRepository.delete(id);
        return "redirect:../home/index";
    }
}
