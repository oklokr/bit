package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.project.repository.BoardMapper;

public class BoardService {
    @Autowired
    private BoardMapper boardMapper;

    public int getCount(){
        return boardMapper.getCount();
    }
    

}
