package com.owned.aws.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetingGetController {

    @GetMapping("/")
    public String greeting() {
        return "hello there!";
    }
}
