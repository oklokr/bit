package com.project.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.project.interceptor.SessionInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Autowired
    private SessionInterceptor sessionInterceptor;

    @Override
    public void addInterceptors(@NonNull InterceptorRegistry registry) {
        registry.addInterceptor(sessionInterceptor).order(1)
        .addPathPatterns("/**")
        .excludePathPatterns(
            "/login", 
            "/findId", 
            "/findPw", 
            "/join", 
            "/findIdResult", 
            "/findPwResult",
            "/joinStepUser", 
            "/joinStepUser/**", 
            "/joinStepComp", 
            "/joinStepComp/**", 
            "/findResult",
            "/resources/**", 
            "/css/**", 
            "/js/**", 
            "/images/**", 
            "/favicon.ico"
        );
    }
}
