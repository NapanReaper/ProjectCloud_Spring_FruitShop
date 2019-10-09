/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.repository;

import com.sam.assignment3.entity.Order;
import com.sam.assignment3.entity.User;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface OrderRepository extends JpaRepository<Order, Long> {

    @Query("select d from Order d where d.user=?1")
    public List<Order> getOrderMasterByUserId(User user);
}
