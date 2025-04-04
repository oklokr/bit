package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.model.BoardDto;
import com.project.repository.BoardMapper;

@Service
public class BoardService {
    @Autowired
    private BoardMapper boardmapper;

    public int getCount(){
        return boardmapper.getCount();
    }

    public List<BoardDto> getArticles(Map<String, Integer> map){
        return boardmapper.getArticles(map);
    }

    public BoardDto getArticle(int board_id){
        return boardmapper.getArticle(board_id);
    }

    public void addCount(int board_id){
        boardmapper.addCount(board_id);
    }

    public int insertPost(BoardDto boardDto){
        return boardmapper.insertPost(boardDto);
    }

    public int modifyPost(BoardDto boardDto){
        return boardmapper.modifyPost(boardDto);
    }

    public int deletePost(int board_id){
        return boardmapper.deletePost(board_id);
    }

    public int getReplyCount(int board_id){
        return boardmapper.getReplyCount(board_id);
    }

}
