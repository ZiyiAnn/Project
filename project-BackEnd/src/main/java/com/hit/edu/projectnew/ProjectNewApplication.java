package com.hit.edu.projectnew;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.hit.edu.projectnew.mapper")
public class ProjectNewApplication {

    public static void main(String[] args) {
        SpringApplication.run(ProjectNewApplication.class, args);
    }

}
