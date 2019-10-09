/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.repository;

import com.sam.assignment3.entity.Order;
import com.sam.assignment3.entity.OrderDetail;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    @Query(value = "SELECT od FROM OrderDetail od where od.product.id = :id")
    public List<OrderDetail> findProductById(@Param("id") Long id);

    @Query("select d from OrderDetail d where d.orderMaster=?1")
    public List<OrderDetail> getOrderDetailByMasterId(Order orderMaster);
}
