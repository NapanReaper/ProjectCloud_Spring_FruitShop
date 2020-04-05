package com.sam.assignment3.entity;

import java.io.Serializable;
import java.util.HashMap;

public class Cart implements Serializable {

    private HashMap<Product, Integer> cart;

    public Cart() {
    }

    public HashMap<Product, Integer> getCart() {
        return cart;
    }

    public void addToCart(Product product) {
        if (this.cart.containsKey(product)) {
            int quantity = this.cart.get(product);
            quantity++;
            this.cart.put(product, quantity);
        }//update quantity khi add lai san pham o dto
        //ghi de lai cart
        this.cart.put(product, 1);
    }

    public void remove(Product product) {
        this.cart.remove(product);
    }

    public void plusQuantity(Product product, int quantity, int baseQuantity) throws Exception {
        if (this.cart.containsKey(product)) {
            int oldQuantity = this.cart.get(product);
            if (oldQuantity < baseQuantity) {
                int newQuantity = oldQuantity + quantity;
                this.cart.put(product, newQuantity);
            }
        }
    }

    public void minusQuantity(Product product, int quantity) throws Exception {
        if (this.cart.containsKey(product)) {
            int oldQuantity = this.cart.get(product);
            if (oldQuantity > 1) {
                int newQuantity = oldQuantity + quantity;
                this.cart.put(product, newQuantity);
            }
        }
    }
}
