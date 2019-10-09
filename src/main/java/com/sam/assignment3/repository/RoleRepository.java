/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sam.assignment3.repository;

import com.sam.assignment3.entity.Role;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface RoleRepository extends JpaRepository<Role, Integer> {

    @Query(value = "SELECT * FROM user_roles r WHERE r.ROLE = 'ROLE_USER'",
            nativeQuery = true)
    public List<Role> getAllUserRole();
}
