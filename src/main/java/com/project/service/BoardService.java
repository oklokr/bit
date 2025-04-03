package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.repository.BoardMapper;

@Service
public class BoardService {
    @Autowired
    private BoardMapper boardmapper;

    public int getCount(){
        return boardmapper.getCount();
    }

}
