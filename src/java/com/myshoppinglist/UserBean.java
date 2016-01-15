/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myshoppinglist;

/**
 *
 * @author Mitsos
 */
public class UserBean {

    private String firstName = null;
    private String name = null;
    private String email = null;

    public UserBean() {
    }

    public String getFirstName() {
        return firstName;
    }

    public String getname() {
        return name;
    }

    public String getemail() {
        return email;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setname(String name) {
        this.name = name;
    }

    public void getemail(String email) {
        this.email = email;
    }

}
