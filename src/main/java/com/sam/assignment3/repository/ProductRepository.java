/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.repository;

import com.sam.assignment3.entity.Product;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductRepository extends JpaRepository<Product, Integer>{
   @Query(value = "SELECT p FROM Product p")
    public List<Product> paging(Pageable pageable);
   @Query(value = "SELECT p FROM Product p where p.category.id = :id")
    public List<Product> findByCateId(@Param("id")int id);
    
    @Query(value = "SELECT p FROM Product p WHERE LOWER(p.name) LIKE CONCAT('%',LOWER(:name),'%')")
    public List<Product> findName(@Param("name")String name, Pageable pageable);
    @Query(value = "SELECT p FROM Product p WHERE LOWER(p.name) LIKE CONCAT('%',LOWER(:name),'%')")
    public List<Product> findName(@Param("name")String name);
    
    @Query(value = "SELECT p FROM Product p WHERE LOWER(p.name) LIKE CONCAT('%',LOWER(:name),'%') AND LOWER(p.category.id) = :categoryname")
    public List<Product> findNameFilter(@Param("name")String name,@Param("categoryname")int cateID, Pageable pageable);
    @Query(value = "SELECT p FROM Product p WHERE LOWER(p.name) LIKE CONCAT('%',LOWER(:name),'%') AND LOWER(p.category.id) = :categoryname")
    public List<Product> findNameFilter(@Param("name")String name,@Param("categoryname")int cateID);
    
    @Query(value = "SELECT COUNT(p.amount) FROM Product p WHERE p.category.id = :cateID")
    public Integer countProductWithCate(@Param("cateID")int cateID);
    @Query(value = "SELECT SUM(p.amount) FROM Product p WHERE p.category.id = :cateID")
    public Double sumProductWithCate(@Param("cateID")int cateID);
    @Query(value = "SELECT MAX(p.amount) FROM Product p WHERE p.category.id = :cateID")
    public Double maxProductWithCate(@Param("cateID")int cateID);
    @Query(value = "SELECT MIN(p.amount) FROM Product p WHERE p.category.id = :cateID")
    public Double minProductWithCate(@Param("cateID")int cateID);
    @Query(value = "SELECT AVG(p.amount) FROM Product p WHERE p.category.id = :cateID")
    public Double avgProductWithCate(@Param("cateID")int cateID);
}

