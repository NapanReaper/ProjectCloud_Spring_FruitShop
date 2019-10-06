/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.repository;

import com.sam.assignment3.entity.OrderDetail;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;



public interface OrderDetailRepository extends JpaRepository<OrderDetail, Integer>{
    @Query(value = "SELECT od FROM OrderDetail od where od.id = :id")
    public List<OrderDetail> findByName(@Param("id")int id);
    @Query(value = "SELECT od FROM OrderDetail od where od.product.id = :id")
    public List<OrderDetail> findProductById(@Param("id")int id);
}
