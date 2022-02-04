package com.owned.aws.runtime;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.owned.aws")
public class AwsWarmApplication {

    public static void main(String[] args) {
        SpringApplication.run(AwsWarmApplication.class, args);
    }
}
