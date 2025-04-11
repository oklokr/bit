package com.project.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.project.interceptor.SessionInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private static final String[] EXCLUDE_PATHS = {
        "/login",
        "/api/login",
        "/findId",
        "/findPw",
        "/join",
        "/findIdResult",
        "/findPwResult",
        "/joinStepUser/**",
        "/joinStepComp/**",
        "/findResult",
        "/resources/**",
        "/css/**",
        "/js/**",
        "/images/**",
        "/favicon.ico",
        "/joinResult",
        "/checkBusinessNumber",
        "/joinStepSuccess",
        "/mainTerms",
        "/subTerms"
    };

    @Autowired
    private SessionInterceptor sessionInterceptor;

    @Override
    public void addInterceptors(@NonNull InterceptorRegistry registry) {
        registry.addInterceptor(sessionInterceptor)
        .order(1)
        .addPathPatterns("/**")
        .excludePathPatterns(EXCLUDE_PATHS);
    }
}
