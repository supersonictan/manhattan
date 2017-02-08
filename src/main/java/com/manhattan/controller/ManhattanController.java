package com.manhattan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZeYu
 * Date: 2017/2/8.
 * Time: 11:22.
 * DESC: say something
 */
@Controller
@RequestMapping("/item")
public class ManhattanController {

    @RequestMapping("/queryItems")
    public String queryItems(Model model) throws Exception{
        List<String> list = new ArrayList<String>();
        list.add("key1");
        list.add("key2");
        list.add("key3");
        model.addAttribute("itemList", list);
        return "itemsList";
    }
}
